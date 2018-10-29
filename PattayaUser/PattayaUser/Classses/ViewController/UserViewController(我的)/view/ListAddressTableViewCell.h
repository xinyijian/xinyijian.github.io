//
//  ListAddressTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
typedef void(^eidtBtnBlock) (void);
@interface ListAddressTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * addName;
@property (nonatomic, strong) UILabel * address;
@property (nonatomic, strong) UILabel * userNameMobl;
@property (nonatomic, strong) UIButton * EidtBtn;
@property (nonatomic, strong) AddressModel * model;
@property (nonatomic, copy) eidtBtnBlock cellBlock;

@end
