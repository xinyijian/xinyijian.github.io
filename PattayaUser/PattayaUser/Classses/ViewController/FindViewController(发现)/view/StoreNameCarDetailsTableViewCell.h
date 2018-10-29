//
//  StoreNameCarDetailsTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListModel.h"
typedef void (^gotoCarBlock) (void);
@interface StoreNameCarDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) StoreDefileModel * model;
@property (nonatomic, copy) gotoCarBlock blockMap;
@end
