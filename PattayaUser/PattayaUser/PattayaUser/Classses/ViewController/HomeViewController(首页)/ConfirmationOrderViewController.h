//
//  ConfirmationOrderViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/7.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDefModel.h"
typedef void(^timeOutBlock)(void);
@interface ConfirmationOrderViewController : BaseViewController
@property (nonatomic, strong) NSString * orderId;
@property (nonatomic, copy) timeOutBlock timeoutBlock;

@end
