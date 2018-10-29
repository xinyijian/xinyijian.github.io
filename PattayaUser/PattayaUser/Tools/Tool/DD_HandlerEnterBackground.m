//
//  DD_HandlerEnterBackground.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "DD_HandlerEnterBackground.h"

@implementation DD_HandlerEnterBackground
+ (void)addObserverUsingBlock:(DD_HandlerEnterBackgroundBlock)block {
    __block CFAbsoluteTime enterBackgroundTime;
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (![note.object isKindOfClass:[UIApplication class]]) {
            enterBackgroundTime = CFAbsoluteTimeGetCurrent();
        }
    }];
    __block CFAbsoluteTime enterForegroundTime;
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (![note.object isKindOfClass:[UIApplication class]]) {
            enterForegroundTime = CFAbsoluteTimeGetCurrent();
            CFAbsoluteTime timeInterval = enterForegroundTime-enterBackgroundTime;
            block? block(note, timeInterval): nil;
        }
    }];
}
+ (void)removeNotificationObserver:(id)observer {
    if (!observer) {
        return;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:observer name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:observer name:UIApplicationWillEnterForegroundNotification object:nil];
}
@end
