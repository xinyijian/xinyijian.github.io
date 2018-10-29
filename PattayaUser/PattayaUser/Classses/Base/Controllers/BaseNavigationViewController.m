//
//  BaseNavigationViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "HomeViewController.h"
#import "SeacherViewController.h"
@interface BaseNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIViewController* currentShowVC;

@end

@implementation BaseNavigationViewController


//-(id)initWithRootViewController:(UIViewController *)rootViewController
//{
//
//    //覆盖创建
//    BaseNavigationViewController* nvc = [super initWithRootViewController:rootViewController];
//    nvc.interactivePopGestureRecognizer.delegate = self;
//    nvc.delegate = self;
//    return nvc;
//}

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setNavBarStyle:NavgationStyleDefalute];
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 避免同时点击出现的bug
    for (UIView *view in self.view.subviews) {
        [view setExclusiveTouch:YES];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        
        // 非根控制器的时候隐藏底部的tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(navgationPopClickBackItem)];
        viewController.navigationItem.leftBarButtonItem = backItem;
        
        // 在需要的时候重写返回的方法 -- 注意如果不是重写，不要命名相同
        if ([viewController respondsToSelector:@selector(navgationPopClickBackItem)]) {
            backItem.target = viewController;
            backItem.action = @selector(navgationPopClickBackItem);
        }
    }
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UI事件
- (void)navgationPopClickBackItem
{
    [self popViewControllerAnimated:YES];
}




@end
