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
#import "AddressModel.h"
#import "SelcetAddressVC.h"
#import "EmptyView.h"
@interface AddressListVC ()

//导航栏pop按钮
@property (nonatomic, strong) UIButton *rightPopBT;
@property (nonatomic, strong) AddressListModel * addresslist;
@property (nonatomic,strong) EmptyView *emptyView;//无数据视图

@end

@implementation AddressListVC

-(void)viewWillAppear:(BOOL)animated{
    
    if ([PattayaTool isUserLogin]){
         [self netRequestData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    //导航栏
    
    [self rightBarButtonWithTitle:@"新增地址" barImage:nil action:^{
        NSLog(@"新增地址");
        [self addNewAddress];
    }];
     self.navigationItem.title = @"常用地址";
    
    [self.view addSubview:self.emptyView];
   
}

- (void)netRequestData{
    @weakify(self);
    [[PattayaUserServer singleton] GetAddRessRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        @strongify(self);
        _addresslist = [[AddressListModel alloc] initWithDictionary:ret error:nil];
        NSLog(@"%@====",_addresslist);
        if (_addresslist.data.count > 0) {
            self.emptyView.hidden = YES;
        }else{
             self.emptyView.hidden = NO;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       // [YDProgressHUD showMessage:@"网络异常，请重试！"];

    }];
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addresslist.data.count;
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
    cell.model = _addresslist.data[indexPath.row];
    cell.Block = ^{
        [self editAddress:_addresslist.data[indexPath.row]];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
//    vc.enterType = indexPath.row;
//    //vc.model =_listModel.list[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
    AddressModel * mode = _addresslist.data[indexPath.row];
    if (_isCallOrder) {
        
        BLOCK_EXEC(_addressBlock,mode);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self editAddress:mode];
    }
    
}

#pragma mark - 新增地址
-(void)addNewAddress{
    AddNewAddressVC *vc = [[AddNewAddressVC alloc]init];
    vc.enterType = 0;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 编辑地址
- (void)editAddress:(AddressModel *)mode{
    
    AddNewAddressVC *vc = [[AddNewAddressVC alloc]init];
    vc.enterType = 1;
    vc.model = mode;
    [self.navigationController pushViewController:vc animated:YES];
}

-(EmptyView *)emptyView{
    WEAK_SELF;
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, IPhone_7_Scale_Height(150)) withImage:@"main_cell_headImg_bg" withTitle:@"一个地址也没有哦"];
        _emptyView.block = ^{
            [weakSelf netRequestData];
        };
    }
    return _emptyView;
}

@end
