//
//  StoreListCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/15.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;//商店头像
@property (nonatomic, strong) UILabel *nameLabel;//商店名称
@property (nonatomic, strong) UILabel *chainLabel;//连锁
@property (nonatomic, strong) UILabel *distance;//距离
@property (nonatomic, strong) UILabel *hotLabel;//热力值
@property (nonatomic, strong) UIImageView *hotImg;//热力值
@property (nonatomic, strong) UILabel *cutLine;//分割线
@property (nonatomic, strong) UIImageView *promotionImg1;//推广图标1
@property (nonatomic, strong) UILabel *promotionLabel;//推广文字1
@property (nonatomic, strong) UIImageView *promotionImg2;//推广图标2
@property (nonatomic, strong) UILabel *promotionLabel2;//推广文字2


@end
