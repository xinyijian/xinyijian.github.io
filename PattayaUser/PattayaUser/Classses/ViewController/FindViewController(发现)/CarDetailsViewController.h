//
//  CarDetailsViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
#import "StoreListModel.h"
@interface CarDetailsViewController : BaseViewController
@property (nonatomic, strong) StoreDefileModel * model;
@property (strong, nonatomic) AddressModel * carDetailModel;
@property (strong, nonatomic) NSString * storeId;
- (void)loadFindeViewFormatteAddress;
@end
