//
//  ShopMainVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ShopMainVC.h"
#import "TakeawayShopView.h"

@interface ShopMainVC ()

@end

@implementation ShopMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.name;
    [self setupUI];
    
}


-(void)setupUI{
    
    //在请求中携带店铺ID
    TakeawayShopView *shopView = [[TakeawayShopView alloc]initWithFrame:self.view.bounds withGroupID:_GroupID];
    shopView.model = _model;
    [self.view addSubview:shopView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
