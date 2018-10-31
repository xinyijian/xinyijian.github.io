//
//  AMapAddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/10/31.
//  Copyright © 2018 明克. All rights reserved.
//

#import "AMapAddressViewController.h"

@interface AMapAddressViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel * cityLabel;
@property (nonatomic, strong) UITextField * searchText;
@end

@implementation AMapAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择收货地址";
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
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
