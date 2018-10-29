//
//  AddressTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface AddressTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * addName;
@property (nonatomic, strong) UILabel * address;
@property (nonatomic, strong) UILabel * userNameMobl;
@property (nonatomic, strong) AddressModel * model;
@end
