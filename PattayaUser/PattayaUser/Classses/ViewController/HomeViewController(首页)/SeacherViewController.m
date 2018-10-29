//
//  SeacherViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "SeacherViewController.h"
#import "headLocationView.h"
#import "DD_SeachbarView.h"
#import "newsreelView.h"
#import "HomeTableViewCell.h"
#import "StoreListModel.h"
#import "ConditionQueryView.h"
#import "CarDetailsViewController.h"
#import "HotModel.h"
#import "ListCityNameViewController.h"
#import "NSMutableDictionary+SetModelRequest.h"
@interface SeacherViewController ()<UINavigationControllerDelegate,DD_SeachbarViewDelegate,UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>
{
    DD_SeachbarView * seachBar;
}
@property (nonatomic, strong) newsreelView * sreelView;
@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) NSMutableArray * arrayText;
@property (strong, nonatomic) UIView * hotViewBlack;
@property (strong, nonatomic) UIButton * tmpBtn;
@property (nonatomic, strong) UIView * lineBottom;
@property (nonatomic, assign) NSInteger  pageSize;
@property (nonatomic, strong) NSMutableArray  * hotArray;
@property (nonatomic, assign) NSInteger  orderBytag;
@property (nonatomic, strong) UILabel * signalLaber;
@property (nonatomic, assign) NSInteger  orderBy;
@property (nonatomic, strong) NSMutableArray  * StoreAr;

@end

@implementation SeacherViewController

- (void)addlistTabelview
{
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = _sreelView.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
    self.tableview.hidden = YES;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _StoreAr = [NSMutableArray array];
    _orderBytag = 0;
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    _pageSize = 0;
    seachBar = [[DD_SeachbarView alloc]init];
    seachBar.DD_delegate = self;
    [seachBar initUI];
    [self.view addSubview:seachBar];
    seachBar.backgroundColor = BlueColor;
    [seachBar becomeFirstResponder];
    [seachBar activateConstraints:^{
        seachBar.height_attr.constant = 44 + statHeight;
        [seachBar.top_attr equalTo:self.view.top_attr constant:0];
        seachBar.width_attr = self.view.width_attr;
    }];
    if (![PattayaTool isNull:_seacherText] && ![PattayaTool isNull:_categoryId]) {
        seachBar.seachView.text = _seacherText;
        [self SeachStoreCodeRequestHTTP:_orderBytag text:_seacherText categoryId:_categoryId];
    } else
    {
        if (![PattayaTool isNull:_seacherText]) {
            seachBar.seachView.text = _seacherText;
            [self SeachStoreCodeRequestHTTP:_orderBytag text:_seacherText categoryId:nil];
        }
        if (![PattayaTool isNull:_categoryId]) {
            [self SeachStoreCodeRequestHTTP:_orderBytag text:nil categoryId:_categoryId];
        }
    }
    
    
    _sreelView = [[newsreelView alloc]init];
    _sreelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_sreelView];
    
    [_sreelView activateConstraints:^{
        [_sreelView.top_attr equalTo:seachBar.bottom_attr constant:0];
        _sreelView.width_attr = seachBar.width_attr;
        [_sreelView.bottom_attr equalTo:self.view.bottom_attr constant:0];
    }];
    [self addlistTabelview];
    [self nearCarInit];
    [PattAmapLocationManager singleton].isLocation = NO;
    [PattAmapLocationManager singleton].locationBlock = ^(CLLocation *location,NSString * address) {
        
        seachBar.cityName = [PattAmapLocationManager singleton].presentLocation.city;
        if ([PattAmapLocationManager singleton].presentLocation.city.length > 3) {
            seachBar.cityName = [NSString stringWithFormat:@"%@..",[[PattAmapLocationManager singleton].presentLocation.city substringWithRange:NSMakeRange(0, 3)]];
        }
    };
    WS(weakSelf);
    [self add_TableviewRefreshHeader:_tableview refrshBlack:^{
        weakSelf.pageSize = 0;
        weakSelf.StoreAr = [NSMutableArray array];
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer resetNoMoreData];
        weakSelf.tableview.mj_footer.alpha = 1.0f;
        
        [weakSelf SeachStoreCodeRequestHTTP:weakSelf.orderBytag text:weakSelf.seacherText categoryId: weakSelf.categoryId];
    }];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageSize++;
        [weakSelf SeachStoreCodeRequestHTTP:weakSelf.orderBytag text:weakSelf.seacherText categoryId:weakSelf.categoryId];
    }];
    [self hotHttp];
    
    _sreelView.hotBlcok = ^(NSString *text) {
        weakSelf.pageSize = 0;
        weakSelf.StoreAr = [NSMutableArray array];
        weakSelf.seacherText = text;
        seachBar.seachView.text = weakSelf.seacherText;
        [weakSelf SeachStoreCodeRequestHTTP:_orderBytag text:_seacherText categoryId:weakSelf.categoryId];
        
    };
    
    
    _signalLaber = [[UILabel alloc] init];
    _signalLaber.frame = CGRectMake(0, 80, SCREEN_Width, 30);
    [self.tableview addSubview:_signalLaber];
    _signalLaber.textColor = TextGrayColor;
    _signalLaber.textAlignment = NSTextAlignmentCenter;
    _signalLaber.text = NSLocalizedString(@"附近暂时没有可服务车辆",nil);
    _signalLaber.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [seachBar.seachView becomeFirstResponder];
    
}
- (void)nearCarInit{
    
    WS(weakSelf);
    ConditionQueryView * hotview = [[ConditionQueryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40)];
    hotview.clickBlock = ^(NSInteger tag) {
        [weakSelf.StoreAr removeAllObjects];
        weakSelf.StoreAr = [NSMutableArray array];
        [weakSelf.tableview reloadData];
        
        [weakSelf SeachStoreCodeRequestHTTP:tag text:[PattayaTool isNull:weakSelf.seacherText] ? @"" : weakSelf.seacherText categoryId:[PattayaTool isNull:_categoryId] ? @"" : _categoryId];
    };
    self.tableview.tableHeaderView = hotview;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _StoreAr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113.5f;
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
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sechViewCell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sechViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.Model = _StoreAr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreDefileModel * mode = _StoreAr[indexPath.row];
    CarDetailsViewController * vc = [[CarDetailsViewController alloc]init];
    vc.model = mode;
    vc.storeId = mode.dbStoreId.stringValue;
    NSDictionary * rest = [ GetAppDelegate.locationAddress toDictionary];
    vc.carDetailModel = [[AddressModel alloc] initWithDictionary:rest error:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changText:(NSString *)string
{
    _pageSize = 0;
    _seacherText = string;
    _StoreAr = [NSMutableArray array];
    NSLog(@"%@",string);
    self.tableview.hidden = NO;
    [self SeachStoreCodeRequestHTTP:_orderBytag text:string categoryId:_categoryId];
}
- (void)closeText
{
    self.tableview.hidden = YES;
}
- (void)locationClinkeCityName:(NSString *)st
{
    ListCityNameViewController * vcs = [[ListCityNameViewController alloc]init];
    vcs.cityBlock = ^(NSString *cityName) {
        seachBar.cityName = cityName;
    };
    [self.navigationController pushViewController:vcs animated:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ActionConditionQueryBtn:(NSInteger)tag
{
    _pageSize = 0;
    _orderBytag = tag;
    _StoreAr = [NSMutableArray array];
    [self SeachStoreCodeRequestHTTP:tag text:_seacherText categoryId:_categoryId];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)SeachStoreCodeRequestHTTP:(NSInteger )tpy text:(NSString *)seacher categoryId:(NSString *)categpryId
{
    NSMutableDictionary * dicSave = [NSMutableDictionary SeachStoreCodeRequest:_pageSize categpry:categpryId seacherText:seacher type:tpy];
    [[PattayaUserServer singleton] SeachStoreCodeRequest:dicSave success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"RET = %@",ret);
        if ([ResponseModel isData:ret]) {
            _tableview.hidden = NO;
            StoreListModel * list = [[StoreListModel alloc] initWithDictionary:ret[@"data"] error:nil];
            if (_pageSize >= list.totalPages.integerValue) {
                if (_StoreAr.count > 0) {
                    _signalLaber.hidden = YES;
                } else
                {
                    _signalLaber.hidden = NO;
                }
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
                [self.tableview.mj_header endRefreshing];
                self .tableview.mj_footer.alpha = 0.0f;
                NSLog(@"没用更多");
                [_tableview reloadData];
                return;
            }
            [_StoreAr addObjectsFromArray:list.content];
            if (_StoreAr.count > 0) {
                _signalLaber.hidden = YES;
            } else
            {
                _signalLaber.hidden = NO;
            }
        } else
        {
            [self showToast:ret[@"message"]];
        }
        [_tableview reloadData];
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];
}
- (void)hotHttp
{
    [[PattayaUserServer singleton] HotRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        _hotArray = [NSMutableArray array];
        if ([ResponseModel isData:ret]) {
            HotListModel * mode = [[HotListModel alloc] initWithDictionary:ret error:nil];
            if (mode.data.count >=15) {
                [_hotArray addObjectsFromArray: [mode.data subarrayWithRange:NSMakeRange(0, 15)]];
            } else
            {
                [_hotArray addObjectsFromArray:mode.data];
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (int i = 0; i < _hotArray.count; i++) {
                HotModel * mode = _hotArray[i];
                [arr addObject:mode.key];
            }
            _sreelView.arrayHotText = arr;
        } else
        {
            [self showToast:ret[@"message"]];
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
