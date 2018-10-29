//
//  MessageVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self netRequestData];
    
}

-(void)setupUI{
    [super setupUI];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 74, 0, 0);
    self.navigationItem.title = @"消息";
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
