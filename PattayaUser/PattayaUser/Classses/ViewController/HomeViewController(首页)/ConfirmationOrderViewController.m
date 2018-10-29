//
//  ConfirmationOrderViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/7.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ConfirmationOrderViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "MyCallView.h"
#import "MANaviRoute.h"
#import "FindCarView.h"
#import "DD_Alertview.h"
#import "RouterObject.h"
#import "AlerViewShowUI.h"
static const NSInteger RoutePlanningPaddingEdge                    = 20;
#define RoutePlanningViewControllerStartTitle @"司机起点"
#define RoutePlanningViewControllerDestinationTitle @"用户终点"
@interface ConfirmationOrderViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
{
    MBProgressHUD *loadingView;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager * locationManager;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) MyCallView * callBottomView;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, strong) MANaviRoute *naviRoute;
@property (nonatomic, strong) FindCarView * findview;
@property (nonatomic, strong) OrderDefModel * orderModel;
@property (nonatomic, strong) DD_Alertview * alertview;
@property (nonatomic, strong) NSString * dataFromday;
@property (nonatomic, assign) NSTimeInterval  dayTime;
@property (nonatomic, strong) OrderDefModel * model;
@end

@implementation ConfirmationOrderViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdConfirmationOrderViewController" object:nil];
}
- (void)ConfirmationOrderNet:(NSNotification *)info
{
    [_findview  timeStop];
    WS(weakSelf);
    NSDictionary * order = info.object;
    if ([order[@"tpy"] isEqualToString:@"1"]) {
        [self callOrderIdState:order[@"orderId"]];
    } else if ([order[@"tpy"] isEqualToString:@"2"])
    {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } else if ([order[@"tpy"] isEqualToString:@"3"])
    {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ConfirmationOrderNet:) name:@"KdConfirmationOrderViewController" object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderUpdate) name:@"ConfirmationOrderViewController" object:nil];
    [self amapviewInit];
    
    // Do any additional setup after loading the view.
}
- (void)showLoading:(UIViewController *)views
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(loadingView == nil){
            loadingView = [[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 64 + 60, SCREEN_Width, views.view.frame.size.height-64 - 60)];
            loadingView.backgroundColor = [PattayaTool colorWithHexString:@"1F1F21" Alpha:0.5];
            [views.view addSubview:loadingView];
            [loadingView showAnimated:YES];
            loadingView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                loadingView.alpha = 1;
            }];
        }
    });
    
}
- (void)hideLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(loadingView != nil){
            loadingView.alpha = 1;
            [UIView animateWithDuration:0.5 animations:^{
                loadingView.alpha = 0;
                [loadingView hideAnimated:YES];
                [loadingView removeFromSuperview];
                loadingView = nil;
            }];
        }
    });
}

- (void)amapviewInit
{
    self.customTitle = NSLocalizedString(@"我的召唤",nil);
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 13;
    [self.view addSubview:self.mapView];
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    WS(weakSelf);
    [self rightBarButtonWithTitle:@"取消订单" color:BlueColor action:^{
        if ([PattayaTool isNull:_orderId]) {
            _orderId = _model.id;
        }
        [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerInProgressOrder AlerCallBlack:^(NSInteger index, NSString *titl) {
            [[PattayaUserServer singleton] PUTcallorderRequest:_orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                NSLog(@"取消订单");
                if ([ResponseModel isData:ret]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
        }];
       
    }];
    
    NSLog(@"语言===%@",languageName);
    if ([languageName containsString:@"zh"]) {
        _mapView.language = 0;
    } else
    {
        _mapView.language = 1;
    }
    self.mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    _callBottomView = [[MyCallView alloc]init];
    _callBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_callBottomView];
    [_callBottomView activateConstraints:^{
        _callBottomView.bottom_attr =self.view.bottom_attr_safe;
        [_callBottomView.left_attr equalTo:self.view.left_attr constant:15];
        [_callBottomView.right_attr equalTo:self.view.right_attr constant:-15];
        _callBottomView.height_attr.constant = 140;
    }];
 
    [PattayaTool shadowColorAndShadowOpacity:_callBottomView color:@"#000000" Alpha:0.2];
    _callBottomView.hidden = YES;
    
    
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
    [self orderCallinitUI];
    [self orderResfDefiale:_orderId];
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];

}
- (void)locationUser:(UIButton *)btn{
    self.mapView.zoomLevel = 13;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}
- (void)addDefaultAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = CLLocationCoordinate2DMake(_model.driverAcceptedLatitude.floatValue, _model.driverAcceptedLongitude.floatValue);
    startAnnotation.title      = RoutePlanningViewControllerStartTitle;
    self.startAnnotation = startAnnotation;
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate =  CLLocationCoordinate2DMake(_model.userCallLatitude.floatValue, _model.userCallLongitude.floatValue);
    destinationAnnotation.title      = RoutePlanningViewControllerDestinationTitle;
    self.destinationAnnotation = destinationAnnotation;
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
//    [self.mapView showAnnotations:@[startAnnotation,destinationAnnotation] animated:YES];
}

#pragma mark - do search
- (void)searchRoutePlanningDrive
{
    self.startAnnotation.coordinate = CLLocationCoordinate2DMake(_model.driverAcceptedLatitude.floatValue, _model.driverAcceptedLongitude.floatValue);
    self.destinationAnnotation.coordinate = CLLocationCoordinate2DMake(_model.userCallLatitude.floatValue, _model.userCallLongitude.floatValue);
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    navi.strategy = 5;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:_model.driverAcceptedLatitude.floatValue
                                           longitude:_model.driverAcceptedLongitude.floatValue];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:_model.userCallLatitude.floatValue
                                                longitude:_model.userCallLongitude.floatValue];
    
    [self.search AMapDrivingRouteSearch:navi];
    
    ///出发地 就是订单用户的经纬度
    ///到达地址 就是司机的经纬度
}
/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    //    [self hideLoading];
    if (response.route == nil)
    {
        return;
    }
    self.route = response.route;
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
}
/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[0] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    self.naviRoute.multiPolylineColors = @[UIColorFromRGB(0xfd6568),UIColorFromRGB(0xf87762),UIColorFromRGB(0xf19659),UIColorFromRGB(0xecae53)];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView showOverlays:self.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image =[UIImage imageNamed:@"icon-定位"];
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
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
        /* 起点. */
        if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
        {
            annotationView.image = [UIImage imageNamed:@"che"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
        {
            annotationView.image = [UIImage imageNamed:@"icon--"];
        } else
        {
            annotationView.image = [UIImage imageNamed:@"che"];
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        }
        return annotationView;
    } else if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image =[UIImage imageNamed:@"icon-定位"];
//        pre.lineWidth = 3;
        [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
//        [self.mapView updateUserLocationRepresentation:pre];
    }
    return nil;
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        polylineRenderer.lineDashPhase = 4; // 1
        NSArray* array = [NSArray arrayWithObjects:[NSNumber numberWithInt:8] ,[NSNumber numberWithInt:8],nil]; // 2
        polylineRenderer.lineDashPattern = array; // 3
        
        polylineRenderer.lineWidth = 3.5f;
        polylineRenderer.strokeColor = UIColorFromRGB(0xD2555A);
        polylineRenderer.lineJoin =kCGLineJoinBevel;
        polylineRenderer.lineCap =kCGLineCapSquare;
        return polylineRenderer;
    }
    return nil;
}

- (void)callOrderIdState:(NSString *)orderId
{
    [[PattayaUserServer singleton] getcallorderRequest:orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            _orderModel = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            NSLog(@"%@",_orderModel);
            _findview.hidden = YES;
            _callBottomView.hidden = NO;
            _callBottomView.moblieNumber = _orderModel.driverMobile;
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)orderCallinitUI{
    WS(weakSelf);
    _findview = [[FindCarView alloc]initWithFrame:CGRectZero stlype:0];
    [self.view addSubview:_findview];
    [_findview activateConstraints:^{
        _findview.bottom_attr =self.view.bottom_attr_safe;
        [_findview.left_attr equalTo:self.view.left_attr constant:15];
        [_findview.right_attr equalTo:self.view.right_attr constant:-15];
        _findview.height_attr.constant = 133;
    }];
    _findview.canlesBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    _findview.timeoutBlock = ^{
        BLOCK_EXEC(weakSelf.timeoutBlock);
    };
    [PattayaTool shadowColorAndShadowOpacity:_findview color:@"#000000" Alpha:0.2];
    _findview.hidden = YES;
}
- (void)orderResfDefiale:(NSString *)orderId
{
    [[PattayaUserServer singleton] getcallorderRequest:orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
        OrderDefModel * mode = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
        _model = mode;
        if ([mode.status isEqualToString:@"CALLING"]) {
            _findview.orderId = mode.id;
            if ([mode.orderType isEqualToString:@"NORMAL"]) {
                [_findview callOrderResp:mode.timeLeft.integerValue isOrderTpye:2 time:mode.timeReservation];
            } else
            {
                [_findview callOrderResp:mode.timeLeft.integerValue isOrderTpye:1 time:mode.timeReservation];
            }
            _callBottomView.hidden = YES;
            _findview.hidden = NO;
        } else if ([mode.status isEqualToString:@"CANCELED"]){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            _callBottomView.hidden = NO;
            _findview.hidden = YES;
        }
        _findview.addressUser = mode.userCallFormattedAddress;
        _callBottomView.titleLaber.text = mode.userCallFormattedAddress;
        _callBottomView.moblieNumber = mode.driverMobile;
        [self searchRoutePlanningDrive];
        [self addDefaultAnnotations];
    } else
     {
         if (![PattayaTool isNull:ret[@"code"]]) {
             
         if (![ret[@"code"] isEqualToString:@"CALL_ORDER_NOT_FOUND"]) {
             [self showToast:ret[@"message"]];
         }
         }
     }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)orderUpdate
{
    [self processingOrderHttp];
}
- (void)processingOrderHttp
{
    [[PattayaUserServer singleton] getProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            OrderDefModel * mode = [[OrderDefModel alloc]initWithDictionary:ret[@"data"] error:nil];
            _model = mode;
            [self orderResfDefiale:mode.id];
           
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
