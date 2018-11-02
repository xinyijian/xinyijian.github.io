//
//  YDProgressHUD.m
//  FLK-TourismApp
//
//  Created by iOS on 2018/5/2.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YDProgressHUD.h"
#import "ReplicatorView.h"

static NSString *lastMessage;

#define HUDOffsetY IPhone_7_Scale_Width(72.0)

@implementation YDProgressHUD

#pragma mark - 展示一个空的界面
+ (MBProgressHUD *)showEmptyHUD:(NSString *)message
                        imgName:(NSString *)imgName
                           view:(UIView *)toView
{
    MBProgressHUD *hud = [self yd_progressHUD:toView animated:NO];
    hud.backgroundColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.label.text = message;
    hud.contentColor = App_TitleGrayColor;

    UIImage *image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = imageView;

    return hud;
}

#pragma mark - 基础的HUD
+ (MBProgressHUD *)yd_progressHUD:(UIView *)toView animated:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:toView animated:NO];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:animated];
    hud.userInteractionEnabled = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.font = UISystemFont(16);
    hud.label.numberOfLines = 0;
    // 文字和菊花的颜色
    hud.contentColor = [UIColor whiteColor];
    hud.offset = CGPointMake(hud.bezelView.YD_x, hud.bezelView.YD_y - HUDOffsetY);
    hud.margin = IPhone_7_Scale_Width(15);
    hud.animationType = MBProgressHUDAnimationFade;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    return hud;
}

#pragma mark - 网络开始和结束请求HUD
/// 开始网络请求
+ (MBProgressHUD *)showLoading:(NSString *)message
                          view:(UIView *)toView
                         block:(YDReloadHUD)reloadBlock
{
    MBProgressHUD *hud = [self yd_progressHUD:toView animated:NO];
    hud.tag = 1234;
    hud.backgroundColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.label.text = message;
    hud.contentColor = App_TitleGrayColor;
    /// 在加载中禁止点击回调
    hud.bezelView.userInteractionEnabled = NO;
    
    hud.mode = MBProgressHUDModeCustomView;
    ReplicatorView *loadingView = [ReplicatorView showReplicatorLoading];
    hud.customView = loadingView;
    
    if (reloadBlock) {
        [self addTapGesture:hud message:message block:reloadBlock];
    }
    
    return hud;
}

/// 添加手势
+ (void)addTapGesture:(MBProgressHUD *)hud
              message:(NSString *)message
                block:(YDReloadHUD)reloadBlock
{
    @weakify(hud);
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        @strongify(hud);
        
        // 网络可用的时候才开始回调 - 重新请求刷新数据
        if (App_Delegate.yd_whetherHaveNetwork) {
            
            hud.bezelView.userInteractionEnabled = NO;
            hud.label.text = message;
        
            ReplicatorView *loadingView = [ReplicatorView showReplicatorLoading];
            hud.customView = loadingView;
            
            reloadBlock();
            
        }else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"网络失败"]];
            hud.customView = imageView;
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.text = @"无法访问网络，请检查网络环境";
        }
    }];
    
    [hud.bezelView addGestureRecognizer:tap];
}

/// 结束网络请求 
+ (void)endLoadingWithMessage:(NSString *)message
                      imgName:(NSString *)imgName
                         view:(UIView *)forView
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:forView];
    
    if (hud == nil) { return; }
    
    if ([hud.customView isKindOfClass:[ReplicatorView class]]) {
        ReplicatorView *loadingView = (ReplicatorView *)hud.customView;
        [loadingView disMissReplicatorLoading];
    }

    UIImage *image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = imageView;
    hud.label.text = message;
    /// 加载结束的允许点击回调刷新
    hud.bezelView.userInteractionEnabled = YES;
}

#pragma mark - 提示信息
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [YDProgressHUD showMessage:message toView:App_Delegate.window];
    hud.offset = CGPointMake(hud.bezelView.YD_x, hud.bezelView.YD_y - HUDOffsetY + TopBarHeight * 0.5);
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)toView
{
    // 当message为空 
    if ([YDPredicate isEmptyStr:message]) { return nil; }
    
    BOOL animated = YES;
    // 提示信息和之前的一样，移除上一次的提示
    if ([lastMessage isEqualToString:message]) {
        
        [MBProgressHUD hideHUDForView:toView animated:NO];
        
        animated = NO;
    }

    lastMessage = message;
    
    MBProgressHUD *hud = [self yd_progressHUD:toView animated:animated];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:2.5f];

    return hud;
}

#pragma mark - 弹出档板HUD
+ (MBProgressHUD *)showHUD:(NSString *)message toView:(UIView *)toView
{
    MBProgressHUD *hud = [self yd_progressHUD:toView animated:YES];
    hud.label.text = message;
    return hud;
}

+ (MBProgressHUD *)showHUD:(NSString *)message
{
    MBProgressHUD *hud = [self yd_progressHUD:App_Delegate.window animated:YES];
    hud.label.text = message;
    return hud;
}

#pragma mark - 隐藏档板HUD
+ (void)hiddenHUD:(UIView *)forView
{
    [MBProgressHUD hideHUDForView:forView animated:NO];
}

+ (void)hiddenHUD
{
    [MBProgressHUD hideHUDForView:App_Delegate.window animated:NO];
}

@end























