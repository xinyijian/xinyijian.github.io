//
//  AddressListCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListCell : UITableViewCell

@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * subAddressLabel;
@property (nonatomic, strong) UILabel * userNameMobl;
@property (nonatomic, strong) UIImageView * editBT;//编辑按钮
@property (nonatomic, strong) UIImageView * addressTypeImg;//地址类型



@property (nonatomic, strong) AddressModel * model;

@end
