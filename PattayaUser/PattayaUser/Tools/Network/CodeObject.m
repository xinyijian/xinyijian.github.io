//
//  CodeObject.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/12.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "CodeObject.h"
@interface CodeObject ()
@end
//static NSArray * codeArray = @[@"CALL_ORDER_NOT_FOUND",@"USER_PROCESSING_CALL_ORDER_EXIST"];
@implementation CodeObject
+ (NSInteger)codeFind:(NSDictionary *)retCode
{
    [self initArrayCode];
    if (![PattayaTool isNull:retCode[@"code"]]) {
        
        for (int i = 0; i < [CodeObject singleton].codeArray.count; i++) {
            if ([retCode[@"code"] isEqualToString:@"CALL_ORDER_NOT_FOUND"]) {
                ///查询当前订单状态.返回 1 是没有订单不提示message
                return 1;
            }
            if ([retCode[@"code"] isEqualToString:@"USER_PROCESSING_CALL_ORDER_EXIST"]) {
                ///点击下单.如果订单已经存在返回的信息
                return 2;
            }
            if ([retCode[@"code"] isEqualToString:@"CALL_ORDER_STATUS_ERROR"]) {
                ///用户取消订单,订单状态错误会报这个
                return 3;
            }
            if ([retCode[@"code"] isEqualToString:@"INVALID_ACCESS_TOKEN"]) {
                ///token过期
                //            return 401;
                return 401;
                
            }
            if ([retCode[@"code"] isEqualToString:@"VEHICLE_STATUS_INVALID"]) {
                ///门店状态非法
                return 405;
            }
            if ([retCode[@"code"] isEqualToString:@"INVALID_ACCESS_TOKEN"]) {
                ///重新登录
                return 1;
            }
            if ([retCode[@"code"] isEqualToString:@"CALL_ORDER_RESERVATION_ERROR"]) {
                ///预约时间错误
                return 4;
            }
        }

    
    }
    return 0;
}

+ (void)initArrayCode
{
     [CodeObject singleton].codeArray = @[@"CALL_ORDER_NOT_FOUND",@"USER_PROCESSING_CALL_ORDER_EXIST",@"INVALID_ACCESS_TOKEN",@"CALL_ORDER_STATUS_ERROR",@"OPEN_ID_NOT_BINDED"];
}
@end
