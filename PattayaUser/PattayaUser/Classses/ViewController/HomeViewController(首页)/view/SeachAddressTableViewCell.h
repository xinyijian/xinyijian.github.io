//
//  SeachAddressTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SeachAddressTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel * ressName;
@property (nonatomic, strong)UILabel * addressDef;
@property (nonatomic, strong) AMapPOI * model;
@end
