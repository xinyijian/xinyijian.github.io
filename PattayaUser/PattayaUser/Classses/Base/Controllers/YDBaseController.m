//
//  YDBaseController.m
//  项目通用框架
//
//  Created by sqj on 17/3/27.
//  Copyright © 2017年 zsmy. All rights reserved.
//

#import "YDBaseController.h"

@interface YDBaseController () <UIGestureRecognizerDelegate>

@end

@implementation YDBaseController
static char buttonActionBlockKey;
- (void)dealloc
{
    YDLog(@"释放了: --- %s", object_getClassName(self));
}

- (void)viewDidLoad {
    
    /// 初始化数据
    [self setupData];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = App_TotalGrayWhite;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.presentedViewController) {
        [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:animated];
    }else {
        self.navigationController.navigationBarHidden = self.navigationBarHidden;
    }
    
    if (self.navStyle == NavgationStyleDefalute) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];

    }else {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
    }

    [self.navigationController.navigationBar setNavBarStyle:self.navStyle];
}

#pragma mark - 基础方法 - a
/// 初始化数据
- (void)setupData
{
    self.navStyle = NavgationStyleDefalute;
    self.progressType = YDProgressTypeNone;
    self.navigationBarHidden = NO;
    self.isGestureRecognizerBack = YES;
    
    self.errorTitle = @"网络加载失败，请重新加载";
    self.emptyTitle = @"暂无数据";
    
    self.errorImgName = @"网络失败";
    self.emptyImgName = @"没有数据";
}

/// 初始化UI
- (void)setupUI{}

/// 开始网络请求
- (MBProgressHUD *)setupRequest {

    [self netRequestData];
    
    if (self.progressType == YDProgressTypeCover) {
        
        @weakify(self);
    
        return [YDProgressHUD showLoading:@"加载中..." view:self.view block:^{
            @strongify(self);
            [self netRequestData];
        }];
    }
    
    if (self.progressType == YDProgressTypeBezel) {
        return [YDProgressHUD showHUD:@"加载中..." toView:self.view];
    }
    
    return nil;
}

/// 网络请求数据, 子类重写
- (void)netRequestData{}

//  请求处理的结果，有需要可以在子类重写
- (void)handleNetReslut:(YDNetResultStatus)status
{
    /// 1. 请求成功的时候直接移除
    if (status == YDNetResultSuccess) {
        [YDProgressHUD hiddenHUD:self.view];
        return;
    }
    
    /// 2. 请求失败的时候根据情况判断
    if (self.progressType == YDProgressTypeCover) {
        
        NSString *message = status == YDNetResultEmtyp ? self.emptyTitle : self.errorTitle;
        NSString *imgName = status == YDNetResultEmtyp ? self.emptyImgName : self.errorImgName;
        
        [YDProgressHUD endLoadingWithMessage:message imgName:imgName view:self.view];
        
    }else if (self.progressType == YDProgressTypeBezel) {
        
        [YDProgressHUD hiddenHUD:self.view];
        
        [YDProgressHUD showMessage:self.errorTitle toView:self.view];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    /// 根视图不允许滑动返回，否则会出现界面卡死的bug
    if (self.navigationController.childViewControllers.count <= 1) {
        return NO;
    }

    return self.isGestureRecognizerBack;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


//左按钮返回键
- (void)leftBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void (^)(void))actionBlock{
    UIButton *button = [self buttonWithTitle:title buttonImage:image];
    button.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.leftBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}
/** 右边按钮 */
- (void)rightBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void (^)(void))actionBlock{
    
    UIButton *button = [self buttonWithTitle:title buttonImage:image];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (UIButton *)buttonWithTitle:(NSString *)title buttonImage:(UIImage *)image{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.widthBee = 60;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    button.tintColor=[UIColor colorWithHexString:@"E61C62"];
    button.tintColor=[UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = K_LABEL_SMALL_FONT_14;
    [button sizeToFit];
    
    return button;
}

- (void)actionButtonClicked:(UIButton *)sender{
    
    void (^actionBlock) (void) = objc_getAssociatedObject(sender, &buttonActionBlockKey);
    actionBlock();
}
@end
