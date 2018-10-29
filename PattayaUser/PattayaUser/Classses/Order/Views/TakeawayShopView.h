//
//  TakeawayShopView.h
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"
@interface TakeawayShopView : UIView

//店铺ID
@property (nonatomic , copy) NSString *groupId;

/**
 设置数据源
 */
@property (nonatomic, strong) ShopModel *model;

- (id)initWithFrame:(CGRect)frame  withGroupID:(NSString *)groupId;

@end
