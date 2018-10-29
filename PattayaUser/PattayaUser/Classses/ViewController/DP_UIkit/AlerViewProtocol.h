//
//  AlerViewProtocol.h
//  PattayaUser
//
//  Created by 明克 on 2018/5/21.
//  Copyright © 2018年 明克. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^AlerViewCannlnBlock)(NSInteger index, NSString *  titl);
typedef NS_OPTIONS(NSUInteger, AlerEventType) {
    //    AlerCallOrderDriverAccepted = 0,
    //    AlerCallOrderDriverStarted = 1,
    //    AlerCallOrderDriverArrived = 2,
    //    AlerCallOrderCancelled = 3,
    //    TTGDirectionBottom = 4,
    AlerInProgressOrder = 0,
    AlerLogout = 1,
    AlerLinkThird = 2,
    AlerCallOrderDir = 3,
    AlerUnderwayOrder = 4,
};
@protocol AlerViewProtocol <NSObject>

@optional
- (void)AlerNotificationCenterEventType:(AlerEventType)type AlerCallBlack:(AlerViewCannlnBlock)callBlock;
@end
