//
//  YDProgressHUD.h
//  FLK-TourismApp
//
//  Created by iOS on 2018/5/2.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

// 网络请求的结果
typedef NS_ENUM(NSInteger, YDNetResultStatus) {
    // 成功：从父视图移除
    YDNetResultSuccess,
    // 没数据：不移除，提示空数据
    YDNetResultEmtyp,
    // 失败：不移除，提示错误信息
    YDNetResultFaiure
};

typedef void(^YDReloadHUD)(void);

@interface YDProgressHUD : NSObject

#pragma mark - 展示一个空的界面
+ (MBProgressHUD *)showEmptyHUD:(NSString *)message
                        imgName:(NSString *)imgName
                           view:(UIView *)toView;

#pragma mark - 网络开始和结束请求HUD
+ (MBProgressHUD *)showLoading:(NSString *)message
                          view:(UIView *)toView
                         block:(YDReloadHUD)reloadBlock;

+ (void)endLoadingWithMessage:(NSString *)message
                      imgName:(NSString *)imgName
                         view:(UIView *)forView;

#pragma mark - 只显示提示语
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)toView;

#pragma mark - 显示和隐藏菊花HUD
/// 显示
+ (MBProgressHUD *)showHUD:(NSString *)message
                    toView:(UIView *)toView;
+ (MBProgressHUD *)showHUD:(NSString *)message;
/// 隐藏
+ (void)hiddenHUD:(UIView *)forView;
+ (void)hiddenHUD;

@end












