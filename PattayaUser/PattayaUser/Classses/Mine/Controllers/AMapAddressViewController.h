//
//  AMapAddressViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/10/31.
//  Copyright © 2018 明克. All rights reserved.
//

#import "YDBaseController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddressBlock)(AMapPOI *location,NSString *adcode);

@interface AMapAddressViewController : YDBaseTBController

@property (nonatomic, copy) AddressBlock addressBlock;


@end

NS_ASSUME_NONNULL_END
