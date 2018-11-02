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
@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self netRequestData];
    
}

-(void)netRequestData{
    [self.dataArray removeAllObjects];
    [[PattayaUserServer singleton]getPushMessageRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            NSLog(@"%@",ret);
           NSArray *array = ret[@"data"];
            for (NSDictionary *dic in array) {
                PushMessageModel *model  = [[PushMessageModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
                
            }
        } else
        {
            [YDProgressHUD showHUD:@"message"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [YDProgressHUD showHUD:@"网络异常，请重试！"];
        
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


@end
