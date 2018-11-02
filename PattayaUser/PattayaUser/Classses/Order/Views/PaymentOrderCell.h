//
//  PaymentOrderCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface PaymentOrderCell : UITableViewCell


/// 产品图
@property (nonatomic,strong) UIImageView *productImgView;
/// 产品标题
@property (nonatomic,strong) UILabel *productNameLabel;
/// 价格
@property (nonatomic,strong) UILabel *priceLabel;
/// 原价
@property (nonatomic,strong) UILabel *originalPriceLabel;
/// 数量
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) detailListModel *item;


//隐藏部分视图
-(void)hiddenSomeViews;

/**
 设置数据源
 */
@property (nonatomic, strong) NewShopListModel *productModel;

@end
