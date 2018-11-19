//
//  WebHelpViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "WebHelpViewController.h"

@interface WebHelpViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *loadingView;

}
@property (nonatomic,strong) UIWebView * webView;
@end

@implementation WebHelpViewController
- (UIWebView *)webView   {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView activateConstraints:^{
        self.webView.top_attr = self.view.top_attr_safe;
        self.webView.bottom_attr = self.view.bottom_attr_safe;
        self.webView.right_attr = self.view.right_attr_safe;
        self.webView.left_attr = self.view.left_attr_safe;
    }];
    self.webView.backgroundColor = [UIColor whiteColor];
    //[self loadString:_httpString];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"叮咚叫店APP协议20181026" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [self.webView loadHTMLString:htmlString baseURL:url];
    // Do any additional setup after loading the view.
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr;
    if (![PattayaTool isNull:str]) {
        urlStr = [NSString stringWithFormat:@"%@", str];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

    [self showLoading:self];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLoading];
    //    self.customTitle =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
{
    [self hideLoading];
}

- (void)showLoading:(UIViewController *)views
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(loadingView == nil){
            loadingView = [[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 64 + 60, SCREEN_Width, views.view.frame.size.height-64 - 60)];
            loadingView.backgroundColor = [PattayaTool colorWithHexString:@"1F1F21" Alpha:0.2];
            [views.view addSubview:loadingView];
            [loadingView showAnimated:YES];
            loadingView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                loadingView.alpha = 1;
                
            }];
        }
    });
    
}
- (void)hideLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(loadingView != nil){
            
            loadingView.alpha = 1;
            [UIView animateWithDuration:0.5 animations:^{
                loadingView.alpha = 0;
                [loadingView hideAnimated:YES];
                [loadingView removeFromSuperview];
                loadingView = nil;
            }];
            
        }
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
