//
//  ThirdPartyViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^updataBlockUserInfo)(void);
@interface ThirdPartyViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray * listUserSocial;
@property (nonatomic, copy) updataBlockUserInfo infoBlock;

@end
