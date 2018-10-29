//
//  ShopMainVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseController.h"
#import "MainModel.h"
@interface ShopMainVC : YDBaseController

//店铺id
@property (nonatomic , copy) NSString *GroupID;

/**
 设置数据源
 */
@property (nonatomic, strong) ShopModel *model;

@end
