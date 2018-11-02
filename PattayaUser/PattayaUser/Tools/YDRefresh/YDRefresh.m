//
//  YDRefresh.m
//  YD-MVVM+RAC
//
//  Created by iOS on 2018/4/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YDRefresh.h"

//static CGFloat duration = 0.7;

@implementation YDRefresh

+ (void)yd_headerRefresh:(UIScrollView *)refreshView
             headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerBlock];
    
    refreshView.mj_header = header;
}

+ (void)yd_headerRefresh:(UIScrollView *)refreshView
             headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock
             footerBlock:(MJRefreshComponentRefreshingBlock)footerBlock
{
    
    [self yd_headerRefresh:refreshView headerBlock:headerBlock];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:footerBlock];
    footer.triggerAutomaticallyRefreshPercent = -1;
    footer.onlyRefreshPerDrag = YES;
    footer.hidden = YES;
    
    refreshView.mj_footer = footer;
}

+ (void)yd_endRefreshing:(UIScrollView *)refreshView next:(BOOL)nextFlag
{
    // 先设置state
    refreshView.mj_footer.state  = nextFlag ? MJRefreshStateIdle : MJRefreshStateNoMoreData;
    refreshView.mj_footer.hidden = !nextFlag;
    
    // 在结束刷新
    if([refreshView.mj_header isRefreshing]) {
        [refreshView.mj_header endRefreshing];
    }

    if([refreshView.mj_footer isRefreshing]) {
        [refreshView.mj_footer endRefreshing];
    }
}

+ (void)yd_endHeaderRefresh:(UIScrollView *)refreshView
{
    if([refreshView.mj_header isRefreshing]) {
        [refreshView.mj_header endRefreshing];
    }
}

@end
