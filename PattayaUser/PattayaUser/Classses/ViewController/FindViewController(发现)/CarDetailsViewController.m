//
//  CarDetailsViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "LocationViewController.h"
#import "CarDetailsViewController.h"
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>
#import "CarDetailsTitleTableViewCell.h"
#import "CarNameTableViewCell.h"
#import "FindCarView.h"
#import "StoreNameCarDetailsTableViewCell.h"
#import "DD_Alertview.h"
#import "UserAddressViewController.h"
#import "callOrderModel.h"
#import "ConfirmationOrderViewController.h"
#import "ProtocolKit.h"
#import "NSMutableDictionary+SetModelRequest.h"
@interface CarDetailsViewController ()<BHInfiniteScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableview;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
@property (nonatomic, strong) NSString * dataFromday;
@property (nonatomic, assign) NSTimeInterval  dayTime;
@property (nonatomic, strong) DD_Alertview * alertview;
@property (nonatomic, strong)   FindCarView * CarFindview;
//@property (strong, nonatomic) AddressModel * carDetailModel;
@end

@implementation CarDetailsViewController


- (void)callStoreHttp
{
    [[PattayaUserServer singleton] GetStoredbStoreRequest:@{@"id":_storeId} success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            StoreListModel * list = [[StoreListModel alloc] initWithDictionary:ret[@"data"] error:nil];
            if (list.content.count > 0) {
                _model = [[StoreDefileModel alloc] init];
                _model = list.content[0];
                if (![PattayaTool isNull:_model.avatarURL]) {
                    _infinitePageView.imagesArray = @[_model.avatarURL];
                }
                [self checkCreateOrderRequest];

            }
            
        } else
        {
            [self showToast:ret[@"message"]];
        }
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_carDetailModel);
//    _carDetailModel = [[AddressModel alloc] initWithDictionary:rest error:nil];
    NSLog(@"%@",_carDetailModel);
    BHInfiniteScrollView* infinitePageView1 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, SCREEN_Width, 220) Delegate:self ImagesArray:@[@"banner-店铺详情"]];
    infinitePageView1.dotSize = 4;
    infinitePageView1.dotSpacing = 6.0f;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0, 2.5);
    infinitePageView1.titleView.textColor = UIColorFromRGB(0xD8D8D8);
    infinitePageView1.selectedDotColor = [UIColor clearColor];
    infinitePageView1.titleView.hidden = NO;
    infinitePageView1.scrollTimeInterval = 2;
    infinitePageView1.autoScrollToNextPage = YES;
    infinitePageView1.delegate = self;
    infinitePageView1.placeholderImage = [UIImage imageNamed:@"banner-店铺详情"];
    infinitePageView1.pageViewContentMode = UIViewContentModeScaleAspectFit;
    _infinitePageView = infinitePageView1;
    [self.view addSubview:_infinitePageView];
    [PattayaTool shadowColorAndShadowOpacity:infinitePageView1 color:@"#000000" Alpha:0.2];
    [self addlistTabelview];
    self.tableview.tableHeaderView = infinitePageView1;
    // Do any additional setup after loading the view.
    
    [self callStoreHttp];
    
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backView];
    if (@available(iOS 11.0, *)) {
        [backView activateConstraints:^{
            [backView.top_attr equalTo:self.view.top_attr_safe constant:0];
            [backView.left_attr equalTo: self.view.left_attr_safe constant:0];
            backView.height_attr.constant = 44;
            backView.width_attr .constant= 44;
        }];
    } else
    {
        [backView activateConstraints:^{
            [backView.top_attr equalTo:self.view.top_attr_safe constant:20];
            [backView.left_attr equalTo: self.view.left_attr_safe constant:0];
            backView.height_attr.constant = 44;
            backView.width_attr .constant= 44;
        }];
    }
    
    
    [backView setImage:[UIImage imageNamed:@"icon-return"] forState:UIControlStateNormal];
    [backView addTarget:self action:@selector(backViewPop:) forControlEvents:UIControlEventTouchUpInside];
    
    _alertview = [[DD_Alertview alloc] initWithFrame:self.view.bounds stlyeView:DD_AlertviewStlyeConfirm navStatusHeight:NavtinavigationYBottom];
    
    
    _CarFindview = [[FindCarView alloc]initWithFrame:CGRectZero stlype:1];
    [self.view addSubview:_CarFindview];
    [_CarFindview activateConstraints:^{
        _CarFindview.bottom_attr =self.view.bottom_attr_safe;
        [_CarFindview.left_attr equalTo:self.view.left_attr constant:15];
        [_CarFindview.right_attr equalTo:self.view.right_attr constant:-15];
        _CarFindview.height_attr.constant = 161;
    }];
    [_CarFindview addressToShow:_carDetailModel.formattedAddress];
    
    _CarFindview.layer.cornerRadius = 4;
    _CarFindview.layer.shadowColor = [UIColor colorWithHexString:@"#000000" Alpha:0.2].CGColor;
    _CarFindview.layer.shadowOffset = CGSizeMake(0, 0);
    _CarFindview.layer.shadowRadius = 4.0f;
    _CarFindview.layer.shadowOpacity = 0.6f;
    
    
    _CarFindview.picker.pickeblock = ^(NSDate *data) {
        NSString *dateString = [data stringWithFormat:@"dd HH:mm"];
        _dataFromday = dateString;
        _dayTime = [data timeIntervalSince1970] * 1000;
        NSLog(@"选择的日期：%@",dateString);
    };
    
    if (_dayTime <= 0) {
        NSDate * dates = [NSDate date];
        _dataFromday = [dates stringWithFormat:@"dd HH:mm"];
        _dayTime = [dates timeIntervalSince1970] * 1000;
    }
    
    WS(weakSelf);
    
    _CarFindview.addressBlock = ^{
        [weakSelf loadFindeViewFormatteAddress];
    };
}


- (void)checkCreateOrderRequest
{
    NSLog(@"%@",@{@"endLatitude":_model.lat,@"endLongitude":_model.lon,@"startLatitude":_carDetailModel.latitude,@"startLongitude":_carDetailModel.longitude,});
    WS(weakSelf);
    [[PattayaUserServer singleton] checkCreateOrderRequest:@{@"endLatitude":_model.lat,@"endLongitude":_model.lon,@"startLatitude":_carDetailModel.latitude,@"startLongitude":_carDetailModel.longitude,} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            NSString * st1= NSLocalizedString(@"距离：",nil);
            NSString * st2= NSLocalizedString(@"大约需要",nil);
            NSString * st3= NSLocalizedString(@"分钟",nil);
            _CarFindview.deitle.text = [NSString stringWithFormat:@"%@%@      %@%@%@",st1,ret[@"data"][@"Distance"],st2,ret[@"data"][@"Duration"],st3];
            if ([ret[@"data"][@"CreateStatus"] isEqualToString:@"USER_CAN_NOT_CREATE"]) {
                
                [_CarFindview isEdinBtn:NO];
            } else
            {
                [_CarFindview isEdinBtn:YES];
                _CarFindview.block = ^(BOOL isCallNow) {
                    if (isCallNow) {
                        NSString * st1= NSLocalizedString(@"预约时间：",nil);
                        NSString * st2= NSLocalizedString(@"地址：",nil);
                        
                        weakSelf.alertview.storeLaber.text = [NSString stringWithFormat:@"%@%@\n%@%@",st1,weakSelf.dataFromday,st2,weakSelf.carDetailModel.formattedAddress];
                    } else
                    {
                        weakSelf.alertview.storeLaber.text = [NSString stringWithFormat:@"%@ %@%@ %@%@ %@",st2,ret[@"data"][@"Duration"],st3,st1,ret[@"data"][@"Distance"],weakSelf.carDetailModel.formattedAddress];
                    }
                    [weakSelf.alertview show];
                    
                    weakSelf.alertview.block = ^{
                        
                        
                        if (isCallNow) {
                            ///预约
                            [weakSelf callOrderHtpp:@"RESERVATION"];
                            
                        } else
                        {
                            /// 马上
                            [weakSelf callOrderHtpp:@"NORMAL"];
                        }
                    };
                };
            }
            
        } else
        {
            [self showToast:ret[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)loadFindeViewFormatteAddress
{
    
    
    if ([PattayaTool isUserLoginStats] == NO) {
        [[PattayaHttpRequest singleton] codeIsAccessToken:401];
    } else
    {
        WS(weakSelf);
        LocationViewController * locationVC = [[LocationViewController alloc] init];
        locationVC.actionAddress = 1;
        locationVC.AddressBlock = ^(AddressModel *mode) {
            weakSelf.carDetailModel.formattedAddress = mode.formattedAddress;
            weakSelf.carDetailModel.latitude = mode.latitude;
            weakSelf.carDetailModel.longitude = mode.longitude;
            weakSelf.carDetailModel.contactName = mode.contactName;
            weakSelf.carDetailModel.contactMobile = mode.contactMobile;
            weakSelf.carDetailModel.contactGender = mode.contactGender;
            weakSelf.carDetailModel.tagAlias = mode.tagAlias;
            [weakSelf.CarFindview addressToShow: weakSelf.carDetailModel.formattedAddress];
            [weakSelf checkCreateOrderRequest];
        };
        [self.navigationController pushViewController:locationVC animated:YES];
    }
    
    
//    
//    UserAddressViewController * addressVC = [[UserAddressViewController alloc] init];
//    addressVC.tpyeController = 2;
//    [weakSelf.navigationController pushViewController:addressVC animated:YES];
//    addressVC.addressBlock = ^(AddressModel *mode) {
//        weakSelf.carDetailModel.formattedAddress = mode.formattedAddress;
//        weakSelf.carDetailModel.latitude = mode.latitude;
//        weakSelf.carDetailModel.longitude = mode.longitude;
//        weakSelf.carDetailModel.contactName = mode.contactName;
//        weakSelf.carDetailModel.contactMobile = mode.contactMobile;
//        weakSelf.carDetailModel.contactGender = mode.contactGender;
//        weakSelf.carDetailModel.tagAlias = mode.tagAlias;
//        [weakSelf.CarFindview addressToShow: weakSelf.carDetailModel.formattedAddress];
//        [weakSelf checkCreateOrderRequest];
//    };
    
}

- (void)backViewPop:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addlistTabelview
{
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = self.view.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        [self.tableview.bottom_attr equalTo:self.view.bottom_attr_safe constant:-169];
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
    if(section == 0) return 1;
    return _model.goodsList.count + 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 46.5;
    }
    return 76.0f;
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
    if (section == 0) {
        return 10.0f;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            CarDetailsTitleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarDetailsTitleTableViewCell"];
            if (!cell) {
                cell = [[CarDetailsTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarDetailsTitleTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else
        {
            
            CarNameTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarNameTableViewCell"];
            if (!cell) {
                cell = [[CarNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarNameTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _model.goodsList[indexPath.row - 1];
            return cell;
        }
    } else
    {
        
        StoreNameCarDetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoreNameCarDetailsTableViewCell"];
        if (!cell) {
            cell = [[StoreNameCarDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreNameCarDetailsTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        WS(weakSelf);
        cell.blockMap = ^{
            [weakSelf showMapNavigationViewFormcurrentLatitude:_model];
        };
        return cell;
    }
    
}

- (void)showMapNavigationViewFormcurrentLatitude:(StoreDefileModel *)mode
{
UIAlertController * show= [PattayaTool showMapNavigationViewFormcurrentLatitude:[_carDetailModel.latitude doubleValue] currentLongitute:[_carDetailModel.longitude doubleValue] TotargetLatitude:_model.lat.doubleValue targetLongitute:_model.lon.doubleValue toName:_model.name];
    [self presentViewController:show animated:YES completion:nil];
}

- (void)callOrderHtpp:(NSString *)orderTpye
{
    if ([PattayaTool isNull:[PattayaTool token]]) {
        [[PattayaHttpRequest singleton] codeIsAccessToken:401];
        return;
    };
    NSLog(@"%@",[PattayaTool mobileDri]);
    NSLog(@"%@",_carDetailModel.contactName);
    if ([PattayaTool isNull:_carDetailModel.contactMobile]) {
        if ([PattayaTool isNull:[PattayaTool mobileDri]]) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
            return;
        }
    }
    NSLog(@"%@",_carDetailModel);
    
    
    NSDictionary * dic;
//    NSInteger tpy = 0;
    if ([orderTpye isEqualToString:@"RESERVATION"]) {
        dic = @{@"userCallFormattedAddress":_carDetailModel.formattedAddress,@"userCallLatitude":_carDetailModel.latitude,@"userCallLongitude":_carDetailModel.longitude,@"vehicleId":_model.dbStoreId,@"userMobile":[PattayaTool isNull:_carDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _carDetailModel.contactMobile,@"userName":[PattayaTool isNull:_carDetailModel.contactName] ?  [PattayaTool driName] : _carDetailModel.contactName,@"orderType":orderTpye,@"reservationTime":
                    [NSNumber numberWithLongLong:_dayTime]};
//        tpy = 1;
    } else
    {
        dic = @{@"userCallFormattedAddress":_carDetailModel.formattedAddress,@"userCallLatitude":_carDetailModel.latitude,@"userCallLongitude":_carDetailModel.longitude,@"vehicleId":_model.dbStoreId,@"userMobile":[PattayaTool isNull:_carDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _carDetailModel.contactMobile,@"userName":[PattayaTool isNull:_carDetailModel.contactName] ?  [PattayaTool driName] : _carDetailModel.contactName,@"orderType":orderTpye};
//        tpy = 2;
    }
      NSLog(@"手机号%@",[PattayaTool isNull:_carDetailModel.contactName] ?  [PattayaTool driName] : _carDetailModel.contactName);
    WS(weakSelf);
    [[PattayaUserServer singleton] callOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        
        if ([ResponseModel isData:ret]) {
            if ([[SystemAuthority singleton] notificationAuthority] == NO) {
                [GetAppDelegate timerinter];
            }
            callOrderModel * model = [[callOrderModel alloc] initWithDictionary:ret[@"data"] error:nil];
            NSLog(@"%@",model);
            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
            confirVC.orderId = model.id;
            [weakSelf.navigationController pushViewController:confirVC animated:YES];
        } else
        {
            if (![PattayaTool isNull:ret[@"code"]])
            {
                callOrderModel * model = [[callOrderModel alloc] initWithDictionary:ret[@"data"] error:nil];
                if ([CodeObject codeFind:ret] == 2) {
                    [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerCallOrderDir AlerCallBlack:^(NSInteger index, NSString *titl) {
                        if (index == 0) {
                            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                            confirVC.orderId = model.callOrderId;
                            [self.navigationController pushViewController:confirVC animated:YES];
                        }
                    }];
                } else
                {
                    [self showToast:ret[@"message"]];

                }
            } else
            {
                [self showToast:ret[@"message"]];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
///当前订单状态
- (void)processingOrderHttp:(NSInteger)tag
{
    [[PattayaUserServer singleton] getProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        if ([CodeObject codeFind:ret] == 405) {
            [self showToast:ret[@"message"]];
            return ;
        }
        if ([ResponseModel isData:ret]) {
            OrderDefModel * mode = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            if ([mode.status isEqualToString:@"CALLING"]) {
                
                if (tag == 0) {
                    ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                    confirVC.orderId = mode.id;
                    [self.navigationController pushViewController:confirVC animated:YES];
                }else
                {
                    [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerCallOrderDir AlerCallBlack:^(NSInteger index, NSString *titl) {
                        if (index == 0) {
                            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                            confirVC.orderId = mode.id;
                            [self.navigationController pushViewController:confirVC animated:YES];
                        }
                    }];
                }
                
                
                
            } else if ([mode.status isEqualToString:@"CALL_SUCCESSFUL"] || [mode.status isEqualToString:@"DRIVING"])
            {
                if (tag == 0) {
                    ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                    confirVC.orderId = mode.id;
                    [self.navigationController pushViewController:confirVC animated:YES];
                }else
                {
                    [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerUnderwayOrder AlerCallBlack:^(NSInteger index, NSString *titl) {
                        if (index == 0) {
                            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                            confirVC.orderId = mode.id;
                            [self.navigationController pushViewController:confirVC animated:YES];
                        }
                    }];
                }
            }
            else
            {
                
            }
            
        } else
        {
            //            [self showToast:ret[@"message"]];
        }
        
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
