//
//  FindViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/2.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "DD_MAPointUserLocationView.h"
#import "FindViewController.h"
#import "FindCarView.h"
#import "LogInViewController.h"
#import "storeCategoryModel.h"
#import "DD_Alertview.h"
#import "UserAddressViewController.h"
#import "callOrderModel.h"
#import <MAMapKit/MAMapKit.h>
#import "StoreListModel.h"
#import "StoreCarDetailsVIew.h"
#import "CarStoreMAPointAnntation.h"
#import "CarStoreMAAnnotationView.h"
#import "StoreListModel.h"
#import "CarDetailsViewController.h"
#import "OrderDefModel.h"
#import "ConfirmationOrderViewController.h"
#import "LocationViewController.h"
#import "UserViewController.h"
#import "ListOrderViewController.h"
#import "ProtocolKit.h"
@interface FindViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,UITabBarControllerDelegate>
{
    NSMutableArray * arryaButn;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (strong, nonatomic) UIView * hotViewBlack;
@property (strong, nonatomic) UIButton * tmpBtn;
@property (nonatomic, strong) UIView * lineBottom;
@property (nonatomic, strong) UIView * BottomLocationView;
@property (nonatomic, strong) AMapLocationManager * locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D newLoc;
@property (nonatomic, strong) FindCarView * findview;
@property (nonatomic, assign) long long  dayTime;
@property (nonatomic, strong) CategoryListModel * categoryListModel;
@property (nonatomic, strong) NSString * callOrderId;
@property (nonatomic, strong) DD_Alertview * alertview;
@property (nonatomic, strong) NSString * dataFromday;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) NSMutableArray * arrAnnotation;
@property (nonatomic, strong) StoreCarDetailsVIew * StoreDeetailsBottomView;
@property (nonatomic, strong) OrderDefModel * orderModel;
@property (nonatomic, assign) NSInteger placeOrderTpye;
@property (strong, nonatomic) AddressModel * findCarDetailModel;
@property (assign, nonatomic) BOOL  isAddressSeletcd;
@property (assign, nonatomic) BOOL  isSeletcdFindViewController;
@property (nonatomic, strong) NSString * dbStoreId;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * lon;
@property (nonatomic, strong) DD_MAPointUserLocationView *DD_annotation;
@end

@implementation FindViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdCallDriverAcceptedFinViewController" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isSeletcdFindViewController = YES;
    self.tabBarController.delegate = self;
    _isAddressSeletcd = NO;
    _placeOrderTpye = 0;
    NSDictionary * rest = [ GetAppDelegate.locationAddress toDictionary];
    _findCarDetailModel = [[AddressModel alloc] initWithDictionary:rest error:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallDriverAcceptedFind:) name:@"KdCallDriverAcceptedFinViewController" object:nil];
    self.customTitle = NSLocalizedString(@"发现",nil);
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 13;
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    NSLog(@"语言===%@",languageName);
//    if ([languageName containsString:@"zh"]) {
//        _mapView.language = 0;
//    } else
//    {
//        _mapView.language = 1;
//    }
    _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
    UIButton * locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview: locationBtn];
    [locationBtn activateConstraints:^{
        [locationBtn.right_attr equalTo:self.view.right_attr constant:-27];
        [locationBtn.bottom_attr equalTo:self.view.bottom_attr_safe constant:-170];
        locationBtn.height_attr.constant = 55;
        locationBtn.width_attr.constant = 55;
    }];
    [locationBtn setImage:[UIImage imageNamed:@"Group 5"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationUser:) forControlEvents:UIControlEventTouchUpInside];
    
    _alertview = [[DD_Alertview alloc] initWithFrame:self.view.bounds stlyeView:DD_AlertviewStlyeConfirm navStatusHeight:NavtinavigationYBottom];
    [PattAmapLocationManager singleton].isNowlocationBlock = ^(CLLocation *location, NSString *address) {
        if (_isAddressSeletcd == NO) {
            _findCarDetailModel = [[AddressModel alloc] init];
            _findCarDetailModel.formattedAddress = address;
            [_findview addressToShow:_findCarDetailModel.formattedAddress];
            _findCarDetailModel.longitude =[NSString stringWithFormat:@"%f",location.coordinate.longitude];
            _findCarDetailModel.latitude =[NSString stringWithFormat:@"%f",location.coordinate.latitude];
//            _isAddressSeletcd = YES;
            [_mapView removeAnnotation:_DD_annotation];
        }
    };
    [PattAmapLocationManager singleton].isLocation = NO;

    [self categoryHttp];
    [self bottomViewLocation];
    
}

- (void)nativeRightBottom
{
    [self rightBarButtonWithTitle:NSLocalizedString(@"进行中",nil) color:[UIColor blackColor] action:^{
        [self processingOrderHttp:0];
        
    }];
}

- (void)SeachStoreCodeRequestHTTP:(NSString *)category
{
    [_findview timeStop];
    if ([[SystemAuthority singleton] locationAuthority]) {
        NSMutableDictionary * dicSave = [[NSMutableDictionary alloc] init];
        if (![PattayaTool isNull:_findCarDetailModel.latitude]) {
            [dicSave setObject:_findCarDetailModel.latitude forKey:@"latitude"];
            [dicSave setObject:_findCarDetailModel.longitude forKey:@"longitude"];
        }
        [dicSave setObject:@"DISTANCE" forKey:@"orderBy"];
        if (![PattayaTool isNull:category]) {
            [dicSave setObject:category forKey:@"category"];
        }
        [[PattayaUserServer singleton] SeachStoreCodeRequest:dicSave success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
            NSLog(@"RET = %@",ret);
            if ([ResponseModel isData:ret]) {
                StoreListModel * list = [[StoreListModel alloc] initWithDictionary:ret[@"data"] error:nil];
                //           storeCategoryModel
                if (self.mapView.annotations.count > 0) {
                    [self.mapView removeAnnotations:self.mapView.annotations];
                }
                if (list.content.count > 0) {
                    _arrAnnotation = [NSMutableArray array];
                    NSString * st1 = NSLocalizedString(@"月服务 ",nil);
                    NSString * st2 = NSLocalizedString(@"次",nil);
                    NSString * st3 = NSLocalizedString(@"服务费",nil);
                    NSString * st4 = NSLocalizedString(@"元",nil);
                    NSString * st5 = NSLocalizedString(@"米",nil);
                    for (StoreDefileModel * modeMake  in list.content) {
                        CarStoreMAPointAnntation *annotation = [[CarStoreMAPointAnntation alloc] init];
                        annotation.coordinate = CLLocationCoordinate2DMake(modeMake.lat.floatValue, modeMake.lon.floatValue);
                        annotation.carId = modeMake.dbStoreId.stringValue;
                        annotation.lat = _findCarDetailModel.latitude;
                        annotation.lon = _findCarDetailModel.longitude;
                        annotation.feeLaber = [NSString stringWithFormat:@"%@%@%@／%@%@%@",st1,modeMake.saleAmountMonth,st2,st3,modeMake.serviceFee,st4];
                        annotation.apartLaber = [NSString stringWithFormat:@"%@%@",modeMake.geoDistance,st5];
                        annotation.addressLaber = _findCarDetailModel.formattedAddress;
                        annotation.categoryName = modeMake.categoryName;
                        annotation.storeName = modeMake.name;
                        annotation.title = modeMake.categoryName;
                        [_arrAnnotation addObject:annotation];
                    }
                    [self.mapView removeAnnotations:self.mapView.annotations];
                    [self.mapView addAnnotations:_arrAnnotation];
                    [self.mapView showAnnotations:_arrAnnotation animated:NO];
//                    self.mapView.zoomLevel = self.mapView.zoomLevel - 2;
                    NSLog(@"%f",self.mapView.zoomLevel);
                    //                [_mapView selectAnnotation:annotation animated:YES];
                }
            } else
            {
                [self showToast:ret[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    };
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image =[UIImage imageNamed:@"icon-定位"];
        //        pre.lineWidth = 3;
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
        //   [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CarStoreMAPointAnntation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CarStoreMAAnnotationView *annotationView = (CarStoreMAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CarStoreMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            // 给Marker点添加手势
            [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMarkerClick:)]];
        }
        annotationView.calloutOffset = CGPointMake(0, -5);
        annotationView.image = [UIImage imageNamed:@"che"];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        return annotationView;
    } else if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image =[UIImage imageNamed:@"icon-定位"];
        _newLoc = annotation.coordinate;
        [self.mapView setCenterCoordinate:_newLoc animated:YES];

    } else if ([annotation isKindOfClass:[DD_MAPointUserLocationView class]])
    {
        static NSString *customReuseIndetifier = @"DD_customReuseIndetifierConfirmation";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
//            annotationView.canShowCallout = NO;
//            annotationView.draggable = YES;
//            annotationView.calloutOffset = CGPointMake(0, -5);
        }
            annotationView.image = [UIImage imageNamed:@"icon--"];
        return annotationView;
    }
    return nil;
}
// Marker选中事件
- (void)onMarkerClick:(UITapGestureRecognizer *)gesture
{
    // 这里做你想的事情
    CarStoreMAAnnotationView *annoView = (CarStoreMAAnnotationView*)gesture.view;
    NSLog(@"选中了: %@",annoView.annotation);
    // 解决5.0.0上Annotation选中后重用的bug.
    if(annoView.annotation == self.mapView.selectedAnnotations.firstObject)
    {
        if(annoView.selected == NO)
        {
            [annoView setSelected:YES animated:YES];
        }
        return;
    }
    else
    {
        [self.mapView selectAnnotation:annoView.annotation animated:YES];
    }
    _findview.hidden = YES;
    _StoreDeetailsBottomView.hidden = NO;
    _placeOrderTpye = 1;
    _StoreDeetailsBottomView.title.text = annoView.storeName;
    _StoreDeetailsBottomView.addressLaber.text = annoView.addressLaber;
    _StoreDeetailsBottomView.feeLaber.text = annoView.feeLaber;
    _StoreDeetailsBottomView.apartLaber.text = annoView.apartLaber;
    _StoreDeetailsBottomView.dbStore = annoView.carId;
    _dbStoreId = annoView.carId;
    _lat = annoView.lat;
    _lon = annoView.lon;
    //    [self getStoreIdDetaileHttp:annoView.carId latitude:annoView.lat longitude:annoView.lon];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    _placeOrderTpye = 0;
    NSLog(@"取消");
    _findview.hidden = NO;
    _StoreDeetailsBottomView.hidden = YES;
}
//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
//{
//
//}


- (void)locationUser:(UIButton *)btn
{
    //    NSLog(@"%@",_newLoc);
    //    NSLog(@"%@",_mapView.userLocation.coordinate);
    [PattAmapLocationManager singleton].isLocation = NO;
    _isAddressSeletcd = NO;
    [self.mapView setCenterCoordinate:_newLoc animated:YES];
    
}

- (void)scrollviewLineView
{
    arryaButn = [NSMutableArray array];
    
    UIView * shadowcolorAndShadow = [[UIView alloc]init];
    [self.view addSubview:shadowcolorAndShadow];
    shadowcolorAndShadow.backgroundColor = [UIColor whiteColor];
    [shadowcolorAndShadow activateConstraints:^{
        [shadowcolorAndShadow.top_attr equalTo:self.view.top_attr_safe constant:0];
        shadowcolorAndShadow.width_attr.constant = SCREEN_Width;
        shadowcolorAndShadow.height_attr.constant = 35;
    }];
    [PattayaTool shadowColorAndShadowOpacity:shadowcolorAndShadow color:@"#EDECEC" Alpha:0.77];
    [arryaButn addObject:shadowcolorAndShadow];
    UIScrollView * scroller = [[UIScrollView alloc]init];
    [self.view addSubview:scroller];
    scroller.backgroundColor = UIColor.whiteColor;
    [scroller activateConstraints:^{
        [scroller.top_attr equalTo:self.view.top_attr_safe constant:0];
        scroller.width_attr.constant = SCREEN_Width;
        scroller.height_attr.constant = 35;
    }];
    [arryaButn addObject:scroller];
    for (int i = 0; i < _categoryListModel.data.count; i++) {
        storeCategoryModel * model = _categoryListModel.data[i];
        UIButton * locationBtn1 = [self initbuttonStyeframe: CGRectMake(40 + i * 54, 5, 48, 24) font:fontStely(@"PingFangSC-Regular", 12) text:model.name];
        locationBtn1.tag = model.categoryId.integerValue + 99292929;
        if (i==0) {
            locationBtn1.selected = YES;
            _tmpBtn = locationBtn1;
            _callOrderId = model.categoryId;
        }
        [arryaButn addObject:locationBtn1];
        [scroller addSubview:locationBtn1];
    }
    scroller.contentSize = CGSizeMake(_categoryListModel.data.count * 54 + 40, 0);
    UIView * lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 33.5, 30, 2.5)];
    lineBottom.backgroundColor = BlueColor;
    lineBottom.centerX = _tmpBtn.centerX;
    [scroller addSubview:lineBottom];
    _lineBottom = lineBottom;
    [self animateWithBtn:_tmpBtn];
    
    [self SeachStoreCodeRequestHTTP:_callOrderId];
    [arryaButn addObject:lineBottom];
}

- (UIButton *)initbuttonStyeframe:(CGRect)frame font:(UIFont *)font text:(NSString *)title
{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:TextColor forState:UIControlStateSelected];
    [btn setTitleColor:UIColorFromRGB(0xC2C6DA) forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)actionBtn:(UIButton *)btn
{
    if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
        [self animateWithBtn:_tmpBtn];
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
    }else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [self animateWithBtnDidcompletion:_tmpBtn];
        btn.selected = YES;
        [self animateWithBtn:btn];
        
        _tmpBtn = btn;
    }
    _callOrderId = [NSString stringWithFormat:@"%ld",_tmpBtn.tag - 99292929];
    [self.mapView removeAnnotations:_arrAnnotation];
    [self SeachStoreCodeRequestHTTP:_callOrderId];
    
}

- (void)animateWithBtn:(UIButton *)btn
{
    [UIView animateWithDuration:0.2  animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        btn.transform = transform;
        _lineBottom.centerX = btn.centerX;
        
        
    } completion:nil];
}
- (void)animateWithBtnDidcompletion:(UIButton *)btn
{
    [UIView animateWithDuration:0.2  animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        
        btn.transform = transform;
        
    } completion:nil];
}


- (void)bottomViewLocation
{
    [self orderCallinitUI];
    _StoreDeetailsBottomView = [[StoreCarDetailsVIew alloc]init];
    _StoreDeetailsBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_StoreDeetailsBottomView];
    _StoreDeetailsBottomView.hidden = YES;
    [_StoreDeetailsBottomView activateConstraints:^{
        [_StoreDeetailsBottomView.left_attr equalTo:self.view.left_attr constant:15];
        [_StoreDeetailsBottomView.right_attr equalTo:self.view.right_attr constant:-15];
        _StoreDeetailsBottomView.height_attr.constant = 169;
        [_StoreDeetailsBottomView.bottom_attr equalTo:self.view.bottom_attr_safe constant:-15];
    }];
    [PattayaTool shadowColorAndShadowOpacity:_StoreDeetailsBottomView color:@"#000000" Alpha:0.2];
    [_StoreDeetailsBottomView.callOrderBtn addTarget:self action:@selector(StoreDeetailCallOrder) forControlEvents:UIControlEventTouchUpInside];
    [_StoreDeetailsBottomView.detailsBtn addTarget:self action:@selector(pushDetailViewContoller) forControlEvents:UIControlEventTouchUpInside];
    [_StoreDeetailsBottomView.closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf);
    _StoreDeetailsBottomView.clickEdit = ^{
        [weakSelf editOrderAddressSet];
    };
}

- (void)orderCallinitUI{
    _findview = [[FindCarView alloc]initWithFrame:CGRectZero stlype:0];
    [self.view addSubview:_findview];
    
  if (@available(iOS 11.0, *)) {
        [_findview activateConstraints:^{
            _findview.bottom_attr =self.view.bottom_attr_safe;
            [_findview.left_attr equalTo:self.view.left_attr constant:15];
            [_findview.right_attr equalTo:self.view.right_attr constant:-15];
            _findview.height_attr.constant = 133;
        }];
    } else
    {
        [_findview activateConstraints:^{
            [_findview.bottom_attr equalTo:self.view.bottom_attr constant:-49];
            [_findview.left_attr equalTo:self.view.left_attr constant:15];
            [_findview.right_attr equalTo:self.view.right_attr constant:-15];
            _findview.height_attr.constant = 133;
        }];
    }
 
    [PattayaTool shadowColorAndShadowOpacity:_findview color:@"#000000" Alpha:0.2];
    [_findview addressToShow:_findCarDetailModel.formattedAddress];
    _findview.picker.pickeblock = ^(NSDate *data) {
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
    NSString * st2= NSLocalizedString(@"地址：",nil);
    _findview.block = ^(BOOL isCallNow) {
        if ([PattayaTool isNull:[PattayaTool token]]) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
            return;
        };
        
        if (isCallNow) {
            NSString * st1= NSLocalizedString(@"预约时间：",nil);
            weakSelf.alertview.storeLaber.text = [NSString stringWithFormat:@"%@%@\n%@%@",st1,weakSelf.dataFromday,st2,weakSelf.findCarDetailModel.formattedAddress];
        } else
        {
            weakSelf.alertview.storeLaber.text = [NSString stringWithFormat:@"%@%@",st2,weakSelf.findCarDetailModel.formattedAddress];
        }
        [weakSelf.alertview show];
        weakSelf.alertview.block = ^{
            if (isCallNow) {
                ///预约
                [weakSelf callCarHtpp:@"RESERVATION"];
                
            } else
            {
                /// 马上
                [weakSelf callCarHtpp:@"NORMAL"];
            }
        };
    };
    _findview.addressBlock = ^{
        [weakSelf loadFindeViewFormatteAddress];
    };
    
}
- (void)loadFindeViewFormatteAddress
{
    [self editOrderAddressSet];
}
///编辑当前地址
- (void)editOrderAddressSet
{
    if ([PattayaTool isUserLoginStats] == NO)
    {
        [[PattayaHttpRequest singleton] codeIsAccessToken:401];
    } else
    {
        WS(weakSelf);
        LocationViewController * locationVC = [[LocationViewController alloc] init];
        locationVC.actionAddress = 1;
        locationVC.AddressBlock = ^(AddressModel *mode) {
            /// isAddressSeletcd 是 开关 及时定位
            _isAddressSeletcd = YES;
            weakSelf.findCarDetailModel.formattedAddress = mode.formattedAddress;
            weakSelf.findCarDetailModel.latitude = mode.latitude;
            weakSelf.findCarDetailModel.longitude = mode.longitude;
            weakSelf.findCarDetailModel.contactName = mode.contactName;
            weakSelf.findCarDetailModel.contactMobile = mode.contactMobile;
            weakSelf.findCarDetailModel.contactGender = mode.contactGender;
            weakSelf.findCarDetailModel.tagAlias = mode.tagAlias;
            [weakSelf.findview addressToShow: weakSelf.findCarDetailModel.formattedAddress];
            weakSelf.StoreDeetailsBottomView.addressLaber.text = weakSelf.findCarDetailModel.formattedAddress;
            NSString * lats = mode.latitude;
            NSString * lont = mode.longitude;
            if (![PattayaTool isNull:_dbStoreId]) {
                lats = _lat;
                lont = _lon;
            }
            [self.mapView removeAnnotation:_DD_annotation];

            [[PattayaUserServer singleton] checkCreateOrderRequest:@{@"endLatitude":mode.latitude,@"endLongitude":mode.longitude,@"startLatitude":lats,@"startLongitude":lont} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                if ([ResponseModel isData:ret]) {
//                    NSString * st5 = NSLocalizedString(@"米",nil);
                   weakSelf.StoreDeetailsBottomView.apartLaber.text = [NSString stringWithFormat:@"%@",ret[@"data"][@"Distance"]];
                    _DD_annotation = [[DD_MAPointUserLocationView alloc] init];
                    _DD_annotation.coordinate = CLLocationCoordinate2DMake(lats.floatValue,lont.floatValue);
                    [self.mapView addAnnotation:_DD_annotation];
                    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
                    self.mapView.zoomLevel = self.mapView.zoomLevel - 2;

                } else
                {
                    [self showToast:ret[@"message"]];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];

//            weakSelf.StoreDeetailsBottomView.apartLaber.text = [NSString stringWithFormat:@"%f",apar * 1000];
        };
        [self.navigationController pushViewController:locationVC animated:YES];
    }
    
}
///点击车辆然后显示的UI里面的立刻召唤
- (void)StoreDeetailCallOrder
{
    NSString * st2= NSLocalizedString(@"地址：",nil);
    WS(weakSelf);
    self.alertview.storeLaber.text = [NSString stringWithFormat:@"%@%@",st2,_findCarDetailModel.formattedAddress];
    [weakSelf.alertview show];
    self.alertview.block = ^{
        [weakSelf callCarHtpp:@"NORMAL"];
    };
}
///跳转详情
- (void)pushDetailViewContoller
{
    CarDetailsViewController * vc = [[CarDetailsViewController alloc]init];
    vc.storeId = _StoreDeetailsBottomView.dbStore;
    NSDictionary * rest = [ GetAppDelegate.locationAddress toDictionary];
    vc.carDetailModel = [[AddressModel alloc] initWithDictionary:rest error:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)closeView
{
    _StoreDeetailsBottomView.hidden = YES;
    _findview.hidden = NO;
}
- (void)alerShow:(NSString *)orderId
{
    [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerCallOrderDir AlerCallBlack:^(NSInteger index, NSString *titl) {
        if (index == 0) {
            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
            confirVC.orderId = orderId;
            [self.navigationController pushViewController:confirVC animated:YES];
        }
    }];
    
}
- (NSDictionary *)saveDictionaryinit:(NSString *)orderTpye
{
  
    
    if ([PattayaTool isNull:_findCarDetailModel.contactMobile]) {
        if ([PattayaTool isNull:[PattayaTool mobileDri]]) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
            }
        }
            NSDictionary * dic;
            if ([orderTpye isEqualToString:@"RESERVATION"]) {
                dic = @{@"userCallFormattedAddress":_findCarDetailModel.formattedAddress,@"userCallLatitude":_findCarDetailModel.latitude,@"userCallLongitude":_findCarDetailModel.longitude,@"callCategoryId":_callOrderId ? _callOrderId : @"1",@"userMobile":[PattayaTool isNull:_findCarDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _findCarDetailModel.contactMobile,@"userName":[PattayaTool isNull:_findCarDetailModel.contactName] ?  [PattayaTool driName] : _findCarDetailModel.contactName,@"orderType":orderTpye,@"reservationTime":
                            [NSNumber numberWithLongLong:_dayTime]};
                
            } else
            {
                ///没有直接选择车辆品类
                if (_placeOrderTpye == 0) {
                    dic = @{@"userCallFormattedAddress":_findCarDetailModel.formattedAddress,@"userCallLatitude":_findCarDetailModel.latitude,@"userCallLongitude":_findCarDetailModel.longitude,@"callCategoryId":_callOrderId ? _callOrderId : @"1",@"userMobile":[PattayaTool isNull:_findCarDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _findCarDetailModel.contactMobile,@"userName":[PattayaTool isNull:_findCarDetailModel.contactName] ?  [PattayaTool driName] : _findCarDetailModel.contactName,@"orderType":orderTpye};
                } else
                {
                    dic =@{@"userCallFormattedAddress":_findCarDetailModel.formattedAddress,@"userCallLatitude":_findCarDetailModel.latitude,@"userCallLongitude":_findCarDetailModel.longitude,@"userMobile":[PattayaTool isNull:_findCarDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _findCarDetailModel.contactMobile,@"userName":[PattayaTool isNull:_findCarDetailModel.contactName] ?  [PattayaTool driName] : _findCarDetailModel.contactName,@"orderType":orderTpye,@"vehicleId":_dbStoreId};
                }
            }
            return dic;
}

- (void)callCarHtpp:(NSString *)orderTpye
{
    if ([PattayaTool isNull:[PattayaTool token]]) {
        [[PattayaHttpRequest singleton] codeIsAccessToken:401];
        return;
    };
    
    if ([PattayaTool isNull:_findCarDetailModel.contactMobile]) {
        if ([PattayaTool isNull:[PattayaTool mobileDri]]) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
            return;
        }
    }
    if ([PattayaTool isNull:_findCarDetailModel.contactName]) {
        if ([PattayaTool isNull:[PattayaTool driName]]) {
            [[PattayaHttpRequest singleton] codeIsAccessToken:401];
            return;
        }
    }
    NSDictionary * dic = [self saveDictionaryinit:orderTpye];
    if ([PattayaTool isNull:dic]) {
        return;
    }
    [[PattayaUserServer singleton] callOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        if ([CodeObject codeFind:ret] == 405 || [CodeObject codeFind:ret] == 4) {
            [self showToast:ret[@"message"]];
            return ;
        }
        
        if ([ResponseModel isData:ret]) {
            callOrderModel * model = [[callOrderModel alloc] initWithDictionary:ret[@"data"] error:nil];
            if ([[SystemAuthority singleton] notificationAuthority] == NO) {
                [GetAppDelegate timerinter];
            }
            NSLog(@"%@",model);
            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
            confirVC.orderId = model.id;
            [self.navigationController pushViewController:confirVC animated:YES];
        } else
        {
            if (![PattayaTool isNull:ret[@"code"]])
            {
                callOrderModel * model = [[callOrderModel alloc] initWithDictionary:ret[@"data"] error:nil];
                if ([CodeObject codeFind:ret] == 2) {
                 
                    [self alerShow:model.callOrderId];

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

- (void)categoryHttp
{
    [[PattayaUserServer singleton] categoryRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            _categoryListModel = [[CategoryListModel alloc] initWithDictionary:ret error:nil];
            [self scrollviewLineView];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)CallDriverAcceptedFind:(NSNotification *)info
{
    ///1.接单 2.司机到达 3取消
    WS(weakSelf);
    NSDictionary * order = info.object;
    if ([order[@"tpy"] isEqualToString:@"1"]) {
        [weakSelf rightBarButtonWithTitle:NSLocalizedString(@"进行中",nil) color:[UIColor blackColor] action:^{
            ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
            confirVC.orderId = order[@"orderId"];
            [weakSelf.navigationController pushViewController:confirVC animated:YES];
        }];
    } else if ([order[@"tpy"] isEqualToString:@"2"] || [order[@"tpy"] isEqualToString:@"3"])
    {
        [self rightBarButtonWithTitle:@"" color:[UIColor whiteColor] action:^{
        }];
    }
    
}

- (void)callOrderIdState:(NSString *)orderId
{
    [[PattayaUserServer singleton] getcallorderRequest:orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            _orderModel = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            NSLog(@"%@",_orderModel);
            _findview.hidden = NO;
            _StoreDeetailsBottomView.hidden = YES;
        } else
        {
            [self showToast:ret[@"message"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

///当前订单状态
- (void)processingOrderHttp:(NSInteger)tag
{
    [[PattayaUserServer singleton] getProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            OrderDefModel * mode = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            if ([mode.status isEqualToString:@"CALLING"] || [mode.status isEqualToString:@"CALL_SUCCESSFUL"] || [mode.status isEqualToString:@"DRIVING"]) {
                [self nativeRightBottom];
                if (tag == 0) {
                    ConfirmationOrderViewController *  confirVC = [[ConfirmationOrderViewController alloc] init];
                    confirVC.orderId = mode.id;
                    [self.navigationController pushViewController:confirVC animated:YES];
                }else
                {
                    [self alerShow:mode.id];
                }
            }
        } else
        {
            if ([CodeObject codeFind:ret] != 1) {
                [self showToast:ret[@"message"]];
            } else
            {
                [self rightBarButtonWithTitle:@"" color:[UIColor whiteColor] action:^{
                }];
            }
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UIViewController * views = [PattayaTool findBestViewController:viewController];
    if (tabBarController.selectedIndex == 1) {
        if (_isSeletcdFindViewController) {
            [self processingOrderHttp:1];
            for (UIView * views in arryaButn) {
                [views removeFromSuperview];
            }
            [self categoryHttp];
            _isSeletcdFindViewController = NO;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[NSLocale currentLocale]];
            [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString * st = [dateFormatter stringFromDate:[NSDate date]];
            [_findview pickerminLimitDate:st];
        }

    } else if (tabBarController.selectedIndex == 0)
    {
        _isSeletcdFindViewController = YES;
        for (UIView * views in arryaButn) {
            [views removeFromSuperview];
        }
        
    } else if (tabBarController.selectedIndex == 3)
    {
        for (UIView * views in arryaButn) {
            [views removeFromSuperview];
        }
        _isSeletcdFindViewController = YES;
        [(UserViewController *)views userInfoHttp];
    } else if (tabBarController.selectedIndex == 2)
    {
        _isSeletcdFindViewController = YES;
        for (UIView * views in arryaButn) {
            [views removeFromSuperview];
        }
        [(ListOrderViewController*)views ConsumeOrderHttp];
    }
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
