//
//  SeachAddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/3.
//  Copyright © 2018年 明克. All rights reserved.
//
///确认位置以后
#import "SeachAddressViewController.h"
#import "DD_SeachbarView.h"
#import "LoacationTableViewCell.h"
#import "AddressTableViewCell.h"
#import "SeachAddressTableViewCell.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "ListCityNameViewController.h"
@interface SeachAddressViewController ()<DD_SeachbarViewDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) UITableView * AddressTableview;
@property (nonatomic, strong) AMapSearchAPI * search;
@property (nonatomic, strong) NSArray<AMapPOI *> *searchPOIs;
@property (nonatomic, strong) DD_SeachbarView * seachBar;


@end

@implementation SeachAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    _seachBar = [[DD_SeachbarView alloc]init];
    _seachBar.DD_delegate = self;
    [_seachBar seachAddressView];
    _seachBar.seachView.placeholder = NSLocalizedString(@"输入地址",nil);
    
    [self.view addSubview:_seachBar];
    _seachBar.backgroundColor = BlueColor;
    [_seachBar activateConstraints:^{
        _seachBar.height_attr.constant = 44 + statHeight;
        [_seachBar.top_attr equalTo:self.view.top_attr constant:0];
        _seachBar.width_attr = self.view.width_attr;
    }];
    
    [PattAmapLocationManager singleton].isLocation = NO;
    
    [PattAmapLocationManager singleton].locationBlock = ^(CLLocation *location, NSString *address) {
        _seachBar.cityName = [PattAmapLocationManager singleton].city;

    };
//    self.tableview.backgroundColor = [UIColor whiteColor];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableview activateConstraints:^{
//        self.tableview.top_attr = seachBar.bottom_attr;
//        self.tableview.width_attr = self.view.width_attr;
//        self.tableview.bottom_attr = self.view.bottom_attr;
//    }];
    
    self.AddressTableview.backgroundColor = [UIColor whiteColor];
    self.AddressTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AddressTableview activateConstraints:^{
        self.AddressTableview.top_attr = _seachBar.bottom_attr;
        self.AddressTableview.width_attr = self.view.width_attr;
        self.AddressTableview.bottom_attr = self.view.bottom_attr;
    }];
//    _AddressTableview.hidden = YES;
    [self AMapSearchPOI];
    // Do any additional setup after loading the view.
}

- (void)AMapSearchPOI
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    if ([languageName containsString:@"zh"]) {
        self.search.language = AMapSearchLanguageZhCN;
    } else
    {
        self.search.language = AMapSearchLanguageEn;
    }
    
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
- (UITableView *)AddressTableview
{
    if (_AddressTableview == nil) {
        _AddressTableview = [[UITableView alloc] init];
        _AddressTableview.delegate = self;
        _AddressTableview.dataSource = self;
        [self.view addSubview:_AddressTableview];
    }
    return _AddressTableview;
}

- (void)changText:(NSString *)string
{
    NSLog(@"%@",string);
    _AddressTableview.hidden = NO;
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = string;
    request.city                = _seachBar.cityName;
//    request.types               = @"上海";
    request.requireExtension    = YES;
    request.location = 0;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];

}
- (void)closeText
{
//    _AddressTableview.hidden = YES;
    _AddressTableview.hidden = NO;

    
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    self.searchPOIs = response.pois;
    [self.AddressTableview reloadData];
    //解析response获取POI信息，具体解析见 Demo
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableview) {
        
        if (section == 0) {
            return 1;
        }
        return 2;
    }
    
    return self.searchPOIs.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableview) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableview) {
        
        if (indexPath.section == 0) {
            return 60.0f;
        }
        return 70.0f;
        
    }
    
    return 70.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return NULL;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableview) {
        
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40)];
        headView.backgroundColor =UIColorFromRGB(0xf9f9f9);
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_Width - 30, 40)];
        if (section == 0) {
            
            title.text = NSLocalizedString(@"当前地址",nil);
        }else
        {
            title.text = NSLocalizedString(@"收藏的地址",nil);
            
        }
        title.font = fontStely(@"PingFangSC-Medium", 13);
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = TextColor;
        [headView addSubview:title];
        return headView;
    }
    return NULL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableview) {
        return 40.0f;
    }
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableview) {
        
        
        if (indexPath.section == 0) {
            LoacationTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"LoacationTableViewCell"];
            if (!cell) {
                cell = [[LoacationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoacationTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else
        {
            AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
            if (!cell) {
                cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else
    {
        
        SeachAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SeachAddressTableViewCell"];
        if (!cell) {
            cell = [[SeachAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeachAddressTableViewCell"];
        }
        AMapPOI * mode = self.searchPOIs[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ressName.text = mode.name;
        cell.addressDef.text = mode.address;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.AddressTableview) {
        AMapPOI * mode = self.searchPOIs[indexPath.row];
        BLOCK_EXEC(_poiModelBlock,mode);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationClinkeCityName:(NSString *)st
{
    ListCityNameViewController * vcs = [[ListCityNameViewController alloc]init];
    [self.navigationController pushViewController:vcs animated:YES];
    vcs.cityBlock = ^(NSString *cityName) {
        _seachBar.cityName = cityName;
    };
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
