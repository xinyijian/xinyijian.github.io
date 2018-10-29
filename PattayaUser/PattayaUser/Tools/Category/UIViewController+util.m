//
//  UIViewController+util.m
//  PattayaUser
//
//  Created by 明克 on 2018/7/30.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "UIViewController+util.h"

@implementation UIViewController (util)

-(void)viewControllerWillAppear
{
    if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]]) {
        GetAppDelegate.viewControllerName = @"HomeViewController";
    } else if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]])
    {
        GetAppDelegate.viewControllerName = @"ConfirmationOrderViewController";
        
    } else
    {
        GetAppDelegate.viewControllerName = @" ";
    }
    
    if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]] || [self isKindOfClass:[NSClassFromString(@"SeacherViewController") class]] || [self isKindOfClass:[NSClassFromString(@"LocationViewController") class]] || [self isKindOfClass:[NSClassFromString(@"SeachAddressViewController") class]] || [self isKindOfClass:[NSClassFromString(@"UserViewController") class]] || [self isKindOfClass:[NSClassFromString(@"CarDetailsViewController") class]]|| [self isKindOfClass :[NSClassFromString(@"") class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    } else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    
    if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]]) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if ([self isKindOfClass:[NSClassFromString(@"SeacherViewController") class]])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if ([self isKindOfClass:[NSClassFromString(@"LocationViewController") class]])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }
}

-(void)viewControllerWillDisappear{
    if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]] || [self isKindOfClass:[NSClassFromString(@"SeacherViewController") class]] || [self isKindOfClass:[NSClassFromString(@"LocationViewController") class]] || [self isKindOfClass:[NSClassFromString(@"SeachAddressViewController") class]] || [self isKindOfClass:[NSClassFromString(@"UserViewController") class]]  || [self isKindOfClass:[NSClassFromString(@"CarDetailsViewController") class]]|| [self isKindOfClass:[NSClassFromString(@"") class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    
    if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]]) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if ([self isKindOfClass:[NSClassFromString(@"SeacherViewController") class]])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else if ([self isKindOfClass:[NSClassFromString(@"LocationViewController") class]])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }
}


- (void)styleViewController{
    
    self.view.backgroundColor = UIColor.whiteColor;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = App_Nav_BarDefalutColor;
    self.navigationController.navigationBar.translucent = NO;
    
}
- (UIStatusBarStyle)StatusBarStyle{
    if ([self isKindOfClass:[NSClassFromString(@"LocationViewController") class]])
    {
        return UIStatusBarStyleLightContent;//白色
        
    }else if ([self isKindOfClass:[NSClassFromString(@"SeacherViewController") class]])
    {
        return UIStatusBarStyleLightContent;//白色
        
    }else if ([self isKindOfClass:[NSClassFromString(@"HomeViewController") class]])
    {        return UIStatusBarStyleLightContent;//白色
        
        
    }else if ([self isKindOfClass:[NSClassFromString(@"SeachAddressViewController") class]])
    {        return UIStatusBarStyleLightContent;//白色
        
    }else {
        return UIStatusBarStyleDefault;//
    }
}

@end
