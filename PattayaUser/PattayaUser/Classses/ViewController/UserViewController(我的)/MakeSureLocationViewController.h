//
//  MakeSureLocationViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^ makeSurelocationBlock)(NSString * address,NSString * adCode,NSString * latitude,NSString * longitude);
@interface MakeSureLocationViewController : BaseViewController
@property (nonatomic, copy) makeSurelocationBlock block;
@end
