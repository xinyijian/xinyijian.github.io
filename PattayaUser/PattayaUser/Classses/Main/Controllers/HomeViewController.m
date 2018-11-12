//
//  HomeViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "HomeViewController.h"
#import "XLCardSwitch.h"
#import "XLCardItem.h"
#import "ShopMainVC.h"
#import "SearchVC.h"
#import "ScanVC.h"
//#import "HomeViewHead.h"
//#import "HomeTableViewCell.h"
#import "SeacherViewController.h"
//#import "OrderViewController.h"
//#import "LocationViewController.h"
//#import "DD_Alertview.h"
//#import "CarDetailsViewController.h"
//#import "StoreListModel.h"
//#import "storeCategoryModel.h"
//#import "ConfirmationOrderViewController.h"
//#import "OrderDefModel.h"
//#import "bannerModel.h"
//#import "HotModel.h"
//#import "UpdateObject.h"
//#import "ProtocolKit.h"
//#import "NSMutableDictionary+SetModelRequest.h"
#import "PattAmapLocationManager.h"
#import "YDCycleScrollView.h"
#import "EmptyView.h"

@interface HomeViewController ()  <UIScrollViewDelegate,XLCardSwitchDelegate>

//<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,HomeViewHeadDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YDCycleScrollView *cycleSV;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIView *navgationBarView;
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIView *advView;
@property (nonatomic, strong) UIButton *advButton4;
@property (nonatomic, strong) UILabel *nearShopLabel;
@property (nonatomic, strong) XLCardSwitch *cardSwitch;

@property (nonatomic,strong) EmptyView *emptyView;//无数据视图

@property (nonatomic,strong) MainModel * mainModel;


@end

@implementation HomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    self.progressType = YDProgressTypeBezel;
    [self setupUI];
    [self netRequestData];
}


#pragma mark - 初始化UI
- (void)setupUI{
    
    [super setupUI];
    
    [self.view addSubview:self.scrollView];
   
    [self.scrollView addSubview:self.cycleSV];
    [self.view addSubview:self.effectView];
    [self.view addSubview:self.navgationBarView];
    
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.scanBtn];
    [self.scrollView addSubview:self.locationImg];
    [self.scrollView addSubview:self.locationLabel];
    
    [self.scrollView addSubview:self.advView];
    //中间三个广告图
    float width = (SCREEN_Width - IPhone_7_Scale_Width(12)*2 - IPhone_7_Scale_Width(6)*2)/3;
    float height = width/113*74;
    
//    for (int i = 0 ; i < 3; i++) {
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(12)+(width+IPhone_7_Scale_Width(6))*i, 16, width, height)];
//        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"main_adv_%d",i+1]] forState:UIControlStateNormal];
//        [self.advView addSubview:btn];
//    }
    
    [self.scrollView addSubview:self.advButton4];
    
    [self.scrollView addSubview: self.nearShopLabel];
    
    [self.scrollView addSubview:self.emptyView];
    
    
    [self.scrollView addSubview:self.cardSwitch];
   
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,_cardSwitch.YD_bottom+ IPhone_7_Scale_Height(40));

    [YDRefresh yd_headerRefresh:_scrollView headerBlock:^{
        NSLog(@"刷新");
        [self netRequestData];
        [YDRefresh yd_endHeaderRefresh:_scrollView];
        
    }];
    
  
//
//    [self setupRequest];
}

-(void)netRequestData{
    
    WS(weakSelf);
    [PattAmapLocationManager singleton].locationBlock = ^(CLLocation *location, NSString *address) {
        weakSelf.locationLabel.text = address;
        //[weakSelf netRequestData];
        
    };
    
   
    [[PattayaUserServer singleton]  SeachStoreCodeRequest:nil success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        
       _mainModel = [[MainModel alloc]initWithDictionary:ret[@"data"] error:nil];
        _cardSwitch.items = _mainModel.content;

        if (_mainModel.content.count > 0) {
            _advButton4.hidden = NO;
            _nearShopLabel.hidden = NO;
            _emptyView.hidden = YES;
            _scrollView.contentSize = CGSizeMake(SCREEN_Width,_cardSwitch.YD_bottom+ IPhone_7_Scale_Height(40));
        } else
        {
            _emptyView.hidden = NO;
            _advButton4.hidden = YES;
            _nearShopLabel.hidden = YES;
            _scrollView.contentSize = self.view.bounds.size;
        }
       
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
          [self handleNetReslut:YDNetResultFaiure];
    }];

}


#pragma mark - 设置监听
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.cycleSV.cycleScrollView adjustWhenControllerViewWillAppera];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"===%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > self.cycleSV.height-TopBarHeight) {
        self.effectView.hidden = YES;
        self.navgationBarView.hidden = NO;
    }else{
         self.effectView.hidden = NO;
         self.navgationBarView.hidden = YES;
    }
}


#pragma mark - 懒加载

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TabBarHeight)];
       // _scrollView.contentSize = CGSizeMake(SCREEN_Width, IPhone_7_Scale_Height(1080+StatusBarHeight));
        _scrollView.backgroundColor = App_TotalGrayWhite;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _scrollView;
}

- (YDCycleScrollView *)cycleSV {
    if (!_cycleSV) {
        _cycleSV = [[YDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, IPhone_7_Scale_Width(175+TopBarHeight)) placehold:@"main_adv_1"];
        _cycleSV.backgroundColor = [UIColor redColor];
        YLBannerModel *model1 = [[YLBannerModel alloc]init];
        model1.loadingUrl = @"234";
        _cycleSV.bannerArray = @[model1];
    }
    return _cycleSV;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
        _effectView.frame = CGRectMake(0, 0, SCREEN_Width, TopBarHeight);
    }
    return _effectView;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, StatusBarH + 9, SCREEN_Width- 10 - 45,(SCREEN_Width-10- 45)/320*28)];
        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"main_search"] forState:UIControlStateNormal];
        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"main_search"] forState:UIControlStateHighlighted];
        [_searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _searchBtn;
}

//搜索功能
-(void)searchClick:(UIButton*)btn{
    [self.navigationController pushViewController:[[SearchVC alloc]init] animated:NO];
}

-(UIButton *)scanBtn{
    if (!_scanBtn) {
        _scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_Width - 24 - 10, StatusBarH + 11, 24, 24)];
        [_scanBtn setBackgroundImage:[UIImage imageNamed:@"main_scan"] forState:UIControlStateNormal];
        [_scanBtn addTarget:self action:@selector(scanClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _scanBtn;
}
//扫一扫
-(void)scanClick:(UIButton*)btn{
    [self.navigationController pushViewController:[[ScanVC alloc]init] animated:YES];
}


- (UIView *)navgationBarView {
    if (!_navgationBarView) {
        _navgationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, TopBarHeight)];
        _navgationBarView.backgroundColor = UIColorWhite;
        _navgationBarView.hidden = YES;
    }
    return _navgationBarView;
}

- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(12), self.cycleSV.YD_bottom+IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(15))];
        _locationImg.image = [UIImage imageNamed:@"location"];
    }
    return _locationImg;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.locationImg.YD_right+IPhone_7_Scale_Width(6), self.locationImg.YD_top-IPhone_7_Scale_Width(3.5), 200, IPhone_7_Scale_Width(22))];
        _locationLabel.text = @"缤谷大厦";
        _locationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _locationLabel;
}

- (UIView *)advView {
    if (!_advView) {
        _advView = [[UIView alloc]initWithFrame:CGRectMake(0, self.locationLabel.YD_bottom+IPhone_7_Scale_Height(15), SCREEN_Width, 0)];//IPhone_7_Scale_Height(108)
        _advView.backgroundColor = UIColorWhite;
    }
    return _advView;
}

- (UIButton *)advButton4{
    if (!_advButton4) {
        _advButton4 = [[UIButton alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(12), self.advView.YD_bottom+IPhone_7_Scale_Height(8), SCREEN_Width-IPhone_7_Scale_Width(24), (SCREEN_Width-IPhone_7_Scale_Width(24))/350*80)];
        [_advButton4 setBackgroundImage:[UIImage imageNamed:@"main_adv_4"] forState:UIControlStateNormal];
        [_advButton4 setBackgroundImage:[UIImage imageNamed:@"main_adv_4"] forState:UIControlStateHighlighted];

    }
    return _advButton4;
}



- (UILabel *)nearShopLabel {
    if (!_nearShopLabel) {
        _nearShopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.advButton4.YD_bottom+IPhone_7_Scale_Height(20), SCREEN_Width, 20)];
        _nearShopLabel.text = @"- 附近的店 -";
        _nearShopLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nearShopLabel;
}

-(EmptyView *)emptyView{
    WEAK_SELF;
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, self.locationLabel.YD_bottom, SCREEN_Width, IPhone_7_Scale_Height(150)) withImage:@"main_cell_headImg_bg" withTitle:@"当前无法定位，请点击刷新"];
        _emptyView.block = ^{
            [weakSelf netRequestData];
        };
        _emptyView.hidden = YES;
    }
    return _emptyView;
}


- (XLCardSwitch *)cardSwitch {
    if (!_cardSwitch) {
            
            //设置卡片浏览器
            _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, self.nearShopLabel.YD_bottom+20, SCREEN_Width, IPhone_7_Scale_Width(420))];
            //_cardSwitch.items = items;
            _cardSwitch.delegate = self;
            //分页切换
            _cardSwitch.pagingEnabled = false;
            //设置初始位置，默认为0
            //_cardSwitch.selectedIndex = 3;

    }
    return _cardSwitch;
}

#pragma mark - XLCardSwitchDelegate

-(void)XLCardSwitchDidSelectedAt:(NSInteger)index{
    ShopMainVC *vc = [[ShopMainVC alloc]init];
    vc.model  = _mainModel.content[index];
    [self.navigationController pushViewController:vc animated:YES];
}

@end


