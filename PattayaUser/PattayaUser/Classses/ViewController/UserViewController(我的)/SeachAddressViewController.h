//
//  SeachAddressViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/3.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
@class AMapPOI;
typedef void (^AMapPOISearchBlock)(AMapPOI * mode);
@interface SeachAddressViewController : BaseViewController
@property (nonatomic, copy) AMapPOISearchBlock poiModelBlock;
@end
