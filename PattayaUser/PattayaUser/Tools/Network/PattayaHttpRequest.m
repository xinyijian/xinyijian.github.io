//
//  PattayaHttpRequest.m
//  pattaya-dri
//
//  Created by 明克 on 2018/2/25.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import "PattayaHttpRequest.h"
#import <MBProgressHUD.h>
#import "PattAmapLocationManager.h"
#import "Reachability.h"
#import "BaseNavigationViewController.h"
#import "LogInViewController.h"
#import "BaseViewController.h"
#import "UserInfo.h"
static NSString * const MIDDLE_PORT = @"";
@interface PattayaHttpRequest ()
@property (nonatomic, strong) Reachability *reachability;
@end
@implementation PattayaHttpRequest
{
//    LDJActivityIndicator *_activityIndicator;//菊花
    MBProgressHUD *loadingView;
    
}
static PattayaHttpRequest *httpRequest = nil;

///json
+ (instancetype)sharedHttpManager
{
    
    //option2:only called onces so BaseURL will be same all time.
    httpRequest = [[PattayaHttpRequest alloc]initWithBaseURL:[NSURL URLWithString:APP_BASE_URL]];
    
    httpRequest.requestSerializer.timeoutInterval = 60;
    
    httpRequest.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置返回格式
    
    httpRequest.responseSerializer = [AFJSONResponseSerializer serializer];
    httpRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];//如果报接受类型不一致请替换一致text/html或别的
    
    
    return httpRequest;
}

///from
+ (instancetype)newHttpManager
{
    httpRequest = [[PattayaHttpRequest alloc]initWithBaseURL:[NSURL URLWithString:APP_BASE_URL]];
    
    httpRequest.requestSerializer.timeoutInterval = 60;
    /// httpRequest.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置返回格式
    httpRequest.responseSerializer = [AFJSONResponseSerializer serializer];
    httpRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];//如果报接受类型不一致请替换一致text/html或别的
    
    return httpRequest;
}
-(void)addHeader{
        if( ![PattayaTool isNull:[PattAmapLocationManager singleton].lng] && ![PattayaTool isNull:[PattAmapLocationManager singleton].lat] ){
                    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",[PattAmapLocationManager singleton].lng] forHTTPHeaderField:@"X-Location-Longitude"];
                    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",[PattAmapLocationManager singleton].lat] forHTTPHeaderField:@"X-Location-Latitude"];
            NSLog(@"经纬度 %@ --- %@",[PattAmapLocationManager singleton].lng,[PattAmapLocationManager singleton].lat);
        }
    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    NSLog(@"语言===%@",languageName);
    if ([languageName containsString:@"zh"]) {
        [self.requestSerializer setValue:@"zh_CN" forHTTPHeaderField:@"X-Accept-Locale"];

    } else
    {
        [self.requestSerializer setValue:@"EN" forHTTPHeaderField:@"X-Accept-Locale"];

    }


    if ([PattayaTool isUserLogin]) {
        [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserInfo singleton].token] forHTTPHeaderField:@"Authorization"];
        NSLog(@"====  %@",[NSString stringWithFormat:@"Bearer %@",[UserInfo singleton].token]);
    }

    
    //    //21:IOS
    //    [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"x-sw-channel"];
    //    //10-用户端
    //    [self.requestSerializer setValue:@"10" forHTTPHeaderField:@"x-sw-ctype"];
    //    [self.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"x-sw-cversion"];
    //    ///安卓 1 ,, ios 2
    //    [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"x-sw-devicetype"];
    
    
}

//delete 方法
- (void)DeleteWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{

    
    if (![urlPath containsString:@"pub"]) {
        
        [self addHeader];
    }
    //-----打印请求信息 ------
        NSLog(@"请求网址URL：%@%@%@",APP_BASE_URL,MIDDLE_PORT,urlPath);
        NSLog(@"传参：%@",parameter);
    //_______________________________
    //获取用户当前所处的页面
    UIViewController* vc= [PattayaTool findBestViewController:[PattayaTool getCurrentVC]];
    if (isNeedIndicator) {
        [self showLoading:vc];
        
    }

    [self DELETE:[MIDDLE_PORT stringByAppendingString:urlPath] parameters:parameter  success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nullable responseObject) {
        [self hideLoading];
        
        [self codeIsAccessToken:[CodeObject codeFind:responseObject]];

        success(operation,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        [self hideLoading];
        if ([error.userInfo[@"NSLocalizedDescription"] containsString:@"401"]) {
            [self isAccessToken:@"INVALID_ACCESS_TOKEN"];
        }
        failure(operation,error);

        if (isNeedIndicator) {
            
        }
        [vc.view isHidden];
        //        [vc.view showMessage:@"无法连接到服务器，请重试" image:@"reminder_icon" toView:vc.view];
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            [self LogHttpHead:operation];
        }
        NSLog(@"operation = %@\nerror = %@",operation,[error userInfo][@"com.alamofire.serialization.response.error.string"]);
        NSLog(@"error = %@",error.localizedDescription);
        
        // failure(operation,error);
    }];
}

//PUT 方法
- (void)PUTWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
 
    self.requestSerializer.timeoutInterval = 10;
    if (![urlPath containsString:@"pub"]) {
    
        [self addHeader];
    }
    //-----打印请求信息 ------
        NSLog(@"请求网址URL：%@%@%@",APP_BASE_URL,MIDDLE_PORT,urlPath);
        NSLog(@"传参：%@",parameter);
    //_______________________________
    //获取用户当前所处的页面
    UIViewController* vc= [PattayaTool findBestViewController:[PattayaTool getCurrentVC]];
    if (isNeedIndicator) {
        [self showLoading:vc];
        
    }

    [self PUT:[MIDDLE_PORT stringByAppendingString:urlPath] parameters:parameter  success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nullable responseObject) {
        [self hideLoading];
        
        [self codeIsAccessToken:[CodeObject codeFind:responseObject]];

        success(operation,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        [self hideLoading];
        if ([error.userInfo[@"NSLocalizedDescription"] containsString:@"401"]) {
            [self isAccessToken:@"INVALID_ACCESS_TOKEN"];
        }
        failure(operation,error);
        if (isNeedIndicator) {
            
        }
        [vc.view isHidden];
        //        [vc.view showMessage:@"无法连接到服务器，请重试" image:@"reminder_icon" toView:vc.view];
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            [self LogHttpHead:operation];
        }
        NSLog(@"operation = %@\nerror = %@",operation,[error userInfo][@"com.alamofire.serialization.response.error.string"]);
        NSLog(@"error = %@",error.localizedDescription);
        
        // failure(operation,error);
    }];
}
//get 方法
- (void)getWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    self.requestSerializer.timeoutInterval = 10;

    if (![urlPath containsString:@"pub"]) {
    
        [self addHeader];
    }
//    [self addHeader];
    
    //-----打印请求信息 ------
        NSLog(@"请求网址URL：%@%@%@",APP_BASE_URL,MIDDLE_PORT,urlPath);
        NSLog(@"传参：%@",parameter);
    //_______________________________
    //获取用户当前所处的页面
    UIViewController* vc= [PattayaTool findBestViewController:[PattayaTool getCurrentVC]];
    if (isNeedIndicator) {
        [self showLoading:vc];
        
    }
    [self GET:[MIDDLE_PORT stringByAppendingString:urlPath] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nullable responseObject) {
        [self hideLoading];
        [self codeIsAccessToken:[CodeObject codeFind:responseObject]];

        
        success(operation,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        [self hideLoading];
        if ([error.userInfo[@"NSLocalizedDescription"] containsString:@"401"]) {
            [self isAccessToken:@"INVALID_ACCESS_TOKEN"];
        }
        if (isNeedIndicator) {
         
        }
        [vc.view isHidden];
//        [vc.view showMessage:@"无法连接到服务器，请重试" image:@"reminder_icon" toView:vc.view];
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            [self LogHttpHead:operation];
        }
        failure(operation,error);

        NSLog(@"operation = %@\nerror = %@",operation,[error userInfo][@"com.alamofire.serialization.response.error.string"]);
        NSLog(@"error = %@",error.localizedDescription);
        
        // failure(operation,error);
    }];
}

//post 方法
- (void)postWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{

    self.requestSerializer.timeoutInterval = 10;

    if (![urlPath containsString:@"pub"]) {
    
        [self addHeader];
    }
    
   
    
    //-----打印请求信息 ------
    NSLog(@"请求网址URL：%@%@%@",APP_BASE_URL,MIDDLE_PORT,urlPath);
    NSLog(@"传参：%@",parameter);
    //_______________________________
    //获取用户当前所处的页面
    
    UIViewController* vc= [PattayaTool findBestViewController:[PattayaTool getCurrentVC]];
    [self showLoading:vc];
    [self POST:[MIDDLE_PORT stringByAppendingString:urlPath] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nullable responseObject) {
        [self hideLoading];
//        [self isAccessToken:responseObject[@"code"]];
        [self codeIsAccessToken:[CodeObject codeFind:responseObject]];
        success(operation,(NSDictionary*)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable operation, NSError * _Nonnull error) {
        
        [self hideLoading];
        if ([error.userInfo[@"NSLocalizedDescription"] containsString:@"401"]) {
            [self isAccessToken:@"INVALID_ACCESS_TOKEN"];
        }
//        NSLog(@"%@",[operation.response statusCode]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
        NSLog(@"status code: %li", (long)httpResponse.statusCode);
        failure(operation,error);
     
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            [self LogHttpHead:operation];
        }
//        [vc.view showMessage:@"无法连接到服务器，请重试" image:@"reminder_icon" toView:vc.view];
        NSLog(@"operation = %@\nerror = %@",operation,[error userInfo][@"com.alamofire.serialization.response.error.string"]);
        failure(operation,error);
    }];
}



- (void)LogHttpHead:(NSURLSessionDataTask *)operation
{
    if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
        NSURLRequest *responses = (NSURLRequest *)operation.currentRequest;
        NSMutableURLRequest *responsea = (NSMutableURLRequest *)operation.originalRequest;
        
        //  NSDictionary *allHeaders = response.allHeaderFields;
        NSString * boyd = [[NSString alloc] initWithData:responsea.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"allHeaders =%@, =  %@, = %@  boyd = %@, operation  = %@",response,responses,responsea,boyd,operation);
        
    }
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
//检测网络连接状态
- (void)isConnectionAvailable
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    // 设置网络检测的站点
    NSString *remoteHostName = @"www.baidu.com";
    self.reachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.reachability startNotifier];
    [self updateInterfaceWithReachability:self.reachability];
    
}
- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability* curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == _reachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus)
        {
            case NotReachable:   {
                NSLog(@"没有网络！");
                BLOCK_EXEC(_available,YES);
                break;
            }
            case ReachableViaWWAN: {
                NSLog(@"4G/3G");
                BLOCK_EXEC(_available,NO);

                break;
            }
            case ReachableViaWiFi: {
                NSLog(@"WiFi");
                BLOCK_EXEC(_available,NO);

                break;
            }
        }
    }
}

- (void)codeIsAccessToken:(NSInteger)code
{
   if (code == 401)
   {
//       [PattayaTool INVALID_ACCESS_TOKEN];
       BaseViewController* vc= (BaseViewController*)[PattayaTool getCurrentVC];
       BaseNavigationViewController * nav = [[BaseNavigationViewController alloc] initWithRootViewController:[[LogInViewController alloc]init]];
       [vc presentViewController:nav animated:YES completion:nil];
   }
}

- (void)isAccessToken:(NSString *)code
{
    if(![PattayaTool isNull:code])
    {
   
    if ([code isEqualToString:@"INVALID_ACCESS_TOKEN"]) {
        [PattayaTool INVALID_ACCESS_TOKEN];

        BaseViewController* vc= (BaseViewController*)[PattayaTool getCurrentVC];
        BaseNavigationViewController * nav = [[BaseNavigationViewController alloc] initWithRootViewController:[[LogInViewController alloc]init]];
        [vc presentViewController:nav animated:YES completion:^{
            //每次弹出以后，切换至首页
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSelectedIndex" object:nil];
        }];
       
    }
        
    }
    
}

- (void)dealloc
{
    [_reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}
@end
