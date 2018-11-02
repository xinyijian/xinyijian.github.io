//
//  YDRefresh.h
//  YD-MVVM+RAC
//
//  Created by iOS on 2018/4/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YDRefreshMode) {
    YDRefreshModeNone,    // 没有刷新功能
    YDRefreshModeHeader,  // 只有头部刷新
    YDRefreshModeFooter,  // 只有底部加载更多
    YDRefreshModeAll      // 头部刷新和底部加载更多
};

@interface YDRefresh : NSObject

+ (void)yd_headerRefresh:(UIScrollView *)refreshView
             headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock;

+ (void)yd_headerRefresh:(UIScrollView *)refreshView
             headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock
             footerBlock:(MJRefreshComponentRefreshingBlock)footerBlock;

// nextFlag: 判断是否还有更多数据
+ (void)yd_endRefreshing:(UIScrollView *)refreshView next:(BOOL)nextFlag;

+ (void)yd_endHeaderRefresh:(UIScrollView *)refreshView;

@end



















