//
//  UIViewController+util.h
//  PattayaUser
//
//  Created by 明克 on 2018/7/30.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (util)
-(void)viewControllerWillAppear;
-(void)viewControllerWillDisappear;
- (void)styleViewController;
- (UIStatusBarStyle)StatusBarStyle;
@end
