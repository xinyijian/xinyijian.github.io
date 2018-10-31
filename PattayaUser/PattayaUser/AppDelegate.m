//
//  AppDelegate.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "DD_Alertview.h"
#import "ConfirmationOrderViewController.h"
#import<CoreLocation/CoreLocation.h>
#import "UpdateObject.h"
#import "ProtocolKit.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "AccountSafeVC.h"

//#import "DD_SpeechSynthesizer.h"
NSString* APP_BASE_URL;
extern CFAbsoluteTime StartTime;

@interface AppDelegate ()<WXApiDelegate,AMapLocationManagerDelegate,JPUSHRegisterDelegate,TencentSessionDelegate,TencentLoginDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isAppOptons;
@property (nonatomic, assign) BOOL isblureHeight;
@property (nonatomic, assign) BOOL isRelodate;
@property (nonatomic, assign) CGFloat hegihtStats;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    double launchTime = (CFAbsoluteTimeGetCurrent() - StartTime);
//    [PattayaTool INVALID_ACCESS_TOKEN];
    NSLog(@"---");
    application.applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
//    APP_BASE_URL = APP_TEST_URL;
    APP_BASE_URL = TANGNA;
//    APP_BASE_URL = APP_PROD_URL;
//    APP_BASE_URL = APP_DEV_URL;
    _isAppOptons = YES;
    _isblureHeight = NO;
    _isRelodate = NO;
    [self JPushRegisterInit:launchOptions];
    _locationAddress = [[AddressModel alloc]init];
    _locationAddress.formattedAddress = @"上海";
    NSLog(@"_%@",_locationAddress);
    [WXApi registerApp:@"wx122211556959a8b4"];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1106673029" andDelegate:self];
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = @"2118c4a0d309d4f493ab16ef0e9c360a";
    
    BaseTabBarViewController *baseTabBarVC = [[BaseTabBarViewController alloc] init];
    self.window.rootViewController = baseTabBarVC;
    [self.window makeKeyAndVisible];
    NSDictionary *resultDic = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (resultDic) {
        [self requestUserInfoOrder:resultDic];
    }
    [[UpdateObject singleton]checkUpdate];
    NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (![PattayaTool isNull:pushNotificationKey]) {
        [self requestUserInfoOrder:pushNotificationKey];
    }
    _hegihtStats = [UIApplication sharedApplication].statusBarFrame.size.height;
 
    
    return YES;
}


-(void)sendAuthReq:(SendAuthReq *)req viewController:(UIViewController *)vc
{
    [WXApi sendAuthReq:req viewController:vc delegate:self];
}
- (void)getTabbarVC
{
    BaseTabBarViewController *baseTabBarVC = [[BaseTabBarViewController alloc] init];
    self.window.rootViewController = baseTabBarVC;
}
- (void)JPushRegisterInit:(NSDictionary *)launchOptions
{
#ifdef DEBUG
    [JPUSHService setupWithOption:launchOptions appKey:@"1d94ac4cf9aa23740ce0fc53"
                          channel:@"ios"
                 apsForProduction:NO
            advertisingIdentifier:nil];
#else
    [JPUSHService setupWithOption:launchOptions appKey:@"1d94ac4cf9aa23740ce0fc53"
                          channel:@"ios"
                 apsForProduction:YES
            advertisingIdentifier:nil];
#endif
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {

    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //    [UMessage registerDeviceToken:deviceToken];
    NSString * string =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""];
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"%@",string);
}

/////iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    [self requestUserInfoOrder:userInfo];
//    if (@available(iOS 10.0, *)) {
//        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
//    } else {
//        // Fallback on earlier versions
//    }
//    
//    if (@available(iOS 10.0, *)) {
//        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//            [JPUSHService handleRemoteNotification:userInfo];
//        }
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 10.0, *)) {
//        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
//    } else {
//        // Fallback on earlier versions
//    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [self requestUserInfoOrder:userInfo];
    
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    application.applicationIconBadgeNumber = 0;
    // Required, iOS 7 Support
    // UIApplicationStateActive, 在前台运行
    // UIApplicationStateInactive,未启动app
    //UIApplicationStateBackground    app在后台
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {
//
//    } else
//    {
            NSLog(@"%@",userInfo);
//            [self requestUserInfoOrder:userInfo];
//    }
    
    [JPUSHService handleRemoteNotification:userInfo];
    [self requestUserInfoOrder:userInfo];
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
//    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)requestUserInfoOrder:(NSDictionary * )info
{
    
    [self callOrderIdState:info];
    
}
- (void)callOrderIdState:(NSDictionary *)info
{
    
    [[PattayaUserServer singleton] getcallorderRequest:info[@"CallOrderId"] Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            _dicOrder = ret[@"data"];
            ///司机接单
            if ([info[@"EventType"] isEqualToString:@"CallOrderDriverAccepted"]) {
                
                [self ReceiveOrderInformation:1 callorderId:info[@"CallOrderId"] Info:info];
            }///司机点击出发
            else if ([info[@"EventType"] isEqualToString:@"CallOrderDriverStarted"])
            {
                
            }///司机到达
            else if ([info[@"EventType"] isEqualToString:@"CallOrderDriverArrived"])
            {
                [self ReceiveOrderInformation:2 callorderId:info[@"CallOrderId"] Info:info];
                
            }///订单取消  订单被取消通知 CallOrderId: 召唤订单编号 CancelReason: DriverCancel(司机取消)、TimeoutCancel(系统因超时取消)、UnavailableCancel(系统 可 服务取消) CancelDescription:取消原因描述
            else if ([info[@"EventType"] isEqualToString:@"CallOrderCancelled"])
            {
                [self ReceiveOrderInformation:3 callorderId:info[@"CallOrderId"] Info:info];
                
            }///订单召唤失败 订单召唤超时或者附近  辆等情况
            else if ([info[@"EventType"] isEqualToString:@"CallOrderCancelled"])
            {
                [self ReceiveOrderInformation:3 callorderId:info[@"CallOrderId"] Info:info];
                
            }
        } else
        {
            // [self showToast:ret[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
    
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"%@",url);
    if ([url.absoluteString containsString:@"wx"]) {
        return  [WXApi handleOpenURL:url delegate:self];
        
    }else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
        
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
       return [WXApi handleOpenURL:url delegate:self];
        
    }else{
        return [TencentOAuth HandleOpenURL:url];
        
    }
    
    //    return  [WXApi handleOpenURL:url delegate:self];
    
}
// no equiv. notification. return NO if the application can't open for some reason
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    // [TencentOAuth HandleOpenURL:url];
    if ([url.absoluteString containsString:@"wx"]) {
        BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
        
        return  isSuc;
        
    }else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [TencentOAuth HandleOpenURL:url];
        
    }
    
    //    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    //    return  isSuc;
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp * rp = (SendAuthResp *)resp;
        if (rp.errCode == 0) {
            UIViewController * vcs = [PattayaTool findBestViewController:self.window.rootViewController];

            if ([vcs isKindOfClass:[AccountSafeVC class]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"KdthirdBindSuccess" object:@{@"code":rp.code}];
            } else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:KdLOGINTPYE object:@{@"code":rp.code}];

            }
        }
    }
}
///订单被接单了以后
- (void)ReceiveOrderInformation:(NSInteger)tpye callorderId:(NSString *)callorderId Info:(NSDictionary *)info
{
    UIViewController * vcs = [PattayaTool findBestViewController:self.window.rootViewController];
    //    NSLog(@"vcs = %@",vcs);
    if (tpye == 1) {
        DD_Alertview * alert = [[DD_Alertview alloc] initWithFrame:self.window.bounds stlyeView:DD_AlertviewStlyeNone navStatusHeight:0];
        if (![PattayaTool isNull:GetAppDelegate.dicOrder[@"relativeDistance"]]) {
            alert.distantText =  GetAppDelegate.dicOrder[@"relativeDistance"];
        }
        if (![PattayaTool isNull:GetAppDelegate.dicOrder[@"productCategoryName"]]) {
            alert.categoryText = GetAppDelegate.dicOrder[@"productCategoryName"];
        }
        if (![PattayaTool isNull:GetAppDelegate.dicOrder[@"reachTheTimeRequired"]]) {
            alert.needsTimeText = GetAppDelegate.dicOrder[@"reachTheTimeRequired"];
        }
        [alert show];
        alert.block = ^{
            if (![vcs isKindOfClass:[ConfirmationOrderViewController class]]) {
                ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
//                confirVC.orderId = callorderId;
                [vcs.navigationController pushViewController:confirVC animated:YES];
            }
        };
    }
    else if (tpye == 2)
    {
        DD_Alertview * alert = [[DD_Alertview alloc] initWithFrame:self.window.bounds stlyeView:DD_AlertviewStlyeDidDonw navStatusHeight:0];
        if (![PattayaTool isNull:info[@"Description"]]) {
            alert.locationLaber.text =info[@"Description"];
        }
        [alert show];
        
    }else if (tpye == 3)
    {
        if ([vcs isKindOfClass:[ConfirmationOrderViewController class]]) {
            
            NSString * message = @"";
            
            if (![PattayaTool isNull:info[@"CancelDescription"]]) {
                message = info[@"CancelDescription"];
            } else if(![PattayaTool isNull:info[@"aps"][@"alert"]])
            {
                message = info[@"aps"][@"alert"];
            }
            PTLAlertView * patlalert = [[PTLAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil) message:message cancelButtonTitle:nil otherButtonTitles:nil, nil];
            patlalert.titleBackgroundColor = BlueColor;
            patlalert.titleTextColor = [UIColor whiteColor];
            patlalert.cancelBtnTextColor = BlueColor;
            patlalert.otherBtnTextColor = BlueColor;
            [patlalert show];
            patlalert.selctBtnBlock = ^(NSInteger seleced, NSString * ss) {
//                if (seleced == 0) {
                    [vcs.navigationController popViewControllerAnimated:YES];
//                }
            };
        }
        //取消 订单
    }
    if ([vcs isKindOfClass:[ConfirmationOrderViewController class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KdConfirmationOrderViewController" object:@{@"orderId":callorderId,@"tpy":[NSString stringWithFormat:@"%ld",tpye]}];
        
    } else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KdCallOrderDriverAccepted" object:@{@"orderId":callorderId,@"tpy":[NSString stringWithFormat:@"%ld",tpye]}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KdCallDriverAcceptedFinViewController" object:@{@"orderId":callorderId,@"tpy":[NSString stringWithFormat:@"%ld",tpye]}];
    }
    
    
}
///登录成功回调
- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        [_tencentOAuth getUserInfo];
        
    }
    else
    {
        //        tokenLable.text = @"登录不成功 没有获取accesstoken";
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}
///登录失败后的回调
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}
///登录的时候网络是否有问题
- (void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
    
}

- (void)getUserInfoResponse:(APIResponse *)response {
    
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        
        NSDictionary *userInfo = [response jsonResponse];
        
        UIViewController * vcs = [PattayaTool findBestViewController:self.window.rootViewController];
        
        if ([vcs isKindOfClass:[AccountSafeVC class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdthirdQQ" object:@{@"QQ":userInfo}];
        } else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdQQlogin" object:@{@"QQ":userInfo}];

        }
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"KdQQsendingThirdParty" object:@{@"QQ":userInfo}];
        // 后续操作...
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}
//- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
//{
//    NSLog(@"%@ ==== %@",extraParams,permissions);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter]postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
 

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    BOOL bPersonalHotspotConnected = ([UIApplication sharedApplication].statusBarFrame.size.height==(20 + 20)?YES:NO);
//    if(bPersonalHotspotConnected)
//    {'
 
    if (_hegihtStats < [UIApplication sharedApplication].statusBarFrame.size.height) {
        if (_isblureHeight == NO) {
            if ([_viewControllerName isEqualToString:@"HomeViewController"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_STATUS_BAR_FRAME_NOTIFICATION" object:nil];
            }
        }
        _isblureHeight = YES;
    } else if (_hegihtStats == [UIApplication sharedApplication].statusBarFrame.size.height)
    {
        if (_isblureHeight == YES) {
        if ([_viewControllerName isEqualToString:@"HomeViewController"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_STATUS_BAR_FRAME_NOTIFICATION" object:nil];
        }
        }
        _isblureHeight = NO;
    }
    
    if (_isAppOptons == NO) {
   if ([_viewControllerName isEqualToString:@"ConfirmationOrderViewController"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ConfirmationOrderViewController" object:nil];
    }
    }
    _isAppOptons = NO;
 
//    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)timerinter{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(OrderStatusHttp) userInfo:nil repeats:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
///当前订单状态
- (void)OrderStatusHttp
{
    UIViewController * vcs = [PattayaTool findBestViewController:self.window.rootViewController];
    [[PattayaUserServer singleton] appDelegateProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            OrderDefModel * mode = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            if ([mode.status isEqualToString:@"CALL_SUCCESSFUL"]) {
                [self.timer invalidate];
                [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerUnderwayOrder AlerCallBlack:^(NSInteger index, NSString *titl) {
                    if (index == 0) {
                        if ([vcs isKindOfClass:[ConfirmationOrderViewController class]]) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdConfirmationOrderViewController" object:@{@"orderId":mode.id,@"tpy":[NSString stringWithFormat:@"%@",@"1"]}];
                        } else
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdCallOrderDriverAccepted" object:@{@"orderId":mode.id,@"tpy":[NSString stringWithFormat:@"%@",@"1"]}];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdCallDriverAcceptedFinViewController" object:@{@"orderId":mode.id,@"tpy":[NSString stringWithFormat:@"%@",@"1"]}];
                        }
                    }
                }];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
