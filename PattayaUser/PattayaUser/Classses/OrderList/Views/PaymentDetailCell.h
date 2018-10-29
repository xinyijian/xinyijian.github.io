//
//  PaymentDetailCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
@interface PaymentDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;//

@property (nonatomic, strong) UILabel * detailLabel;//商店名称
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *DetailTitle;

@end
