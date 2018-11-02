//
//  LocationViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "CarDetailsViewController.h"
#import "LocationViewController.h"
#import "DD_SeachbarView.h"
#import "LoacationTableViewCell.h"
#import "AddressTableViewCell.h"
#import "SeachAddressTableViewCell.h"
#import "AddressViewController.h"
#import "AddressModel.h"
#import "HomeViewController.h"
#import "ListCityNameViewController.h"
@interface LocationViewController ()<DD_SeachbarViewDelegate,UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) UITableView * AddressTableview;
@property (nonatomic,strong) NSString * AddressString;
@property (nonatomic,strong) AddressListModel * listAddressModel;
@property (nonatomic, strong) AMapSearchAPI * search;
@property (nonatomic, strong) NSArray<AMapPOI *> *searchPOIs;
@property (nonatomic,strong) NSString * lat;
@property (nonatomic,strong) NSString * log;
@property (nonatomic,strong) DD_SeachbarView * seachBar;
@property (nonatomic,strong) NSString  * seachBarCity;
@property (nonatomic,strong) UIView * groundView;
@end

@implementation LocationViewController
- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
        _AddressTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_AddressTableview];
    }
    return _AddressTableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _actionAddress = 0;
    _seachBarCity = [PattAmapLocationManager singleton].city;
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.searchPOIs = [NSArray array];
    _seachBar = [[DD_SeachbarView alloc]init];
    _seachBar.DD_delegate = self;
    [_seachBar locationView];
    _seachBar.seachView.placeholder = NSLocalizedString(@"输入地址",nil);
    [self.view addSubview:_seachBar];
    _seachBar.backgroundColor = BlueColor;
    [_seachBar activateConstraints:^{
        _seachBar.height_attr.constant = 44 + statHeight;
        [_seachBar.top_attr equalTo:self.view.top_attr constant:0];
        _seachBar.width_attr = self.view.width_attr;
    }];
    
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = _seachBar.bottom_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
    
    self.AddressTableview.backgroundColor = [UIColor whiteColor];
    self.AddressTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AddressTableview activateConstraints:^{
        self.AddressTableview.top_attr = _seachBar.bottom_attr;
        self.AddressTableview.width_attr = self.view.width_attr;
        self.AddressTableview.bottom_attr = self.view.bottom_attr;
    }];
    WS(weakSelf);
    _AddressTableview.hidden = YES;
    [self pattaMapLocationInit];
    [self addressListHttp];
    [self add_TableviewRefreshHeader:_tableview refrshBlack:^{
        [weakSelf addressListHttp];
    }];
    [self AMapSearchPOI];
    _tableview.backgroundView = [self backgroundViewTableview];

}

- (void)pattaMapLocationInit{
    WS(weakSelf);
    [PattAmapLocationManager singleton].isLocation = NO;
    [PattAmapLocationManager singleton].locationBlock = ^(CLLocation *location,NSString * address) {
        _seachBar.cityName = [PattAmapLocationManager singleton].city;

        if ([PattAmapLocationManager singleton].city.length > 3) {
            _seachBar.cityName = [NSString stringWithFormat:@"%@..",[[PattAmapLocationManager singleton].city substringWithRange:NSMakeRange(0, 3)]];
        }
        weakSelf.log = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        weakSelf.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        _AddressString = address;
        [weakSelf NotSupport: [PattAmapLocationManager singleton].adcode];
        [_tableview reloadData];
    };
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
- (void)changText:(NSString *)string
{
    NSLog(@"%@",string);
    if ([PattayaTool isNull:string]) {
        return;
    }
    _AddressTableview.hidden = NO;
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = string;
    request.city                = _seachBarCity;
    //    request.types               = @"上海";
    request.requireExtension    = YES;
    request.location = 0;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        [self.AddressTableview reloadData];

        return;
    }
    self.searchPOIs = response.pois;
    [self.AddressTableview reloadData];
    //解析response获取POI信息，具体解析见 Demo
}

- (void)closeText
{
    _AddressTableview.hidden = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableview) {
        if (section == 0) {
            return 1;
        }
        return _listAddressModel.data.count;
    }
    return self.searchPOIs.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableview) {
        return 2;
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
            cell.loaction.text = _AddressString ? _AddressString : @"正在定位....";
            cell.refreshBlcok = ^{
//                cell.loaction.text = @"重新正在定位....";
                [self pattaMapLocationInit];
            };
            return cell;
        } else
        {
            AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
            if (!cell) {
                cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _listAddressModel.data[indexPath.row];
            
            return cell;
            
        }
        
    } else
    {
        SeachAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SeachAddressTableViewCell"];
        if (!cell) {
            cell = [[SeachAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeachAddressTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _searchPOIs[indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if (tableView == _AddressTableview) {
        AMapPOI * modelSeleted = _searchPOIs[indexPath.row];
        AddressModel * mode = [[AddressModel alloc] init];
        mode.areaId = modelSeleted.adcode;
        mode.contactGender = @"";
        mode.contactMobile = @"";
        mode.contactName = @"";
        mode.formattedAddress = modelSeleted.address;
        ;
        mode.latitude = [NSString stringWithFormat:@"%f",modelSeleted.location.latitude];
        mode.longitude =[NSString stringWithFormat:@"%f", modelSeleted.location.longitude];
        mode.tagAlias = @"";
        GetAppDelegate.locationAddress = mode;
        if (![weakSelf NotSupport:modelSeleted.adcode]) {
            return;
        }
        if (_actionAddress == 1) {
        BLOCK_EXEC(_AddressBlock,mode);
        [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        for (UIViewController * homeview in self.navigationController.viewControllers) {
           
            if ([homeview isKindOfClass:[HomeViewController class]]) {
                HomeViewController * home = (HomeViewController*)homeview;
                home.addressText = mode.formattedAddress;
                home.latitude = mode.latitude;
                home.longitude = mode.longitude;
                [home selectedAddressRelod];
                
                [self.navigationController popToViewController:home animated:YES];
            }
          
        }
    } else
    {
        
        if (indexPath.section == 0) {
            
            if (_actionAddress == 1) {
                AddressModel * mode = [[AddressModel alloc] init];
                mode.areaId = @"";
                mode.contactGender = @"";
                mode.contactMobile = @"";
                mode.contactName = @"";
                mode.formattedAddress = weakSelf.AddressString;
                mode.latitude = weakSelf.lat;
                mode.longitude = weakSelf.log;
                mode.tagAlias = @"";
                BLOCK_EXEC(_AddressBlock,mode);
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
            for (UIViewController * homeview in self.navigationController.viewControllers) {
                
                if ([homeview isKindOfClass:[HomeViewController class]]) {
                    HomeViewController * home = (HomeViewController*)homeview;
                    home.addressText = weakSelf.AddressString;
                    home.latitude = weakSelf.lat;
                    home.longitude = weakSelf.log;
                    GetAppDelegate.locationAddress.areaId = @"";
                    GetAppDelegate.locationAddress.contactGender = @"";
                    GetAppDelegate.locationAddress.contactMobile = @"";
                    GetAppDelegate.locationAddress.contactName = @"";
                    GetAppDelegate.locationAddress.formattedAddress = weakSelf.AddressString;
                    GetAppDelegate.locationAddress.latitude = weakSelf.lat;
                    GetAppDelegate.locationAddress.longitude = weakSelf.log;
                    GetAppDelegate.locationAddress.tagAlias = @"";
                    [home selectedAddressRelod];
                    [self.navigationController popToViewController:home animated:YES];
                }
           
                
            }
        }  else
        {
            AddressModel * model = _listAddressModel.data[indexPath.row];
            if (![weakSelf NotSupport:model.areaId]) {
                return;
            }
            if (_actionAddress == 1) {
                BLOCK_EXEC(_AddressBlock,model);
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
            for (UIViewController * homeview in self.navigationController.viewControllers) {
                if ([homeview isKindOfClass:[HomeViewController class]]) {
                    HomeViewController * home = (HomeViewController*)homeview;
                    home.addressText = model.formattedAddress;
                    home.latitude = model.latitude;
                    home.longitude = model.longitude;
                    GetAppDelegate.locationAddress = model;
                    [home selectedAddressRelod];
                    [self.navigationController popToViewController:home animated:YES];
                }
              
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationClinkeCityName:(NSString *)st
{
    WS(weakSelf);
    ListCityNameViewController * vcs = [[ListCityNameViewController alloc]init];
    vcs.cityBlock = ^(NSString *cityName) {
        weakSelf.seachBar.cityName = cityName;
        weakSelf.seachBarCity = cityName;
    };
    [self.navigationController pushViewController:vcs animated:YES];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addressCliket
{
    WS(weakSelf);
    AddressViewController * vc = [[AddressViewController alloc] init];
    vc.saveBlock = ^{
        [weakSelf addressListHttp];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addressListHttp
{
    [[PattayaUserServer singleton] GetAddRessRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        [_tableview.mj_header endRefreshing];
        if ([ResponseModel isData:ret]) {
            _listAddressModel = [[AddressListModel alloc] initWithDictionary:ret error:nil];
            
            if (_listAddressModel.data.count == 0) {
                _groundView.hidden = NO;
            } else
            {
                _groundView.hidden = YES;
            }
            [_tableview reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (UIView *)backgroundViewTableview
{
    _groundView = [[UIView alloc]init];
    [_tableview addSubview: _groundView];
    [_groundView activateConstraints:^{
        [_groundView.left_attr equalTo:_tableview.left_attr];
        [_groundView.width_attr equalTo:_tableview.width_attr];
        [_groundView.top_attr equalTo:_tableview.top_attr_safe constant:0];
        [_groundView.bottom_attr equalTo:_tableview.bottom_attr_safe];
    }];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"地址"]];
    [_groundView addSubview:image];
    [image activateConstraints:^{
        [image.centerY_attr equalTo:_groundView.centerY_attr constant:-110];
        [image.centerX_attr equalTo:_groundView.centerX_attr];;
    }];
    
    UILabel * laber = [[UILabel alloc] init];
    [_groundView addSubview:laber];
    [laber activateConstraints:^{
        [laber.left_attr equalTo:_groundView.left_attr];
        [laber.right_attr equalTo:_groundView.right_attr];
        [laber.top_attr equalTo:image.bottom_attr constant:25.5];
        laber.height_attr.constant = 21;
    }];
    laber.textColor = UIColorFromRGB(0x8a8fab);
    laber.text = NSLocalizedString(@"您还没有收藏地址哦!",nil);
    laber.textAlignment = NSTextAlignmentCenter;
    
    return _groundView;
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
