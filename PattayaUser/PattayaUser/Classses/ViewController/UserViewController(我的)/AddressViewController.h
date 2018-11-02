//
//  AddressViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;
typedef void(^saveAddressViewContollerBlock) (void);
@interface AddressViewController : BaseViewController
@property (nonatomic, strong) AddressModel * EidtModel;
@property (nonatomic, copy) saveAddressViewContollerBlock saveBlock;
@property (nonatomic, assign) NSInteger viewcontrollerTpye;

@end
