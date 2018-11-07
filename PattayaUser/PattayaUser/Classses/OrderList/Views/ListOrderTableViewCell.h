//
//  ListOrderTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/3.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "ProccesingModel.h"
@interface ListOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * storeName;//商店名称
@property (nonatomic, strong) UILabel * timeText;//时间
@property (nonatomic, strong) UILabel * statusLabel;//订单状态
@property (nonatomic, strong) UIView *lineView;//分割线
@property (nonatomic, strong) UILabel *countLabel;//商品数量
@property (nonatomic, strong) UILabel * picesLabel;//价格
@property (nonatomic, strong) UIButton * evaluateOrderBT;//评价订单

@property (nonatomic, strong) NSMutableArray * arrayImage;
@property (nonatomic, strong) ListOrderModel * model;

@property (nonatomic, strong) ProccesingModel * proccesingModel;


@end
