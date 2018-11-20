//
//  BaseTabBarViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "ListOrderViewController.h"
#import "UserViewController.h"
#import "MineVC.h"
@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedIndex) name:@"changeSelectedIndex" object:nil];
    NSDictionary *tabBarItemDict = [NSDictionary dictionaryWithObject:TextGrayColor forKey:NSForegroundColorAttributeName];
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    [self configViewController:vc1 title:NSLocalizedString(@"首页",nil) image:@"icon_home" selectedImage:@"icon_home_sel" tabBarItem:tabBarItemDict];
    

//    FindViewController *vc2 = [[FindViewController alloc] init];
//    [self configViewController:vc2 title:NSLocalizedString(@"发现",nil) image:@"icon-发现-default" selectedImage:@"icon-发现" tabBarItem:tabBarItemDict];

    ListOrderViewController *vc3 = [[ListOrderViewController alloc] init];
    [self configViewController:vc3 title:NSLocalizedString(@"订单",nil) image:@"icon_order" selectedImage:@"icon_order_sel" tabBarItem:tabBarItemDict];
    
    
    MineVC *vc4 = [[MineVC alloc] init];
    [self configViewController:vc4 title:NSLocalizedString(@"我的",nil) image:@"icon_account" selectedImage:@"icon_account_sel" tabBarItem:tabBarItemDict];
    
    
    [[UITabBar appearance] setBackgroundColor:UIColorFromRGB(0xFaFaFa)];
    CGRect rect = CGRectMake(0, 0, SCREEN_Width, 10);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    
    [self.tabBar setShadowImage:img];
    
    self.delegate = self;

}

- (void)configViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName tabBarItem:(NSDictionary *)dict
{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [viewController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSDictionary *colorDict = [NSDictionary dictionaryWithObject:TextColor forKey:NSForegroundColorAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:colorDict forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"PingFangSC-Regular" size:11] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    //随便一个接口验证一下是否登录
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];
    }];
    return YES;
}


-(void)changeSelectedIndex{
     self.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
