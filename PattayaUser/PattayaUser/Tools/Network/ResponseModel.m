//
//  ResponseModel.m
//  pattaya-dri
//
//  Created by 明克 on 2018/2/25.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import "ResponseModel.h"

@implementation ResponseModel
+ (BOOL)isSucceed:(NSDictionary*)dic
{
    
    BOOL success = [self isData:dic];
    if (success) {
        if (![PattayaTool isNull:dic[@"data"]]) {
            if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
                if ([dic[@"data"] count] > 0) {
                    return YES;
                }
                return NO;
            }
            return YES;
        }
    }
    return NO;
    
}
+ (BOOL)isData:(NSDictionary *)dic
{
    if(dic == nil){
        return NO;
    }
    NSNumber * success = [dic objectForKey:@"success"];
    
    if ([PattayaTool isNull:dic[@"code"]])
    {
        if (success.boolValue) {
            return YES;
        }else
            return NO;
    }else
        return NO;
}
@end
