//
//  OrderViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderListModel.h"
@interface OrderViewController : BaseViewController
@property (nonatomic, strong) ListOrderModel * model;
@property (nonatomic, strong) NSString * orderTotal;

@end
