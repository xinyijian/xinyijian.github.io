//
//  CallStoreVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/11/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "CallStoreVC.h"
#import "PaymentBottomView.h"
#import "PaymentActionSheetView.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>

@interface CallStoreVC ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) UIImageView *headImage;//商店头像
@property (nonatomic, strong) UILabel *nameLabel;//商店名称
@property (nonatomic, strong) UILabel *chainLabel;//连锁
@property (nonatomic, strong) UILabel *hotLabel;//热力值
@property (nonatomic, strong) UIImageView *hotImg;//热力值
@property (nonatomic, strong) UILabel *licenseTag;//车牌号
@property (nonatomic, strong) UILabel *serviceCharge;//服务费
@property (nonatomic, strong) UIImageView *locationImg;//定位图标
@property (nonatomic, strong) UILabel *locationLabel;//定位文字
@property (nonatomic, strong) UILabel *cutLine;//分割线
@property (nonatomic, strong) UILabel *cutLine2;//分割线


@property (nonatomic, strong) UIView *pushView;//可以跳转的view
@property (nonatomic, strong) UILabel *destinationLabel;//目的地
@property (nonatomic, strong) UILabel *numberLabel;//电话
@property (nonatomic, strong) UILabel *timeLabel;//电话

@property (nonatomic, strong) PaymentBottomView *bottomView;//底部视图
@property (nonatomic, strong) PaymentActionSheetView *paymentActionSheetView;//收缩视图
@property (nonatomic, strong)  MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapPOI * addressLocation;
@property (nonatomic, strong) NSString * Component;

@end

@implementation CallStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
   // [self netRequestData];
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (void)addMapviewUI:(UIView *)topView{
    self.mapView = [[MAMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView activateConstraints:^{
        [self.mapView.top_attr equalTo:topView.bottom_attr];
        [self.mapView.width_attr equalTo:self.view.width_attr];
        [self.mapView.bottom_attr equalTo:self.bottomView.top_attr];
    }];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MAMapTypeStandard];
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.scrollEnabled = NO;
    self.mapView.rotateEnabled = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [self locationSucceed];
    
}
-(void)locationSucceed{
    if([PattAmapLocationManager singleton].lat.integerValue > 0){
        CLLocationCoordinate2D center;
        center.longitude = [PattAmapLocationManager singleton].lng.doubleValue;
        center.latitude = [PattAmapLocationManager singleton].lat.doubleValue;
//        _userCenter = center;
        [self.mapView setCenterCoordinate:center animated:YES];
        [self.mapView setZoomLevel:16.5];
        AMapReGeocodeSearchRequest* request = [[AMapReGeocodeSearchRequest alloc]init];
        request.location = [AMapGeoPoint locationWithLatitude: center.latitude longitude:center.longitude];
        request.requireExtension = YES;
        [self.search AMapReGoecodeSearch:request];
        
    }
}

-(void)netRequestData{
//    for (ProductModel *model in _shopModel.goodsList) {
//        if ([model.selectCount intValue]>0) {
//            [self.dataArray addObject:model];
//        }
  //  }
}

-(void)setupUI{
    [super setupUI];
    
    //顶部视图
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, IPhone_7_Scale_Height(10), SCREEN_Width,IPhone_7_Scale_Height(235))];
    headerView.backgroundColor = UIColorWhite;
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    [headerView addSubview:self.headImage];
    [headerView addSubview:self.nameLabel];
    [headerView addSubview:self.chainLabel];
    [headerView addSubview:self.hotLabel];
    [headerView addSubview:self.hotImg];
    [headerView addSubview:self.licenseTag];
    [headerView addSubview:self.serviceCharge];
    [headerView addSubview:self.locationImg];
    [headerView addSubview:self.locationLabel];
    [headerView addSubview:self.cutLine];
    
    [headerView addSubview:self.pushView];
    [self.pushView addSubview:self.destinationLabel];
    [self.pushView addSubview:self.numberLabel];
    [headerView addSubview:self.cutLine2];
    [headerView addSubview:self.timeLabel];
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.paymentActionSheetView];
    [self addMapviewUI:headerView];

    

}

#pragma mark - 懒加载
- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(18), IPhone_7_Scale_Height(10), IPhone_7_Scale_Height(60), IPhone_7_Scale_Height(60))];
        [_headImage sd_setImageWithURL:[NSURL URLWithString:_shopModel.avatarURL] placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
    }
    return _headImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(12), IPhone_7_Scale_Height(22), 0, IPhone_7_Scale_Height(22))];
        _nameLabel.textColor = TextColor;
        _nameLabel.font = K_LABEL_SMALL_FONT_16;
        _nameLabel.text = _shopModel.name;
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)chainLabel {
    if (!_chainLabel) {
        _chainLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.YD_right+IPhone_7_Scale_Width(8),IPhone_7_Scale_Height(21), IPhone_7_Scale_Height(42), IPhone_7_Scale_Height(24))];
        _chainLabel.font = K_LABEL_SMALL_FONT_14;
        _chainLabel.text = @"连锁";
        _chainLabel.textAlignment = NSTextAlignmentCenter;
        _chainLabel.textColor = UIColorWhite;
        _chainLabel.backgroundColor = UIColorFromRGB(0x328CE2);
        _chainLabel.layer.cornerRadius = 3;
        _chainLabel.layer.masksToBounds = true;
    }
    return _chainLabel;
}

- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(12),self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(9),0 , IPhone_7_Scale_Height(17))];
        _hotLabel.textColor = TextGrayColor;
        _hotLabel.font = K_LABEL_SMALL_FONT_12;
        _hotLabel.text = @"热力值";
        [_hotLabel sizeToFit];
        
    }
    return _hotLabel;
}

- (UIImageView *)hotImg {
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.hotLabel.YD_right + 5 , self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(12), IPhone_7_Scale_Width(36), IPhone_7_Scale_Height(11))];
        _hotImg.image = [UIImage imageNamed:@"main_cell_hotstar2"];
        
    }
    return _hotImg;
}

- (UILabel *)licenseTag {
    if (!_licenseTag) {
        _licenseTag = [[UILabel alloc]initWithFrame:CGRectMake(self.hotImg.YD_right + IPhone_7_Scale_Width(10) ,self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(9), 0, IPhone_7_Scale_Height(17))];
        _licenseTag.textColor = TextGrayColor;
        _licenseTag.font = K_LABEL_SMALL_FONT_12;
        _licenseTag.text = _shopModel.deviceNo;
        [_licenseTag sizeToFit];
    }
    return _licenseTag;
}

- (UILabel *)serviceCharge {
    if (!_serviceCharge) {
        _serviceCharge = [[UILabel alloc]initWithFrame:CGRectMake(self.licenseTag.YD_right + IPhone_7_Scale_Width(10) ,self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(9), 0, IPhone_7_Scale_Height(17))];
        _serviceCharge.textColor = TextGrayColor;
        _serviceCharge.font = K_LABEL_SMALL_FONT_12;
        _serviceCharge.text = @"打店服务费9元";
        [_serviceCharge sizeToFit];
    }
    return _serviceCharge;
}

- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(25),self.headImage.YD_bottom + IPhone_7_Scale_Height(10), IPhone_7_Scale_Height(9), IPhone_7_Scale_Height(11))];
        _locationImg.image = [UIImage imageNamed:@"location"];
    }
    return _locationImg;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.locationImg.YD_right + IPhone_7_Scale_Width(12) ,self.headImage.YD_bottom+ IPhone_7_Scale_Height(6), 0, IPhone_7_Scale_Height(20))];
        _locationLabel.textColor = TextColor;
        _locationLabel.font = K_LABEL_SMALL_FONT_14;
        _locationLabel.text = [_shopModel.storeAddress isEqualToString:@""] ? @"定位失败" : _shopModel.storeAddress;
        [_locationLabel sizeToFit];
    }
    return _locationLabel;
}


- (UILabel *)cutLine {
    if (!_cutLine) {
        _cutLine = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.locationLabel.YD_bottom+ IPhone_7_Scale_Height(12), SCREEN_Width, 1)];
        _cutLine.backgroundColor = LineColor;
    }
    return _cutLine;
}

-(UIView *)pushView {
    if (!_pushView) {
        _pushView = [[UIView alloc]initWithFrame:CGRectMake(0 ,self.cutLine.YD_bottom, SCREEN_Width, IPhone_7_Scale_Height(76))];
    }
    return _pushView;
}

- (UILabel *)destinationLabel {
    if (!_destinationLabel) {
        _destinationLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(25) ,IPhone_7_Scale_Height(17), 0, IPhone_7_Scale_Height(20))];
        _destinationLabel.text = @"目的地：长宁区1488弄99号113房";
        _destinationLabel.font = [UIFont boldSystemFontOfSize:14];
        _destinationLabel.textColor = TextColor;
        [_destinationLabel sizeToFit];
       
    }
    return _destinationLabel;
}


- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(25) ,self.destinationLabel.YD_bottom+ IPhone_7_Scale_Height(12), 0, IPhone_7_Scale_Height(20))];
        _numberLabel.text = @"杨先生 15098767890";
        _numberLabel.font = K_LABEL_SMALL_FONT_14;
        _numberLabel.textColor = TextColor;
        [_numberLabel sizeToFit];
    }
    return _numberLabel;
}


- (UILabel *)cutLine2 {
    if (!_cutLine2) {
        _cutLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.pushView.YD_bottom+ IPhone_7_Scale_Height(12), SCREEN_Width, 1)];
        _cutLine2.backgroundColor = LineColor;
    }
    return _cutLine2;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.cutLine2.YD_bottom+ IPhone_7_Scale_Height(12), SCREEN_Width, IPhone_7_Scale_Height(22))];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = TextColor;
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"大约 16: 00 到达"];
        [aString addAttribute:NSForegroundColorAttributeName value:App_Nav_BarDefalutColor range:NSMakeRange(3,6)];
        _timeLabel.attributedText = aString;
        _timeLabel.font = K_LABEL_SMALL_FONT_16;
    }
    return _timeLabel;
}


#pragma mark - bottomView
- (PaymentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[PaymentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_Height - BottomH - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT, SCREEN_Width, BottomH + SafeAreaBottomHeight)];
        _bottomView.discountLabel.text = @"已优惠￥9.00";
        _bottomView.totalAmountLabel.text = @"￥0.00";
        [_bottomView.paymentBT addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

#pragma mark - 去支付
-(void)paymentClick:(UIButton*)btn{
    
    //[_paymentActionSheetView showView];
    WEAK_SELF;
  NSDictionary *  dic = @{@"userCallFormattedAddress":@"杨磊的地址",@"userCallLatitude":@"31.21432",@"userCallLongitude":@"121.3852",@"vehicleId":_shopModel.dbStoreId,@"userMobile":@"17621224265",@"userName":@"杨磊",@"orderType":@"NORMAL"};
    [[PattayaUserServer singleton] callOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        if ([ResponseModel isData:ret ]) {
            [YDProgressHUD showMessage:@"下单成功，等待接单"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadOrderList" object:nil];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
             [YDProgressHUD showMessage:@"下单失败，请重试"];
        }
       
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [YDProgressHUD showMessage:@"下单失败，请重试"];
    }];
    
    
}

#pragma mark - 收缩视图
- (PaymentActionSheetView *)paymentActionSheetView
{
    if (!_paymentActionSheetView) {
        _paymentActionSheetView = [[PaymentActionSheetView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT)];
        
        //_paymentActionSheetView.payBusinessCode = _payBusinessCode;
        _paymentActionSheetView.hidden = YES;
        // [_paymentActionSheetView.paymentBT addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paymentActionSheetView;
}



-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    if(response.regeocode != nil){
        NSString *result = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent];
        NSLog(@"逆地理编码结果:%@",result);
        self.addressLocation = [response.regeocode.pois firstObject];
        _Component = response.regeocode.formattedAddress;
        _destinationLabel.text = _Component;
//                self.centerAddressComponent = response.regeocode.addressComponent;
//        self.searchSources  = [response.regeocode.pois mutableCopy];
//        self.poiType = POI_TYPE_REGEO;
//        if (self.searchSources.count > 0) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        }
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
  if ([annotation isKindOfClass:[MAUserLocation class]])
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
        annotationView.image = [UIImage imageNamed:@"icon_location"];
        return annotationView;
        
    }
//    else if ([annotation isKindOfClass:[DD_MAPointUserLocationView class]])
//    {
//        static NSString *customReuseIndetifier = @"DD_customReuseIndetifierConfirmation";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
//            // must set to NO, so we can show the custom callout view.
//            //            annotationView.canShowCallout = NO;
//            //            annotationView.draggable = YES;
//            //            annotationView.calloutOffset = CGPointMake(0, -5);
//        }
//        annotationView.image = [UIImage imageNamed:@"icon--"];
//        return annotationView;
//    }
    return nil;
}

@end
