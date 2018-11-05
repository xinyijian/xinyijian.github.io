//
//  OrderDetailVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseTBController.h"
#import "OrderListModel.h"

@interface OrderDetailVC : YDBaseTBController

@property (nonatomic,assign) NSInteger enterType;
@property (nonatomic,strong) ListOrderModel * orderModel;
//@property (nonatomic,strong) NSString * list;


@end
