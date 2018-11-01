//
//  AMapAddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/10/31.
//  Copyright © 2018 明克. All rights reserved.
//

#import "AMapAddressViewController.h"
#import "AMapAddressCell.h"

@interface AMapAddressViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel * cityLabel;
@property (nonatomic, strong) UITextField * searchText;

@property (nonatomic, strong) UIButton * locationBT;

@end

@implementation AMapAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择收货地址";
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [super setupUI];
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
    _cityLabel.text = @"上海";
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
    
    
    _locationBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_locationBT];
    [_locationBT addTarget:self action:@selector(locationBT) forControlEvents:UIControlEventTouchUpInside];
    [_locationBT setBackgroundImage:[UIImage imageNamed:@"btn_focus"] forState:UIControlStateNormal];
    [_locationBT setBackgroundImage:[UIImage imageNamed:@"btn_focus"] forState:UIControlStateHighlighted];
    [_locationBT activateConstraints:^{
        [_locationBT.top_attr equalTo:self.view.top_attr constant:IPhone_7_Scale_Height(260)];
        [_locationBT.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-12)];
        _locationBT.height_attr.constant = 48;
        _locationBT.height_attr.constant = 48;
        
    }];
   
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
  
    self.tableView.frame = CGRectMake(0, IPhone_7_Scale_Height(315), SCREEN_Width, SCREEN_Height - IPhone_7_Scale_Height(315) - TopBarHeight);
    
}


#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
    AMapAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AMapAddressCell"];
    if (!cell) {
        cell = [[AMapAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AMapAddressCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.model = _addresslist.data[indexPath.row];
    //[cell.editBT addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
//    AMapAddressCell * mode = _addresslist.data[indexPath.row];
//    [self editAddress:mode];
}

-(void)locationBT{
    
}

@end
