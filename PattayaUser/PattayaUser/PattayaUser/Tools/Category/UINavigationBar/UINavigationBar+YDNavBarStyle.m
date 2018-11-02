//
//  UINavigationBar+YDNavBarStyle.m
//  Flk-ContractApp
//
//  Created by iOS on 2018/4/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UINavigationBar+YDNavBarStyle.h"

@implementation UINavigationBar (YDNavBarStyle)

- (void)setNavBarStyle:(NavgationStyle)style
{
    UIColor *titleColor = style == NavgationStyleAppTheme ? App_Nav_ItemThemeColor : App_Nav_ItemDefaultColor;
    // 设置导航栏标题的颜色和大小
    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:titleColor, NSFontAttributeName:App_NavBar_TitleFont};
    [self setTitleTextAttributes:titleAttr];
    // 设置导航栏Item的颜色和大小
    UIBarButtonItem *navItem = [UIBarButtonItem appearance];
    NSDictionary *itemAttr = @{NSForegroundColorAttributeName:titleColor, NSFontAttributeName:App_NavBar_ItemFont};
    [self setTitleTextAttributes:titleAttr];
    [navItem setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    // 去掉去掉背景图片
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    if (style == NavgationStyleAppTheme) {
        // 去掉底部线条
        [self setShadowImage:[UIImage new]];
    }else {
        // 画一条分割线
        [self setShadowImage:[UIImage drawNavgationBarSeparatorImg]];
    }
    
    // 设置导航栏的背景颜色
    self.barTintColor = style == NavgationStyleAppTheme ? App_Nav_BarThemeColor : App_Nav_BarDefalutColor;
    // 设置返回箭头的颜色
    self.tintColor = titleColor;
    // 设置移除透明的效果 坐标原点自动下移64
    self.translucent = NO;
}

@end
