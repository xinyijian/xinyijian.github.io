//
//  DeveloperViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/11.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^DevelopmentBlock)();
@interface DeveloperViewController : BaseViewController
@property (copy, nonatomic) DevelopmentBlock devBlock;

@end
