//
//  AddressListVC.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "YDBaseTBController.h"
@class AddressModel;
typedef void(^addressSeletecd)(AddressModel * model);

@interface AddressListVC : YDBaseTBController
@property (nonatomic, copy) addressSeletecd addressBlock;
@property (nonatomic, assign) BOOL isCallOrder;
@end
