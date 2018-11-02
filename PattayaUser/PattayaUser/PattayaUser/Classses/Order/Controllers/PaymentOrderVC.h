//
//  PaymentOrderVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseTBController.h"

@interface PaymentOrderVC : YDBaseTBController

//支付码
@property (nonatomic, strong) NSString *payBusinessCode;

/**
 设置数据源
 */
@property (nonatomic, strong) ShopModel *shopModel;

@end
