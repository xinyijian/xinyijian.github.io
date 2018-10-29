//
//  MainModel.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/28.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"description" : @"shop_description", @"id" : @"Id"}];
}


@end

@implementation ShopModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"description" : @"shop_description", @"id" : @"Id"}];
}


@end

@implementation ProductModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"description" : @"shop_description", @"id" : @"Id"}];
}


@end

