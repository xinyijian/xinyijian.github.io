//
//  YDBaseWebController.m
//  ZXCashATM
//
//  Created by iOS on 2018/9/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YDBaseWebController.h"
#import <WebKit/WebKit.h>

@interface YDBaseWebController () <WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation YDBaseWebController

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - 懒加载
- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
        _progressView.tintColor = App_ThemeColor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

#pragma mark - 设置UI
- (void)setupUI
{
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled =YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically =NO;
    
    NSMutableString *javascript = [NSMutableString string];
    //禁止长按
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    //禁止选择
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    webView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopBarHeight);
    self.webView = webView;
    
    [webView.configuration.userContentController addUserScript:noneSelectScript];
    webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = YES;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:webView];
    [self.view addSubview:self.progressView];
    
    if (self.urlStr) {
        NSURL *url = [NSURL URLWithString:self.urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            
            [self.progressView setProgress:1 animated:NO];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - WKNavigationDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end










































