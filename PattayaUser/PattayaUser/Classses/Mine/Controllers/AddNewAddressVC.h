//
//  AddNewAddressVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseTBController.h"
#import "AddressModel.h"
@interface AddNewAddressVC : YDBaseTBController

@property (nonatomic, assign) int enterType;//0:新增地址 1:编辑地址

@property (nonatomic, strong) AddressModel * model;

@end
