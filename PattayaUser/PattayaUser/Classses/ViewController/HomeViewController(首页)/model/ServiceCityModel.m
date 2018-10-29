//
//  ServiceCityModel.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ServiceCityModel.h"

@implementation ServiceCityModel

@end
@implementation cityListModel


- (NSString *)stringCanperNumberCityCode:(NSString * )str
{
    return [[str substringToIndex:str.length - 2]stringByAppendingString:@"00"];
}


- (BOOL)cityService:(NSString *)cityCode
{
    if ([PattayaTool isNull:cityCode]) {
        NSLog(@"cityCode === nil ,城市code没有传,或者为空");
        return NO;
    }
   NSString * cityIds =  [self stringCanperNumberCityCode:cityCode];
    NSLog(@"city = %@ ,,,, === %@",cityIds,cityCode);
    for (ServiceCityModel * mode in self.data) {
        if ([mode.cityId isEqualToString:cityIds]) {
            return YES;
        }
    }
    return NO;
}

@end

