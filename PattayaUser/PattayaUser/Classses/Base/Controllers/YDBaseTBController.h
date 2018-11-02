//
//  YDBaseTBController.h
//  ZhiYiWang
//
//  Created by SQJ on 2017/4/20.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDBaseController.h"

// 网络第一次请求的初始值
static NSInteger const startPage = 1;
static NSInteger const pageSize  = 10;

@interface YDBaseTBController : YDBaseController <UITableViewDataSource, UITableViewDelegate>

/// 需要加载更多 - hasNext是否可以加载更多（比较返回数据的条数）
- (void)handleNetReslut:(YDNetResultStatus)status hasNext:(NSArray *)array;

#pragma mark - 属性
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle tableStyle;
@property (nonatomic, assign) YDRefreshMode refreshMode;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageNumber;

@end











