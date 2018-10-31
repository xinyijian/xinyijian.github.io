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

#define TITLES @[@"全部订单", @"进行中",@"已取消",@"退款订单"]
@interface ListOrderViewController ()

@property (nonatomic,strong) UIView * groundView;
@property (nonatomic,strong) OrderListModel * listModel;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) UILabel *scrollLab;//可移动的底部滑竿
@property (nonatomic,strong) UIButton *currentBT;
@end

@implementation ListOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    _pageSize = 1;
    self.navigationItem.title = @"我的订单";
    self.tableView.frame = CGRectMake(0, IPhone_7_Scale_Height(50), KScreenWidth, KScreenHeight - IPhone_7_Scale_Height(50) - TopBarHeight - SafeAreaBottomHeight - IPhone_7_Scale_Height(50));
    [self.tableView setSeparatorColor:App_TotalGrayWhite];
    //创建顶部菜单视图
    [self createTopMenuView];
    [self ConsumeOrderHttp];
}
- (void)netRequestData{
    [[PattayaUserServer singleton] getProcessingOrderRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"detailListModel = %@",ret);
        detailListModel * model = [[detailListModel alloc] initWithDictionary:ret error:nil];
        NSLog(@"model = = %@",model);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
    [_scrollLab activateConstraints:^{
        [_scrollLab.top_attr equalTo:_currentBT.bottom_attr];
        _scrollLab.centerX_attr = _currentBT.centerX_attr;
        _scrollLab.width_attr.constant = IPhone_7_Scale_Width(65);
        _scrollLab.height_attr.constant = 2;
    }];
    
}

//选择
-(void)btnClick:(UIButton*)btn{
    [_currentBT setTitleColor: UIColorFromRGB(0x5A5A5A) forState:UIControlStateNormal];
    _currentBT = btn;
    [btn setTitleColor:App_Nav_BarDefalutColor forState:UIControlStateNormal];
    [self selectButton:btn.tag];
    [UIView animateWithDuration:0.3 animations:^{
        _scrollLab.frame = CGRectMake(btn.YD_x + (btn.YD_width - IPhone_7_Scale_Width(65))/2, btn.YD_bottom, IPhone_7_Scale_Width(65), 2);

//        }];
        
    }];
    
}
- (void)selectButton:(NSInteger)tags{
    if (tags == 1) {
        [self netRequestData];

    } else{
        
    }
}

- (void)ConsumeOrderHttp
{
    if (_pageSize == 1) {
        _listModel = [[OrderListModel alloc] init];
        _listModel.list = [NSMutableArray array];
    }
    [[PattayaUserServer singleton] getConsumeOrderRequest:@{@"pageNum":[NSNumber numberWithInteger:_pageSize],@"pageSize":@"5"} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            OrderListModel * model = [[OrderListModel alloc] initWithDictionary:ret[@"data"] error:nil];
            for (ListOrderModel * mode in model.list) {
                [mode imagesUrlinit];
            }
            [_listModel.list addObjectsFromArray:model.list];
            if (_listModel.list.count > 0) {
                _groundView.hidden = YES;
            } else
            {
                _groundView.hidden = NO;
            }
            if (_listModel.list.count >= model.total.integerValue) {
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                NSLog(@"没用更多");
                    return;
                    }

            
        } else
        {
           // [self showToast:ret[@"messages"]];
        }
        
       
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    return _listModel.list.count;
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
//    if (indexPath.row == 1) {
//        cell.arrayImage = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"5",@"5",@"5",@"5", nil];
//    }else
//    {
//         cell.arrayImage = [NSMutableArray array];
//    }
    if (_listModel.list.count > 0) {
        
        cell.model = _listModel.list[indexPath.row];
    }
    //    cell.textLabel.text = @"ghjk";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
    ListOrderModel * detail =_listModel.list[indexPath.row];
    if (detail.detailList.count < 0 || detail.detailList.count == 0) {
        vc.enterType = 1;
    } else{
        vc.enterType = 0;
    }
        
    
//    vc.enterType = indexPath.row;
    vc.list =_listModel.list[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
