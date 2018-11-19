//
//  MessageVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "PushMessageModel.h"
#import "EmptyView.h"
@interface MessageVC ()

@property (nonatomic,strong) EmptyView *emptyView;//无数据视图


@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self netRequestData];
    
}

-(void)setupData{
    
    [super setupData];
    
    self.refreshMode = YDRefreshModeAll;
    
}

-(void)netRequestData{
   // [self.dataArray removeAllObjects];
    @weakify(self);
    NSDictionary *dic = @{
                          @"pageNum":@(self.pageNumber),
                          @"pageSize":@(pageSize)
                          };
    [[PattayaUserServer singleton]getPushMessageRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
         NSLog(@"%@",ret);
        @strongify(self);
        if ([ResponseModel isData:ret]) {
           
            if (self.pageNumber == startPage) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = ret[@"data"][@"list"];
            for (NSDictionary *dic in array) {
                PushMessageModel *model  = [[PushMessageModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }
            
            [YDRefresh yd_endRefreshing:self.tableView next:array.count == pageSize];
            if (self.dataArray.count > 0 ) {
                self.emptyView.hidden = YES;
            }else{
                self.emptyView.hidden = NO;
            }
             [self.tableView reloadData];
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
            [YDRefresh yd_endRefreshing:self.tableView next:YES];
        }
       
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
       // [YDProgressHUD showMessage:@"网络异常，请重试！"];
        [YDRefresh yd_endRefreshing:self.tableView next:YES];

    }];
}

-(void)setupUI{
    [super setupUI];
   
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 74, 0, 0);
    self.tableView.estimatedRowHeight = 88;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.navigationItem.title = @"消息";
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 88;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageModel = self.dataArray[indexPath.row];
    return cell;
}



-(EmptyView *)emptyView{
    WEAK_SELF;
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, IPhone_7_Scale_Height(150)) withImage:@"main_cell_headImg_bg" withTitle:@"还没有消息哦"];
        _emptyView.block = ^{
            [weakSelf netRequestData];
        };
        _emptyView.hidden = YES;
    }
    return _emptyView;
}


@end
