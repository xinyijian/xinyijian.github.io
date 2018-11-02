//
//  LocationViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;
typedef void (^LocationViewControlleraddressBlock)(AddressModel * mode);
@interface LocationViewController : BaseViewController
@property (nonatomic, copy) LocationViewControlleraddressBlock AddressBlock;
@property (nonatomic, assign) NSInteger actionAddress;

@end
