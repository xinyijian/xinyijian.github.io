//
//  OrderViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderStoreNameTableViewCell.h"
#import "OrderNumberTableViewCell.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableview;
@property (nonatomic, strong) NSArray * arrdata;
@property (nonatomic, strong) NSArray * arrTiltle;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = NSLocalizedString(@"订单详情",nil);
    [self addlistTabelview];
    NSString * orderTotal = [NSString stringWithFormat:@"¥%.2f",_model.orderTotal.floatValue];
    NSString * paymentDESC = [PattayaTool isNull:_model.paymentTypeIdDESC] ? @"" : _model.paymentTypeIdDESC;
    NSString * orderPrice = [NSString stringWithFormat:@"¥%.2f",_model.orderPrice.floatValue];

    _arrdata = @[@[],@[_model.id,[PattayaTool ConvertStrToTime:_model.createTime],paymentDESC],@[orderPrice,@"¥0.00",orderTotal]];
    _arrTiltle = @[@[],@[NSLocalizedString(@"订单编号",nil),NSLocalizedString(@"购买时间",nil),NSLocalizedString(@"支付方式",nil)],@[NSLocalizedString(@"商品总金额",nil),NSLocalizedString(@"服务费",nil),NSLocalizedString(@"总计",nil)]];
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
    self.tableview.backgroundColor = [UIColor whiteColor];
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
    ///根据购买的物品的数量显示 + 1 多出来得一个是title StoreName
    if (section == 0) return _model.detailList.count + 1;
    if (section == 1) return 3;
    if (section == 2) return 3;
    return 12;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            return 50;
        } else
        {
            return 100;
        }
    }
    if (indexPath.section == 1) return 49;
    if (indexPath.section == 2) return 49;
    return 113.5f;
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
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderStoreNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStoreNameTableViewCell"];
            if (!cell) {
                cell = [[OrderStoreNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderStoreNameTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.storeName.text = _model.storeName;
            return cell;
        } else
        {
            OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
            if (!cell) {
                cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTableViewCell"];
            }
            cell.model = _model.detailList[indexPath.row - 1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else
    {
        OrderNumberTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderNumberTableViewCell"];
        if (!cell) {
            cell = [[OrderNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderNumberTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = _arrTiltle[indexPath.section][indexPath.row];
        cell.defText.text = _arrdata[indexPath.section][indexPath.row];
        if (indexPath.section == 2 && indexPath.row == 2) {
            cell.defText.textColor = UIColorFromRGB(0xDB1917);
        } else
        {
            cell.defText.textColor = TextGrayColor;
        }
        return cell;
    }
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIViewController * vc = [[UIViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
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
