//
//  UserAddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "AddressViewController.h"
#import "UserAddressViewController.h"
#import "AddressViewController.h"
#import "ListAddressTableViewCell.h"
#import "AddressModel.h"
#import "FindViewController.h"
#import "CarDetailsViewController.h"
@interface UserAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) AddressListModel * ListModel;
@property (strong, nonatomic) UILabel * plaredText;

@end

@implementation UserAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTitle = NSLocalizedString(@"我的地址",nil);
    WS(weakSelf);
    [self rightBarButtonWithTitle:NSLocalizedString(@"新增地址",nil) barImage:nil action:^{
        if ([PattayaTool isUserLoginStats] == NO) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
        } else
        {
            AddressViewController * vc = [[AddressViewController alloc] init];
            vc.saveBlock = ^{
                [weakSelf addressListHttp];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }];
    
    [self addlistTabelview];
    [self addressListHttp];
    [self add_TableviewRefreshHeader:_tableview refrshBlack:^{
        [weakSelf addressListHttp];

    }];
    
    
    _plaredText = [[UILabel alloc]init];
    _plaredText.frame = CGRectMake(0, 0, SCREEN_Width, 30);
    _plaredText.center = CGPointMake(SCREEN_Width / 2, SCREEN_Height / 2 - 32);
    _plaredText.textAlignment = NSTextAlignmentCenter;
    _plaredText.textColor = TextGrayColor;
    _plaredText.font = [UIFont systemFontOfSize:13];
    _plaredText.text = @"暂无地址,请点击右上角添加地址";
    [self.view addSubview:_plaredText];
    _plaredText.hidden = NO;
    // Do any additional setup after loading the view.
}

- (void)addlistTabelview
{
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = self.view.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
}
- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListModel.data.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return NULL;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return NULL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListAddressTableViewCell"];
    if (!cell) {
        cell = [[ListAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListAddressTableViewCell"];
    }
    WS(weakSelf);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _ListModel.data[indexPath.row];
    cell.cellBlock = ^{
        [weakSelf addressEdit:_ListModel.data[indexPath.row]];
    };
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushAddressViewContoller:_ListModel.data[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakself);
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示",nil) message:NSLocalizedString(@"你确定删除该消息？",nil) preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //
            AddressModel *model = _ListModel.data[indexPath.row];
            [weakself singleDelet:model.id index:indexPath];
         
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)singleDelet:(NSString *)addressId  index:(NSIndexPath *)index
{
    [[PattayaUserServer singleton]deletedAddressRequest:addressId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"ret = %@",ret);
        if ([ResponseModel isData:ret]) {
            [self.ListModel.data removeObjectAtIndex:index.row];
            if (self.ListModel.data.count > 0) {
                _plaredText.hidden = YES;
            } else
            {
                _plaredText.hidden = NO;
            }
            [_tableview deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"删除",nil);
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)pushAddressViewContoller:(AddressModel *)mode
{
    WS(weakSelf);
    if (_tpyeController == 2) {
        for (UIViewController * vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[FindViewController class]]) {
                BLOCK_EXEC(weakSelf.addressBlock,mode);
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }
            if ([vc isKindOfClass:[CarDetailsViewController class]]) {
                BLOCK_EXEC(weakSelf.addressBlock,mode);
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }
        }
    }
}

- (void)addressEdit:(AddressModel *)mode
{
    WS(weakSelf);
    AddressViewController * addressvc = [[AddressViewController alloc]init];
    addressvc.EidtModel = mode;
    addressvc.saveBlock = ^{
        [weakSelf addressListHttp];
    };
    [self.navigationController pushViewController:addressvc animated:YES];
}

- (void)addressListHttp
{
    [[PattayaUserServer singleton] GetAddRessRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            _ListModel = [[AddressListModel alloc] initWithDictionary:ret error:nil];
            if (_ListModel.data.count > 0) {
                _plaredText.hidden = YES;
            } else
            {
                _plaredText.hidden = NO;
            }
            [_tableview reloadData];
        }
        [_tableview.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
