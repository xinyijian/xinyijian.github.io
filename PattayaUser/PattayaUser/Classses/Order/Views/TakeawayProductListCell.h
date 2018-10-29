//
//  takeawayProductListCell.h
//  AppPark
//
//  Created by 池康 on 2018/7/16.
//

#import <UIKit/UIKit.h>
/**
 商家列表主页样式
 */
@interface TakeawayProductListCell : UITableViewCell

/// 产品图
@property (nonatomic,strong) UIImageView *productImgView;
/// 产品标题
@property (nonatomic,strong) UILabel *productNameLabel;
/// 已售
@property (nonatomic,strong) UILabel *haveSaleLabel;
/// 价格
@property (nonatomic,strong) UILabel *priceLabel;
/// 网友最爱，新品等产品类型
@property (nonatomic,strong) UIImageView *classImgView;
/// 原价
@property (nonatomic,strong) UILabel *originalPriceLabel;

@property (nonatomic,strong) UIView *lineView;

/// 添加按钮
@property (nonatomic,strong) UIButton *addBT;
/// 数量
@property (nonatomic,strong) UILabel *countLab;
/// 减少按钮
@property (nonatomic,strong) UIButton *reduceBT;

@property (nonatomic,strong) ProductModel *productModel;


@end
