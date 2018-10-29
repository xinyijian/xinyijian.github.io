//
//  MakeSureLocationViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MakeSureLocationViewController.h"
#import "SeachAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface MakeSureLocationViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel * address;
@property (nonatomic, strong) UILabel * addressDetails;
@property (nonatomic, strong) AMapLocationManager * locationManager;
@property (nonatomic, strong) NSString * addressBlock;
@property (nonatomic, strong) NSString * adCode;
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
@property (nonatomic, assign) BOOL islocation;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@end

@implementation MakeSureLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = NSLocalizedString(@"确认位置",nil);
    [AMapServices sharedServices].enableHTTPS = YES;
//    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.mapView.delegate = self;
//    self.mapView.zoomLevel = 19;
//    [self.view addSubview:self.mapView];
//    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
//
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 13;
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
    
  

    _islocation = NO;
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    NSLog(@"语言===%@",languageName);

    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 12;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 12;
     //带逆地理定位
    [self.locationManager setLocatingWithReGeocode:YES];
    if ([languageName containsString:@"zh"]) {
        _mapView.language = 0;
        self.locationManager.reGeocodeLanguage = AMapLocationReGeocodeLanguageChinse;

    } else
    {
        _mapView.language = 1;
        self.locationManager.reGeocodeLanguage = AMapLocationReGeocodeLanguageEnglish;

    }
    [self bottomViewAddress];
    NSLog(@"%@",self.mapView.userLocation);
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            _address.text = regeocode.POIName ? regeocode.POIName : regeocode.AOIName ? regeocode.AOIName : @"";
            if ([PattayaTool isNull:regeocode.district] && [PattayaTool isNull:regeocode.street] && [PattayaTool isNull:regeocode.number]) {
                _address.text = @"上海市";
            }
            _addressDetails.text = regeocode.formattedAddress;
            _addressBlock = [NSString stringWithFormat:@"%@%@",regeocode.formattedAddress ? regeocode.formattedAddress : @"上海市",regeocode.number ? regeocode.number : @""];
            if ([PattayaTool isNull:regeocode.formattedAddress]) {
                _addressBlock = @"上海市";
            }
            _adCode = regeocode.adcode;
            _latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            _longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            _islocation = YES;
            [self.mapView setCenterCoordinate:location.coordinate animated:YES];

        }
    }];
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];

    // Do any additional setup after loading the view.
}


- (void)bottomViewAddress
{
    UIView * backGroudView = [[UIView alloc] init];
    backGroudView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroudView];
    backGroudView.layer.cornerRadius = 4;
    [backGroudView activateConstraints:^{
        [backGroudView.left_attr equalTo:self.view.left_attr constant:15];
        [backGroudView.right_attr equalTo:self.view.right_attr constant:-15];
        [backGroudView.bottom_attr equalTo:self.view.bottom_attr constant:0];
        backGroudView.height_attr.constant = 140;
    }];
    
    _address = [[UILabel alloc]init];
    _address.font = fontStely(@"PingFangSC-Medium", 15);
    _address.textAlignment = NSTextAlignmentCenter;
    _address.textColor = TextColor;
    [backGroudView addSubview:_address];
    [_address activateConstraints:^{
        _address.left_attr = backGroudView.left_attr;
        _address.right_attr = backGroudView.right_attr;
        [_address.top_attr equalTo:backGroudView.top_attr constant:17.5];
        _address.height_attr.constant = 21;
    }];
    
    _addressDetails = [[UILabel alloc]init];
    [backGroudView addSubview: _addressDetails];
    [_addressDetails activateConstraints:^{
        [_addressDetails.top_attr equalTo:_address.bottom_attr constant:2.5];
        _addressDetails.right_attr = backGroudView.right_attr;
        [_addressDetails.left_attr equalTo:backGroudView.left_attr constant:0];
        _addressDetails.height_attr.constant = 21;
    }];
    _addressDetails.font = fontStely(@"PingFangSC-Medium", 13);
    _addressDetails.textAlignment = NSTextAlignmentCenter;
    _addressDetails.textColor = TextGrayColor;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backGroudView addSubview: btn];
    [btn activateConstraints:^{
        [btn.left_attr equalTo:backGroudView.left_attr constant:20];
        [btn.right_attr equalTo:backGroudView.right_attr constant:-20];
        btn.height_attr.constant = 35;
        [btn.top_attr equalTo:_addressDetails.bottom_attr constant:15.5];
    }];
    [btn setTitle:NSLocalizedString(@"确定",nil) forState:UIControlStateNormal];
    btn.backgroundColor = BlueColor;
    btn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    btn.layer.cornerRadius = 35/2.0f;
    [btn addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    seachBtn.backgroundColor = UIColorFromRGB(0xEDAF49);
    seachBtn.layer.cornerRadius = 24;
    [seachBtn setImage:[UIImage imageNamed:@"icon-Search1"] forState:UIControlStateNormal];
    [self.view addSubview:seachBtn];
    [seachBtn activateConstraints:^{
        [seachBtn.right_attr equalTo:self.view.right_attr constant:-30.5];
        seachBtn.width_attr.constant = 48;
        seachBtn.height_attr.constant = 48;
        [seachBtn.bottom_attr equalTo:self.view.bottom_attr constant:-170.5];
    }];
    seachBtn.backgroundColor = [UIColor redColor];
    [seachBtn addTarget:self action:@selector(searchActionVC:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)saveAddress:(UIButton *)btn
{
    if (_islocation) {
        
    BLOCK_EXEC(_block,_addressBlock,_adCode,_latitude,_longitude);
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)searchActionVC:(UIButton *)btn
{
    SeachAddressViewController * vc = [[SeachAddressViewController alloc]init];
    vc.poiModelBlock = ^(AMapPOI *mode) {
        NSLog(@"%@",mode);
        _address.text = mode.name;
        _addressDetails.text = mode.address;
        self.mapView.showsUserLocation = NO;
        _addressBlock = [NSString stringWithFormat:@"%@%@%@",mode.city,mode.district,mode.address];
        _adCode = mode.adcode;
        _latitude = [NSString stringWithFormat:@"%f",mode.location.latitude];
        _longitude = [NSString stringWithFormat:@"%f",mode.location.longitude];
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(mode.location.latitude,mode.location.longitude) animated:YES];

        
//        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(mode.location.latitude, mode.location.longitude);
//        pointAnnotation.title = mode.name;
//        pointAnnotation.subtitle =  mode.address;
        
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(mode.location.latitude, mode.location.longitude);
        annotation.title    = mode.name;
        annotation.subtitle =  mode.address;

        [self.mapView addAnnotation:annotation];
        
        
//        [_mapView addAnnotation:pointAnnotation];
//        [_mapView showAnnotations:@[pointAnnotation] animated:YES];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Map Delegate
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
    //    [UIImage imageNamed:@"icon--"]
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        //        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        //        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image =[UIImage imageNamed:@"icon-定位"];
//        pre.lineWidth = 3;
        //        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
    
}
/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifierConfirmation";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        annotationView.image = [UIImage imageNamed:@"icon--"];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        return annotationView;
    }  else if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        //        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        //        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image =[UIImage imageNamed:@"icon-定位"];
//        pre.lineWidth = 3;
        //        pre.lineDashPattern = @[@6, @3];
        [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];

//        [self.mapView updateUserLocationRepresentation:pre];
        
        //        view.calloutOffset = CGPointMake(0, 0);
        //        view.canShowCallout = NO;
        //        self.userLocationAnnotationView = view;
    }
    
    return nil;
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
