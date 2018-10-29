//
//  DD_HandlerEnterBackground.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 进入后台block typedef */
typedef void(^DD_HandlerEnterBackgroundBlock)(NSNotification * _Nonnull note, NSTimeInterval stayBackgroundTime);

/** 处理进入后台并计算留在后台时间间隔类 */
@interface DD_HandlerEnterBackground : NSObject
/** 添加观察者并处理后台 */
+ (void)addObserverUsingBlock:(nullable DD_HandlerEnterBackgroundBlock)block;
/** 移除后台观察者 */
+ (void)removeNotificationObserver:(nullable id)observer;
@end
