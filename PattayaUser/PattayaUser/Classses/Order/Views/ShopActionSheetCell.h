//
//  ShopActionSheetCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopActionSheetCell;

@protocol ShopActionSheetCellDelegate <NSObject>

- (void)ShopActionSheet:(ShopActionSheetCell *)ShopActionSheet showShopCount:(NSInteger)count;

@end

@interface ShopActionSheetCell : UITableViewCell

/// 产品标题
@property (nonatomic,strong) UILabel *productNameLabel;
/// 价格
@property (nonatomic,strong) UILabel *priceLabel;
/// 原价
@property (nonatomic,strong) UILabel *originalPriceLabel;
/// 添加按钮
@property (nonatomic,strong) UIButton *addBT;
/// 数量
@property (nonatomic,strong) UILabel *countLab;
/// 减少按钮
@property (nonatomic,strong) UIButton *reduceBT;


@property (nonatomic, weak) id<ShopActionSheetCellDelegate>delegate;


@property (nonatomic,strong) ProductModel *productModel;


@end
