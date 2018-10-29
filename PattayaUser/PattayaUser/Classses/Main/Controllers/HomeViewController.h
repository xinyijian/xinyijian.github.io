//
//  HomeViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : YDBaseController
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
@property (nonatomic, strong) NSString * addressText;
- (void)selectedAddressRelod;
@end
