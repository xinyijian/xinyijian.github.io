//
//  UINavigationBar+YDNavBarStyle.h
//  Flk-ContractApp
//
//  Created by iOS on 2018/4/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

// 导航栏的样式
typedef NS_ENUM(NSInteger, NavgationStyle) {
    NavgationStyleDefalute, // 默认的样式
    NavgationStyleAppTheme  // app主题颜色样式
};

@interface UINavigationBar (YDNavBarStyle)

// 设置导航栏的样式
- (void)setNavBarStyle:(NavgationStyle)style;

@end
