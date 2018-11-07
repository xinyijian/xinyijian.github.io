//
//  OrderDetailVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseTBController.h"
#import "OrderListModel.h"
#import "ProccesingModel.h"
@interface OrderDetailVC : YDBaseTBController

@property (nonatomic,assign) NSInteger enterType; //0:全部订单 1:进行中2:已取消3退款订单

@property (nonatomic,strong) ListOrderModel * orderModel;

@property (nonatomic,strong) ProccesingModel * proccesingModel;

//@property (nonatomic,strong) NSString * list;


@end
