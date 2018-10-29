//
//  AppDelegate.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "ServiceCityModel.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <WXApi.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AddressModel * locationAddress;
@property (strong, nonatomic) NSNumber * longitude;
@property (strong, nonatomic) NSNumber * latitude;
@property (strong, nonatomic) cityListModel * cityModel;
@property (strong, nonatomic) TencentOAuth * tencentOAuth;
@property (nonatomic, strong) NSDictionary * dicOrder;
@property (nonatomic, strong) NSString * viewControllerName;
- (void)getTabbarVC;
-(void)sendAuthReq:(SendAuthReq *)req viewController:(UIViewController *)vc;
- (void)timerinter;

/// 判断网络是否连接
@property (assign, nonatomic) BOOL yd_whetherHaveNetwork;
/// 判断网络是否连接
@property (  copy, nonatomic) NSString *networkStatus;
@end

