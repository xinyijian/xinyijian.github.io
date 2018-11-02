//
//  ListCityNameViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^cityNameBlock) (NSString * cityName);
@interface ListCityNameViewController : BaseViewController
@property (nonatomic, copy) cityNameBlock cityBlock;
@end
