//
//  main.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
CFAbsoluteTime StartTime;

int main(int argc, char * argv[]) {
    StartTime = CFAbsoluteTimeGetCurrent();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
