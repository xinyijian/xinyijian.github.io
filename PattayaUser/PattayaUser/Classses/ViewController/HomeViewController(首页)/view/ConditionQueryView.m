//
//  ConditionQueryView.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ConditionQueryView.h"
@interface ConditionQueryView ()
@property (strong, nonatomic) UIButton * tmpBtn;
@property (nonatomic, strong) UIView * lineBottom;
@end
@implementation ConditionQueryView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
//    self = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 30)];
    self.backgroundColor = [UIColor whiteColor];
    UIView * bloackGourCar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 213, 30)];
    bloackGourCar.backgroundColor = [UIColor whiteColor];
    [self addSubview:bloackGourCar];
    bloackGourCar.centerX = SCREEN_Width / 2.0f;
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_Width - 30, 1)];
    line.backgroundColor = UIColorFromRGB(0xF4F4F6);
    [self addSubview:line];
    line.centerX = SCREEN_Width / 2.0f;
    
    UIButton * locationBtn = [self initbuttonStyeframe: CGRectMake(5, 5, 51, 16.5) font:fontStely(@"PingFangSC-Regular", 12) text:NSLocalizedString(@"距离优先",nil)];
    locationBtn.tag = 99999;
    [bloackGourCar addSubview:locationBtn];
    
    //    UIButton  * categoryBtn = [self initbuttonStyeframe: CGRectMake(locationBtn.rightBee + 14, 5, 60, 16.5) font:fontStely(@"PingFangSC-Regular", 12) text:@"多品类优先"];
    //    [bloackGourCar addSubview:categoryBtn];
    
    UIButton  * serviceBtn = [self initbuttonStyeframe: CGRectMake(locationBtn.rightBee + 14, 5, 72, 16.5) font:fontStely(@"PingFangSC-Regular", 12) text:NSLocalizedString(@"低服务费优先",nil)];
    [bloackGourCar addSubview:serviceBtn];
    serviceBtn.tag = 99999 + 1;
    
    UIButton  * discountBtn = [self initbuttonStyeframe: CGRectMake(serviceBtn.rightBee + 14, 5, 48, 16.5) font:fontStely(@"PingFangSC-Regular", 12) text:NSLocalizedString(@"折扣优先",nil)];
    [bloackGourCar addSubview:discountBtn];
    discountBtn.tag = 99999 + 2;
    
    
    UIView * lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 27.5, 40, 2.5)];
    lineBottom.backgroundColor = BlueColor;
    lineBottom.centerX = locationBtn.centerX;
    [bloackGourCar addSubview:lineBottom];
    _lineBottom = lineBottom;
    
    
    locationBtn.selected = YES;
    _tmpBtn = locationBtn;
    [self animateWithBtn:_tmpBtn];
//    self.tableview.tableHeaderView = _hotViewBlack;
}
- (UIButton *)initbuttonStyeframe:(CGRect)frame font:(UIFont *)font text:(NSString *)title
{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:TextColor forState:UIControlStateSelected];
    [btn setTitleColor:UIColorFromRGB(0xC2C6DA) forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
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
- (void)actionBtn:(UIButton *)btn
{
    if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
        [self animateWithBtn:_tmpBtn];
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
    }else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [self animateWithBtnDidcompletion:_tmpBtn];
        btn.selected = YES;
        [self animateWithBtn:btn];
        
        _tmpBtn = btn;
    }
    BLOCK_EXEC(_clickBlock,_tmpBtn.tag - 99999);
//    [self SeachStoreCodeRequestHTTP:_tmpBtn.tag - 99999 text:nil];
//    
//    [_tableview reloadData];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
