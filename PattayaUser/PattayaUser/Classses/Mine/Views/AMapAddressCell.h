//
//  AMapAddressCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AMapPOI;
@interface AMapAddressCell : UITableViewCell

@property (nonatomic, strong) UIImageView * locationImg;

@property (nonatomic, strong) UILabel * locationLabel;

@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) AMapPOI * poi;


@end

NS_ASSUME_NONNULL_END
