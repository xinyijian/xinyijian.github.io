//
//  AMapAddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/10/31.
//  Copyright © 2018 明克. All rights reserved.
//

#import "AMapAddressViewController.h"
#import "AMapAddressCell.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <IQUIView+IQKeyboardToolbar.h>

#define POI_TYPE_REGEO 0
#define POI_TYPE_SEARCH 1
@interface AMapAddressViewController ()<UITextFieldDelegate,MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel * cityLabel;
@property (nonatomic, strong) UITextField * searchText;
@property (nonatomic, strong)  MAMapView *mapView;
@property (strong,nonatomic) NSMutableArray* searchSources;
@property (strong,nonatomic) NSMutableArray* ChangedSources;

@property (nonatomic, strong) UIButton * locationBT;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign)  CLLocationCoordinate2D userCenter;
@property (nonatomic, strong) UIImageView * userIconCenter;
@property (nonatomic, strong) UIView * backgrouView;
@property (nonatomic, strong) UITableView * searchTab;
@property (assign, nonatomic) BOOL isChanged;

@property (nonatomic, strong) NSString * adcode;


@property int poiType;

@end

@implementation AMapAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择收货地址";
    [self setupUI];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [super setupUI];
    self.isChanged = NO;
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView activateConstraints:^{
        topView.height_attr.constant = IPhone_7_Scale_Height(43);
        [topView.width_attr equalTo:self.view.width_attr];
        [topView.top_attr equalTo:self.view.top_attr constant:0];
        topView.centerX_attr = self.view.centerX_attr;
    }];
    
    _cityLabel = [[UILabel alloc]init];
    _cityLabel.textColor = TextColor;
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.font = [UIFont systemFontOfSize:16];
    _cityLabel.text = [PattAmapLocationManager singleton].city;
    [topView addSubview:_cityLabel];
    [_cityLabel activateConstraints:^{
        [_cityLabel.height_attr equalTo:topView.height_attr];
        _cityLabel.width_attr.constant = IPhone_7_Scale_Width(62);
        [_cityLabel.top_attr equalTo:topView.top_attr];
    }];
    
    _searchText = [[UITextField alloc] init];
    _searchText.delegate = self;
    UIView * leftView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 28)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(9, 7, 14, 14)];
    imageView.image=[UIImage imageNamed:@"search"];
    [leftView addSubview:imageView];
    _searchText.leftView = leftView;
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    _searchText.placeholder = @"请输入你的收货地址";
    _searchText.font = [UIFont systemFontOfSize:14];
    _searchText.layer.cornerRadius = 4.0f;
    [topView addSubview:_searchText];
    _searchText.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [_searchText activateConstraints:^{
        [_searchText.centerY_attr equalTo:topView.centerY_attr];
        [_searchText.left_attr equalTo:topView.left_attr constant:IPhone_7_Scale_Width(62)];
        [_searchText.right_attr equalTo:topView.right_attr constant:IPhone_7_Scale_Width(-12)];
        _searchText.height_attr.constant = IPhone_7_Scale_Width(28);

    }];
    [_searchText addTarget:self action:@selector(textSearch:) forControlEvents:UIControlEventEditingChanged];

    
   
    
    
    self.mapView = [[MAMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView activateConstraints:^{
        [self.mapView.top_attr equalTo:topView.bottom_attr];
        [self.mapView.width_attr equalTo:self.view.width_attr];
        self.mapView.height_attr.constant = IPhone_7_Scale_Height(270);
    }];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MAMapTypeStandard];
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [self locationSucceed];

    
    _locationBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_locationBT];
    [_locationBT addTarget:self action:@selector(locationBT:) forControlEvents:UIControlEventTouchUpInside];
    [_locationBT setBackgroundImage:[UIImage imageNamed:@"btn_focus"] forState:UIControlStateNormal];
    [_locationBT setBackgroundImage:[UIImage imageNamed:@"btn_focus"] forState:UIControlStateHighlighted];
    [_locationBT activateConstraints:^{
        [_locationBT.top_attr equalTo:self.view.top_attr constant:IPhone_7_Scale_Height(260)];
        [_locationBT.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-12)];
        _locationBT.height_attr.constant = 48;
        _locationBT.height_attr.constant = 48;
        
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];

    _userIconCenter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location-1"]];
    [self.mapView addSubview:_userIconCenter];
    [_userIconCenter activateConstraints:^{
        [_userIconCenter.centerX_attr equalTo:self.mapView.centerX_attr constant:2];
        [_userIconCenter.centerY_attr equalTo:self.mapView.centerY_attr constant:-12];
    }];
  
    self.tableView.frame = CGRectMake(0, IPhone_7_Scale_Height(315), SCREEN_Width, SCREEN_Height - IPhone_7_Scale_Height(315) - TopBarHeight);
    
    
    _backgrouView = [[UIView alloc] init];
    [self.view addSubview:_backgrouView];
    [_backgrouView activateConstraints:^{
        [_backgrouView.top_attr equalTo:topView.bottom_attr];
        [_backgrouView.width_attr equalTo:self.view.width_attr];
        [_backgrouView.bottom_attr equalTo:self.view.bottom_attr];
    }];
    _backgrouView.alpha = 0;
    _backgrouView.backgroundColor = TextGrayColor;
    
    [_searchText addDoneOnKeyboardWithTarget:self action:@selector(startSearch)];
    
    
    [self.view addSubview:self.searchTab];

    [_searchTab activateConstraints:^{
        [_searchTab.top_attr equalTo:topView.bottom_attr];
        [_searchTab.width_attr equalTo:self.view.width_attr];
        [_searchTab.bottom_attr equalTo:self.view.bottom_attr];
    }];
    _searchTab.alpha = 0;
}


- (UITableView *)searchTab{
    if (_searchTab == nil) {
        _searchTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0) style:self.tableStyle];
        _searchTab.delegate = self;
        _searchTab.dataSource = self;
        _searchTab.rowHeight = IPhone_7_Scale_Width(48);
        _searchTab.showsVerticalScrollIndicator = NO;
        _searchTab.showsHorizontalScrollIndicator = NO;
        _searchTab.backgroundColor = App_TotalGrayWhite;
        _searchTab.separatorInset = UIEdgeInsetsZero;
        _searchTab.tableFooterView = [UIView new];
        // 防止上拉加载更多，位置发生偏移
        _searchTab.estimatedRowHeight = 0;
        _searchTab.estimatedSectionHeaderHeight = 0;
        _searchTab.estimatedSectionFooterHeight = 0;
        [_searchTab setSeparatorColor:App_TableSeparator];
    }
    return _searchTab;

}




- (void)actionPan:(UIPanGestureRecognizer *)pan
{
    //    if (self.isChanged == NO) {
    //        self.isChanged = YES;
    //    }
//    self.isPan = YES;
//    [self._locationBT setBackgroundImage:[UIImage imageNamed:@"定位-默认"] forState:UIControlStateNormal];
}

-(void)locationSucceed{
    if([PattAmapLocationManager singleton].lat.integerValue > 0){
        CLLocationCoordinate2D center;
        center.longitude = [PattAmapLocationManager singleton].lng.doubleValue;
        center.latitude = [PattAmapLocationManager singleton].lat.doubleValue;
        _userCenter = center;
        [self.mapView setCenterCoordinate:center animated:YES];
        [self.mapView setZoomLevel:16.5];


    }
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D center = mapView.centerCoordinate;
//    [self.mapView setCenterCoordinate:center animated:YES];
    AMapReGeocodeSearchRequest* request = [[AMapReGeocodeSearchRequest alloc]init];
    request.location = [AMapGeoPoint locationWithLatitude: center.latitude longitude:center.longitude];
    request.requireExtension = YES;
    [self.search AMapReGoecodeSearch:request];
}

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    if(response.regeocode != nil){
        NSString *result = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent];
        NSLog(@"逆地理编码结果:%@",result);
//        self.centerAddressComponent = response.regeocode.addressComponent;
        self.adcode = response.regeocode.addressComponent.adcode;
        self.searchSources  = [response.regeocode.pois mutableCopy];
        self.poiType = POI_TYPE_REGEO;
        if (self.searchSources.count > 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }
}


/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    if (response.pois.count == 0)
    {
        self.isChanged = NO;
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithArray:response.pois];
    self.poiType = POI_TYPE_SEARCH;
    self.ChangedSources = [poiAnnotations mutableCopy]; ;
//
//    self.mapView.delegate = nil;
//    AMapPOI* firstPOI = response.pois[0];
//    CLLocationCoordinate2D center;
//    center.longitude = firstPOI.location.longitude;
//    center.latitude = firstPOI.location.latitude;
//    [self.mapView setCenterCoordinate:center];
//    self.mapView.delegate = self;
    self.isChanged = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.searchTab.alpha = 1;
    }];
    [self.searchTab reloadData];
}


#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isChanged) return self.ChangedSources.count;
    return self.searchSources.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return IgnoreHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isChanged) {
        AMapAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AMapAddressCell"];
        if (!cell) {
            cell = [[AMapAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AMapAddressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        AMapPOI* dic = [self.ChangedSources objectAtIndex:indexPath.row];
        cell.poi = dic;
        return cell;
    } else{
        AMapAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AMapAddressCell"];
        if (!cell) {
            cell = [[AMapAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AMapAddressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        AMapPOI* dic = [self.searchSources objectAtIndex:indexPath.row];
        cell.poi = dic;
        return cell;
    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI* dic = [self.searchSources objectAtIndex:indexPath.row];

    BLOCK_EXEC(_addressBlock,dic,self.adcode);
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)locationBT:(UIButton *)btn{
    [self.mapView setCenterCoordinate:_userCenter];
}
- (void)textSearch:(UITextField *)tf{
    NSLog(@"-%@-",tf.text);
    [UIView animateWithDuration:0.5 animations:^{
        _backgrouView.alpha = 0.5;
    }];
    
    if ([PattayaTool isNull:tf.text]) {
        [UIView animateWithDuration:0.5 animations:^{
            _searchTab.alpha = 0;
            _isChanged = NO;
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backgrouView.alpha = 0.5;
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([PattayaTool isNull:textField.text]) {
        [UIView animateWithDuration:0.5 animations:^{
            _backgrouView.alpha = 0;
        }];
    } else{
        [UIView animateWithDuration:0.5 animations:^{
            _backgrouView.alpha = 0.5;
        }];
        
        [self searchText:textField.text];
        
    }
    return YES;
}

- (void)startSearch{
    [_searchText resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        _backgrouView.alpha = 0;
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backgrouView.alpha = 0.5;
    }];
    
    return YES;
}

- (void)searchText:(NSString *)text{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = text;
    request.city                = [PattAmapLocationManager singleton].city;
    request.requireExtension    = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

@end
