//
//  YDPredicate.h
//  YD-MVVM框架
//
//  Created by iOS on 2018/4/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPredicate : NSObject

+ (BOOL)canUserCamara:(UIView *)showView;

// 判断是否是全中文
+ (BOOL)deptNameInputShouldChinese:(NSString *)text;
// 判断是否为空的字符串
+ (BOOL)isEmptyStr:(id)obj;
+ (BOOL)isEmptyObj:(id)obj;
// 判断是否为正确格式的手机号
+ (BOOL)isTureMobile:(NSString *)phone;
// 判断是否为正确格式的身份证号
+ (BOOL)IsIdentityCard:(NSString *)value;
// 密码中必须同时包含数字和字母 - 不限制特殊字符
+ (BOOL)isValidPasswordString:(NSString *)password;
//// 判断银行卡的合法性
//+ (BOOL)IsBankCard:(NSString *)cardNumber;

@end
