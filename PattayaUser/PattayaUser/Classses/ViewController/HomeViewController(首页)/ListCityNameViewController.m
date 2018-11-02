//
//  ListCityNameViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ListCityNameViewController.h"

@interface ListCityNameViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic, strong) NSArray * cityArray;
@end

@implementation ListCityNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = NSLocalizedString(@"切换城市",nil);
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = self.view.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
    [self loadLocation];
}

- (void)loadLocation
{
    [[PattayaUserServer singleton] getServiceCityRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            GetAppDelegate.cityModel = [[cityListModel alloc] initWithDictionary:ret error:nil];
            NSMutableArray * arr = [NSMutableArray array];
            for (ServiceCityModel * mode in GetAppDelegate.cityModel.data) {
                [arr addObject:mode.name];
            }
            _cityArray = @[@[[PattAmapLocationManager singleton].city],arr];
            [_tableview reloadData];
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
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
    
    return [_cityArray[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_cityArray count];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return NULL;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 30)];
    headView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_Width - 30, 30)];
    title.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:title];
    title.font = fontStely(@"PingFangSC-Medium", 13);
    if (section == 0) {
        title.text = NSLocalizedString(@"当前地址",nil);
    } else
    {
        title.text = NSLocalizedString(@"本地服务开通城市",nil);
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        UIView * line  = [[UIView alloc]initWithFrame:CGRectMake(15, 38, SCREEN_Width - 30, 1.5f)];
        line.backgroundColor = UIColorFromRGB(0xf4f4f6);
        [cell.contentView addSubview:line];
        
    }
    NSString * ctiyName = _cityArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = ctiyName;
    cell.textLabel.font = fontStely(@"PingFangSC-Regular", 13);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * ctiyName = _cityArray[indexPath.section][indexPath.row];
    BLOCK_EXEC(_cityBlock,ctiyName);
    [self.navigationController popViewControllerAnimated:YES];
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
