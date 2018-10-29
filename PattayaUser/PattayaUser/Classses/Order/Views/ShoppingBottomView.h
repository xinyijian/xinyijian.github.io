//
//  ShoppingBottomView.h
//  PattayaUser
//
//  Created by yanglei on 2018/9/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingBottomView : UIView

/// 购物车
@property (nonatomic,strong) UIButton *shopCarBT;

/// 总数
@property (nonatomic,strong) UILabel *countLabel;

/// 总额
@property (nonatomic,strong) UILabel *totalAmountLabel;

/// 去结算
@property (nonatomic,strong) UIButton *settleAccountsBT;


@end
