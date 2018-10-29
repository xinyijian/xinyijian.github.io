//
//  OtherLogins.h
//  PattayaUser
//
//  Created by 明克 on 2018/5/16.
//  Copyright © 2018年 明克. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol OtherLoginsDelegate<NSObject>
- (void)otherSuccess:(NSInteger)typ NSNotification:(NSDictionary *)info;
@end

//typedef void(^OtherSuccess)(NSDictionary * dic);
@interface OtherLogins : NSObject
@property (nonatomic, weak) id<OtherLoginsDelegate> Loginsdelegate;
///qq登录
+ (BOOL)QQLogin;
///微信登录
+ (void)weChatLogin:(UIViewController *)controller;
///注册三方登录回调
+(void)registerOtherLoginsSuccess;
+(void)removeNotification;
@end
