//
//  UserAddressViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;
typedef void (^addressBlock)(AddressModel * mode);
@interface UserAddressViewController : BaseViewController
@property (nonatomic, assign) NSInteger tpyeController;
@property (nonatomic, copy) addressBlock addressBlock;
@end
