//
//  ListOrderViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/3.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ListOrderViewController.h"
#import "ListOrderTableViewCell.h"
#import "OrderViewController.h"
#import "OrderListModel.h"
#import "OrderDetailVC.h"
#import "ProccesingModel.h"
#define TITLES @[@"全部订单", @"进行中",@"已取消",@"退款订单"]
@interface ListOrderViewController ()

@property (nonatomic,strong) UIView * groundView;
@property (nonatomic,strong) OrderListModel * listModel;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) UILabel *scrollLab;//可移动的底部滑竿
@property (nonatomic,strong) UIButton *currentBT;

@property (nonatomic,assign) NSInteger requestType;

@end

@implementation ListOrderViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (!_requestType) {
        _requestType = 0;
    }
    self.pageNumber = startPage;
    [self netRequestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _requestType = 0;
    [self setupUI];
    
}

-(void)setupUI{
    self.refreshMode = YDRefreshModeAll;
    [super setupUI];
    _pageSize = 1;
    self.navigationItem.title = @"我的订单";
    self.tableView.frame = CGRectMake(0, IPhone_7_Scale_Height(50), KScreenWidth, KScreenHeight - IPhone_7_Scale_Height(50) - TopBarHeight - SafeAreaBottomHeight - IPhone_7_Scale_Height(50));
    [self.tableView setSeparatorColor:App_TotalGrayWhite];
    //创建顶部菜单视图
    [self createTopMenuView];
    
   
}

-(void)setupData{
    
    [super setupData];
    
    self.refreshMode = YDRefreshModeAll;
    
}


- (void)netRequestData{
    
    if (self.pageNumber == startPage) {
        [self.dataArray removeAllObjects];
    }
    
    if (_requestType == 1) {
        [self getProcessingOrderRequest];
    }else{
        [self getConsumeOrderRequest];

    }

}

#pragma mark - 全部订单
-(void)getConsumeOrderRequest{
    
    @weakify(self);
    [[PattayaUserServer singleton] getConsumeOrderRequest:@{@"pageNum":[NSNumber numberWithInteger:_pageSize],@"pageSize":@"5",@"status":[NSNumber numberWithInteger:_requestType]} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        @strongify(self);
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            
            if (self.pageNumber == startPage) {
                [self.dataArray removeAllObjects];
            }
            _listModel = [[OrderListModel alloc] initWithDictionary:ret[@"data"] error:nil];
            for (ListOrderModel *model in _listModel.list) {
                [self.dataArray addObject:model];
            }
            
            if (self.dataArray.count > 0) {
                _groundView.hidden = YES;
            } else
            {
                _groundView.hidden = NO;
            }
            
            [YDRefresh yd_endRefreshing:self.tableView next:_listModel.list.count == pageSize];
             [self.tableView reloadData];
            
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
            [YDRefresh yd_endRefreshing:self.tableView next:_listModel.list.count == pageSize];

        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
         @strongify(self);
        
        [YDProgressHUD showMessage:@"网络异常，请重试！"];
        [YDRefresh yd_endRefreshing:self.tableView next:YES];

    }];
    
}
#pragma mark -进行中订单
- (void)getProcessingOrderRequest
{
    [[PattayaUserServer singleton] getProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"ProccesingModel = %@",ret);
        if ([ResponseModel isData:ret]){
            
            ProccesingModel * model = [[ProccesingModel alloc] initWithDictionary:ret[@"data"] error:nil];
            [self.dataArray addObject:model];
            
            if (self.dataArray.count > 0) {
                _groundView.hidden = YES;
            } else
            {
                _groundView.hidden = NO;
            }
            
        }else{
            [YDProgressHUD showMessage:ret[@"message"]];
        }
        
        [self.tableView reloadData];
        [YDRefresh yd_endRefreshing:self.tableView next:NO];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [YDRefresh yd_endRefreshing:self.tableView next:NO];
        [YDProgressHUD showMessage:@"网络异常，请重试！"];
        [self.tableView reloadData];

    }];
    
}
#pragma mark - 取消订单
- (void)getCancelOrderRequest{
    
}

#pragma mark - 退款订单
- (void)getRefundOrderRequest{
    
}

#pragma mark - 创建顶部菜单视图
//创建顶部菜单视图
- (void)createTopMenuView{
    
    CGFloat btn_width = SCREEN_Width/4;
    CGFloat btn_height = IPhone_7_Scale_Height(50);
    for (int i = 0; i < 4; i++) {
        //
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.backgroundColor = UIColorWhite;
        titleBtn.titleLabel.font = K_LABEL_SMALL_FONT_16;
        [titleBtn setTitleColor:i == 0 ? App_Nav_BarDefalutColor : UIColorFromRGB(0x5A5A5A) forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(i*btn_width, 0, btn_width, btn_height);
        [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:TITLES[i] forState:UIControlStateNormal];
        titleBtn.tag = i;
        [self.view addSubview:titleBtn];
        
        if (i==0) {
            _currentBT = titleBtn;
        }
    }
    
    
    //可移动的底部滑竿
    _scrollLab = [[UILabel alloc]init];
    _scrollLab.backgroundColor = App_Nav_BarDefalutColor;
    [self.view addSubview:_scrollLab];
    _scrollLab.frame = CGRectMake(_currentBT.YD_x + (_currentBT.YD_width - IPhone_7_Scale_Width(65))/2, _currentBT.YD_bottom, IPhone_7_Scale_Width(65), 2);

    
}

//选择
-(void)btnClick:(UIButton*)btn{
   
    [_currentBT setTitleColor: UIColorFromRGB(0x5A5A5A) forState:UIControlStateNormal];
    _currentBT = btn;
    [btn setTitleColor:App_Nav_BarDefalutColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollLab.frame = CGRectMake(btn.YD_x + (btn.YD_width - IPhone_7_Scale_Width(65))/2, btn.YD_bottom, IPhone_7_Scale_Width(65), 2);
        
    } completion:^(BOOL finished) {
        _requestType = btn.tag;
        self.pageNumber = startPage;
        [self netRequestData];
    }];
    
    
}

- (void)backgroundViewTableview
{
    
    _groundView = [[UIView alloc]init];
    [self.tableView addSubview: _groundView];
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_x_Max) {
        [_groundView activateConstraints:^{
            [_groundView.left_attr equalTo:self.tableView.left_attr];
            [_groundView.width_attr equalTo:self.tableView.width_attr];
            [_groundView.top_attr equalTo:self.tableView.top_attr_safe constant:0];
            [_groundView.bottom_attr equalTo:self.tableView.bottom_attr_safe constant:-10];
        }];
    }else{
        [_groundView activateConstraints:^{
            [_groundView.left_attr equalTo:self.tableView.left_attr];
            [_groundView.width_attr equalTo:self.tableView.width_attr];
            [_groundView.top_attr equalTo:self.tableView.top_attr_safe constant:50];
            [_groundView.bottom_attr equalTo:self.tableView.bottom_attr_safe constant:-10];
        }];
    }

    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"订单"]];
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
        //        [laber.centerX_attr equalTo:self.tableView.centerX_attr];
        
    }];
    laber.textColor = UIColorFromRGB(0x8a8fab);
    laber.text = NSLocalizedString(@"您还没有订单！",nil);
    laber.textAlignment = NSTextAlignmentCenter;
    
    self.tableView.backgroundView = _groundView;
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 184;
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
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListOrderTableViewCell"];
    if (!cell) {
        cell = [[ListOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListOrderTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_requestType==1) {
        cell.proccesingModel = self.dataArray[indexPath.row];
    }else{
        cell.model = self.dataArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
    
    if (_requestType == 1) {
        //召唤订单 无购物打店
        
         vc.proccesingModel = self.dataArray[indexPath.row];
    }else{
        vc.orderModel = self.dataArray[indexPath.row];
    }
    vc.enterType = _requestType;

    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
