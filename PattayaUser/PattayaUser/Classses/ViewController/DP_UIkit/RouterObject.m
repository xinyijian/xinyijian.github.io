//
//  RouterObject.m
//  PattayaUser
//
//  Created by 明克 on 2018/5/22.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "RouterObject.h"

@implementation RouterObject
+ (void)initWithDelegateRouter:(id<AlerViewProtocol>)delegate  EventType:(AlerEventType)type  AlerCallBlack:(AlerViewCannlnBlock)callBlock
{
    [delegate AlerNotificationCenterEventType:type AlerCallBlack:callBlock];
}
@end
