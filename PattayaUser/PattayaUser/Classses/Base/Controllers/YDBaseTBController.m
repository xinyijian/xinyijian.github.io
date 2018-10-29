//
//  YDBaseTBController.m
//  ZhiYiWang
//
//  Created by SQJ on 2017/4/20.
//  Copyright © 2017年 YD. All rights reserved.
//

#import "YDBaseTBController.h"

@interface YDBaseTBController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YDBaseTBController

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopBarHeight - SafeAreaBottomHeight) style:self.tableStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = IPhone_7_Scale_Width(48);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = App_TotalGrayWhite;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [UIView new];
        // 防止上拉加载更多，位置发生偏移
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView setSeparatorColor:App_TableSeparator];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

#pragma mark - 设置初始数据
- (void)setupData
{
    [super setupData];
    
    self.pageNumber = startPage;
    
    self.progressType = YDProgressTypeCover;
    
    self.refreshMode = YDRefreshModeNone;
    
    self.tableStyle = UITableViewStyleGrouped;
}

#pragma mark - 初始UI
- (void)setupUI
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    if (self.refreshMode == YDRefreshModeHeader) {
        
        [YDRefresh yd_headerRefresh:self.tableView headerBlock:^{
            @strongify(self);
            
            self.pageNumber = startPage;
            
            [self netRequestData];
        }];
    }
    
    if (self.refreshMode == YDRefreshModeAll) {
        
        [YDRefresh yd_headerRefresh:self.tableView headerBlock:^{
            @strongify(self);
            
            self.pageNumber = startPage;
         
            [self netRequestData];
            
        } footerBlock:^{
            @strongify(self);
            
            self.pageNumber = self.pageNumber + 1;
            
            [self netRequestData];
        }];
    }
}

//  请求处理的结果，有需要可以在子类重写
- (void)handleNetReslut:(YDNetResultStatus)status
{
    if (self.refreshMode == YDRefreshModeHeader) {
        [YDRefresh yd_endHeaderRefresh:self.tableView];
    }

    [super handleNetReslut:status];
}

- (void)handleNetReslut:(YDNetResultStatus)status hasNext:(NSArray *)array
{
    if (self.refreshMode == YDRefreshModeAll) {
        [YDRefresh yd_endRefreshing:self.tableView next:array.count == pageSize];
    }
    
    [super handleNetReslut:status];
}

#pragma mark - tableView datasource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return IgnoreHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return IgnoreHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reason = [NSString stringWithFormat:@"%@ 子类必须实现的方法, 需要在setupUI中注册对应的cell %@",[self class],NSStringFromSelector(_cmd)];
    
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:reason
                                 userInfo:nil];
}

@end



































