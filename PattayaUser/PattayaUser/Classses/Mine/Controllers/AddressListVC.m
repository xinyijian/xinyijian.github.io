//
//  AddressListVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AddressListVC.h"
#import "AddressListCell.h"
#import "AddNewAddressVC.h"
@interface AddressListVC ()

//导航栏pop按钮
@property (nonatomic, strong) UIButton *rightPopBT;

@end

@implementation AddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    //导航栏
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithTitle:@"新增地址" style:UIBarButtonItemStylePlain target:self action:@selector(addNewAddress)];
    self.navigationItem.rightBarButtonItem=rightitem;
     self.navigationItem.title = @"常用地址";
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    if (!cell) {
        cell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.editBT addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
//    vc.enterType = indexPath.row;
//    //vc.model =_listModel.list[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 新增地址
-(void)addNewAddress{
    AddNewAddressVC *vc = [[AddNewAddressVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
