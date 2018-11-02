//
//  StoreListModel.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "StoreListModel.h"


@implementation StoreGoodsListModel
@end


@implementation StoreDefileModel
+ (JSONKeyMapper*)keyMapper
{
   
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"categoryDescription":@"description"
                                                                  }];
}
@end
@implementation StoreListModel

@end
