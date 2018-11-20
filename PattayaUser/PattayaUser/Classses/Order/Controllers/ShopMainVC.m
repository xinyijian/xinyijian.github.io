//
//  ShopMainVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ShopMainVC.h"
#import "TakeawayShopView.h"
#import "CallStoreVC.h"

@interface ShopMainVC ()

@property (nonatomic, strong) UIImageView *shakeImg;//摇摆视图
@property (nonatomic, assign) NSInteger *count;//摇摆次数


@end

@implementation ShopMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.name.length > 8  ? [NSString stringWithFormat:@"%@...",[_model.name substringWithRange:NSMakeRange(0, 8)]] : _model.name;
    [self setupUI];
    
}


-(void)setupUI{
    //在请求中携带店铺ID
    TakeawayShopView *shopView = [[TakeawayShopView alloc]initWithFrame:self.view.bounds withGroupID:_model.deviceNo withModel:_model];
    [self.view addSubview:shopView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.view addSubview:self.shakeImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callStore:)];
    [self.shakeImg addGestureRecognizer:tap];
        
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.shakeImg.frame = CGRectMake( IPhone_7_Scale_Width(258), - IPhone_7_Scale_Width(85)/92*150/2 + IPhone_7_Scale_Height(10), IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(85)/92*150);
        
    } completion:^(BOOL finished) {
        
        //开始摆动动画
        CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        momAnimation.fromValue = [NSNumber numberWithFloat:-0.1];
        momAnimation.toValue = [NSNumber numberWithFloat:0.1];
        momAnimation.duration = 0.3;
        momAnimation.repeatCount = 2;
        momAnimation.autoreverses = YES;
        self.shakeImg.layer.anchorPoint = CGPointMake(0.5, 0);
        //momAnimation.delegate = self;
        [self.shakeImg.layer addAnimation:momAnimation forKey:@"animateLayer"];
        
    }];
    
    
}

- (UIImageView *)shakeImg {
    if (!_shakeImg) {
        _shakeImg = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(258), -IPhone_7_Scale_Width(85)/92*150, IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(85)/92*150)];
        _shakeImg.image = [UIImage imageNamed:@"shake"];
        _shakeImg.userInteractionEnabled = YES;
    }
    return _shakeImg;
}


#pragma mark - 打个店
-(void)callStore:(UITapGestureRecognizer *)tap{
    
    CallStoreVC *vc = [[CallStoreVC alloc]init];
    vc.shopModel = _model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
