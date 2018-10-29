//
//  UserInfo.m
//  pattaya-dri
//
//  Created by 明克 on 2018/2/25.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
- (NSString *)name
{
    return [PattayaTool driName];
}
- (NSString *)mobile
{
    return [PattayaTool mobileDri];
}
- (NSString *)token
{
    return [PattayaTool token];
}
@end
