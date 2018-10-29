//
//  PaymentBottomView.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentBottomView : UIView

/// 折扣
@property (nonatomic,strong) UILabel *discountLabel;

/// 总额
@property (nonatomic,strong) UILabel *totalAmountLabel;

/// 去结算
@property (nonatomic,strong) UIButton *paymentBT;

@end
