//
//  PattayaTool.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PattayaTool : NSObject
+ (BOOL)isNull:(id)obj;
+ (void)shadowColorAndShadowOpacity:(UIView *)view color:(NSString *)strColor Alpha:(CGFloat)alpha;
+ (void)phoneNumber:(NSString *)tel;
+ (void)goNavtionMap:(NSString *)lat log:(NSString *)ln;
+ (UIViewController *)getCurrentVC;
+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;
#pragma mark -- 存储登录
+ (BOOL)loginSaveToken:(NSString *)token;
+ (BOOL)loginSavename:(NSString *)name mobile:(NSString *)mobile;
#pragma mark -- 是否登录
+ (BOOL)isUserLogin;
+ (NSString *)driName;
+ (NSString *)mobileDri;
+ (NSString *)token;
//+ (BOOL)outLogin;
///签到 存 签到车辆号牌
+ (BOOL)chenkLogin:(NSString *)code;
///取订单用户的手机号用于显示
+ (NSString *)OrderPhone;
+ (void)INVALID_ACCESS_TOKEN;
+ (BOOL)isUserLoginStats;
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;
+ (UIViewController*)findBestViewController:(UIViewController*)vc;
+ (UIAlertController *)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
+ (NSString *)loadPlistPath:(NSString *)path;
+ (NSString *)loadToken;
//读取内容
+ (NSDictionary *)contentsOffile:(NSString *)textName;
+ (BOOL)writeTofilePlist:(NSString *)textName text:(NSDictionary *)dic;
+ (NSString *)loadUpToken;
+ (NSString *)ConvertStrToTime:(NSString *)timeStr Fromatter:(NSString *)foramt;
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font sizemake:(CGSize) withsize;

@end
