//
//  FindCarView.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "FindCarView.h"
#import "DD_Alertview.h"
#import "DD_HandlerEnterBackground.h"
@interface FindCarView ()
{
    UILabel * carAddress;
    UIButton * masterBtn;
    NSUInteger _timeNumber;
    UILabel * timeLaber;
    UIImageView * timeImage;
}
@property (nonatomic, strong) UIView * BottomLocationView;
@property (nonatomic,copy) UIButton * tmpBtn;
@property (nonatomic,copy) UIView * backgroudview;
@property (nonatomic,assign) BOOL  isHidde;
@property (nonatomic,strong) UILabel * waitStateOrder;
@property (nonatomic,copy) UIView * timeBackGroud;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation FindCarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame stlype:(NSInteger)tpye
{
    self = [super initWithFrame:frame];
    if (self) {
        if (tpye == 0) {
            [self initUI];

        } else if (tpye == 1)
        {
            [self carInit];
        }
    }
    
    return  self;
}

- (void)carInit{
    
    _BottomLocationView = [[UIView alloc]init];
    [self addSubview:_BottomLocationView];
    [_BottomLocationView activateConstraints:^{
        _BottomLocationView.bottom_attr =self.bottom_attr;
        [_BottomLocationView.left_attr equalTo:self.left_attr constant:0];
        [_BottomLocationView.right_attr equalTo:self.right_attr constant:0];
        _BottomLocationView.height_attr = self.height_attr;
    }];
    _BottomLocationView.layer.cornerRadius = 4.0f;
    _BottomLocationView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:NSLocalizedString(@"现在",nil) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon-Ok-default"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon-Ok"] forState:UIControlStateSelected];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [btn setTitleColor:TextColor forState:UIControlStateSelected];
    [btn setTitleColor:UIColorFromRGB(0xc2c6da) forState:UIControlStateNormal];
    btn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [_BottomLocationView addSubview:btn];
    [btn activateConstraints:^{
        [btn.top_attr equalTo:_BottomLocationView.top_attr constant:16];
        [btn.right_attr equalTo:_BottomLocationView.centerX_attr constant:-14];
        btn.width_attr.constant = 50;
        btn.height_attr.constant = 15;
    }];
    
    
    UIButton *makeAppointmenbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeAppointmenbtn setTitle:NSLocalizedString(@"预约",nil) forState:UIControlStateNormal];
    [makeAppointmenbtn setImage:[UIImage imageNamed:@"icon-Ok-default"] forState:UIControlStateNormal];
    [makeAppointmenbtn setImage:[UIImage imageNamed:@"icon-Ok"] forState:UIControlStateSelected];
    makeAppointmenbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    makeAppointmenbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [makeAppointmenbtn setTitleColor:TextColor forState:UIControlStateSelected];
    [makeAppointmenbtn setTitleColor:UIColorFromRGB(0xc2c6da) forState:UIControlStateNormal];
    makeAppointmenbtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [_BottomLocationView addSubview:makeAppointmenbtn];
    [makeAppointmenbtn activateConstraints:^{
        [makeAppointmenbtn.top_attr equalTo:_BottomLocationView.top_attr constant:16];
        [makeAppointmenbtn.left_attr equalTo:_BottomLocationView.centerX_attr constant:14];
        makeAppointmenbtn.width_attr.constant = 50;
        makeAppointmenbtn.height_attr.constant = 15;
    }];
    makeAppointmenbtn.tag = 12345678;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [makeAppointmenbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.selected = YES;
    _tmpBtn = btn;
    
    
    
    _backgroudview = [[UIView alloc]init];
    [_BottomLocationView addSubview:_backgroudview];
    [_backgroudview activateConstraints:^{
        [_backgroudview.bottom_attr equalTo:_BottomLocationView.bottom_attr constant:-69.5];
        [_backgroudview.left_attr equalTo:_BottomLocationView.left_attr constant:0];
        [_backgroudview.right_attr equalTo:self.right_attr constant:0];
        _backgroudview.height_attr.constant = 42;;
    }];
    
   
    
    carAddress = [[UILabel alloc] init];
    [_backgroudview addSubview:carAddress];
    [carAddress activateConstraints:^{
        [carAddress.left_attr equalTo:_backgroudview.left_attr constant:20];
        [carAddress.right_attr equalTo:_backgroudview.right_attr constant:-100];
        [carAddress.top_attr equalTo:_backgroudview.top_attr constant:0];
        carAddress.height_attr.constant = 21;
    }];
    carAddress.textColor = TextColor;
    carAddress.font = fontStely(@"PingFangSC-Medium", 15);
//    carAddress.text = @"上海市黄浦区鲁班路89弄";
    
    UIButton * addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroudview addSubview: addressBtn];
    [addressBtn activateConstraints:^{
        [addressBtn.right_attr equalTo:_backgroudview.right_attr constant:-15.5];
        addressBtn.width_attr.constant = 55;
        addressBtn.centerY_attr = carAddress.centerY_attr;
        addressBtn.height_attr.constant = 15;
    }];
    addressBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 10);
    [addressBtn setTitle:NSLocalizedString(@"当前地址",nil) forState:UIControlStateNormal];
    [addressBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    addressBtn.layer.cornerRadius = 5;
    addressBtn.layer.borderWidth = 0.5f;
    addressBtn.layer.borderColor = BlueColor.CGColor;
    [addressBtn addTarget:self action:@selector(addressClike:) forControlEvents:UIControlEventTouchUpInside];
    
   
    _deitle= [[UILabel alloc] init];
    [_backgroudview addSubview:_deitle];
    [_deitle activateConstraints:^{
        [_deitle.left_attr equalTo:_backgroudview.left_attr constant:20];
        [_deitle.right_attr equalTo:_backgroudview.right_attr constant:-33];
        [_deitle.top_attr equalTo:carAddress.bottom_attr constant:2.5];
        _deitle.height_attr.constant = 18.5;
    }];
    _deitle.textColor = TextGrayColor;
    _deitle.font = fontStely(@"PingFangSC-Regular", 13);
//    _deitle.text = @"距离：1200米      大约需要20分钟";
    
    
    masterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_BottomLocationView addSubview: masterBtn];
    [masterBtn activateConstraints:^{
        [masterBtn.left_attr equalTo:_BottomLocationView.left_attr constant:20];
        [masterBtn.right_attr equalTo:_BottomLocationView.right_attr constant:-20];
        masterBtn.height_attr.constant = 40;
        [masterBtn.bottom_attr equalTo:_BottomLocationView.bottom_attr constant:-18];
    }];
    masterBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [masterBtn setTitle:NSLocalizedString(@"立刻打店",nil) forState:UIControlStateNormal];
    masterBtn.layer.cornerRadius = 20;
    masterBtn.backgroundColor = BlueColor;
    [masterBtn addTarget:self action:@selector(masterAction:) forControlEvents:UIControlEventTouchUpInside];
    masterBtn.tag = 78348734;

    
    _picker = [[WSDatePickerView alloc]init];
    [_BottomLocationView addSubview:_picker];
    [_picker activateConstraints:^{
        [_picker.top_attr equalTo:makeAppointmenbtn.bottom_attr constant:0];
        _picker.width_attr.constant = 187.5;
        _picker.height_attr.constant = 52.5 + 15;
        _picker.centerX_attr = _BottomLocationView.centerX_attr;
    }];
    _picker.backgroundColor = [UIColor whiteColor];
//    _picker.pickeblock = ^(NSDate *data) {
//        NSString *dateString = [data stringWithFormat:@"dd HH:mm"];
//        NSLog(@"选择的日期：%@",dateString);
//    };
    _isHidde = _picker.hidden = YES;
    
}
- (void)isEdinBtn:(BOOL)click
{
    masterBtn.enabled = click;
    if(click)
    {
        masterBtn.backgroundColor = BlueColor;
    }else
    {
        masterBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
}

- (void)addressToShow:(NSString *)address
{
    carAddress.text =  address;
}
- (void)initUI{
    
    _BottomLocationView = [[UIView alloc]init];
    [self addSubview:_BottomLocationView];
    NSLog(@"%f",NSFoundationVersionNumber);
//    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_x_Max) {
        [_BottomLocationView activateConstraints:^{
            [_BottomLocationView.bottom_attr equalTo:self.bottom_attr_safe];
            [_BottomLocationView.left_attr equalTo:self.left_attr constant:0];
            [_BottomLocationView.right_attr equalTo:self.right_attr constant:0];
            _BottomLocationView.height_attr = self.height_attr;
        }];
//    } else
//    {
//        [_BottomLocationView activateConstraints:^{
//            [_BottomLocationView.bottom_attr equalTo:self.bottom_attr_safe constant:-44];
//            [_BottomLocationView.left_attr equalTo:self.left_attr constant:0];
//            [_BottomLocationView.right_attr equalTo:self.right_attr constant:0];
//            _BottomLocationView.height_attr = self.height_attr;
//        }];
//    }
    
   
    _BottomLocationView.layer.cornerRadius = 4.0f;
    _BottomLocationView.backgroundColor = [UIColor whiteColor];
    
    
    _waitStateOrder = [[UILabel alloc]init];
    [self addSubview:_waitStateOrder];
    [_waitStateOrder activateConstraints:^{
        [_waitStateOrder.top_attr equalTo:self.top_attr constant:15];
        [_waitStateOrder.left_attr equalTo:self.left_attr constant:0];
        [_waitStateOrder.right_attr equalTo:self.right_attr constant:0];
        _waitStateOrder.height_attr.constant = 21;
    }];
    _waitStateOrder.font = fontStely(@"PingFangSC-Medium", 15);
    _waitStateOrder.text = NSLocalizedString(@"等待接单",nil);
    _waitStateOrder.textAlignment = NSTextAlignmentCenter;
    _waitStateOrder.hidden= YES;
    
    
    _timeBackGroud = [[UIView alloc]init];
    [self addSubview:_timeBackGroud];
    
    [_timeBackGroud activateConstraints:^{
        [_timeBackGroud.top_attr equalTo:_waitStateOrder.bottom_attr constant:15];
        [_timeBackGroud.left_attr equalTo:self.left_attr constant:0];
        [_timeBackGroud.right_attr equalTo:self.right_attr constant:0];
        _timeBackGroud.height_attr.constant = 21;
    }];
    _timeBackGroud.hidden = YES;
    
    timeLaber = [[UILabel alloc] init];
    [_timeBackGroud addSubview:timeLaber];
    [timeLaber activateConstraints:^{
        [timeLaber.top_attr equalTo:_timeBackGroud.top_attr];
        [timeLaber.bottom_attr equalTo:_timeBackGroud.bottom_attr];
        [timeLaber.centerX_attr equalTo:_timeBackGroud.centerX_attr];
    }];
    timeLaber.textAlignment = NSTextAlignmentCenter;
    timeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    
    timeImage = [[UIImageView alloc] init];
    [_timeBackGroud addSubview:timeImage];
    [timeImage activateConstraints:^{
        [timeImage.right_attr equalTo:timeLaber.left_attr constant: -10];
        [timeImage.centerY_attr equalTo:_timeBackGroud.centerY_attr];
        timeImage.height_attr.constant = 15;
        timeImage.width_attr.constant = 15;
    }];
    timeImage.image = [UIImage imageNamed:@"icon-time"];
//    timeImage.hidden = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:NSLocalizedString(@"现在",nil) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon-Ok-default"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon-Ok"] forState:UIControlStateSelected];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [btn setTitleColor:TextColor forState:UIControlStateSelected];
    [btn setTitleColor:UIColorFromRGB(0xc2c6da) forState:UIControlStateNormal];
    btn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [_BottomLocationView addSubview:btn];
    [btn activateConstraints:^{
        [btn.top_attr equalTo:_BottomLocationView.top_attr constant:16];
        [btn.right_attr equalTo:_BottomLocationView.centerX_attr constant:-14];
        btn.width_attr.constant = 50;
        btn.height_attr.constant = 15;
    }];
    btn.tag = 8734787343;
    
    UIButton *makeAppointmenbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeAppointmenbtn setTitle:NSLocalizedString(@"预约",nil) forState:UIControlStateNormal];
    [makeAppointmenbtn setImage:[UIImage imageNamed:@"icon-Ok-default"] forState:UIControlStateNormal];
    [makeAppointmenbtn setImage:[UIImage imageNamed:@"icon-Ok"] forState:UIControlStateSelected];
    makeAppointmenbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    makeAppointmenbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [makeAppointmenbtn setTitleColor:TextColor forState:UIControlStateSelected];
    [makeAppointmenbtn setTitleColor:UIColorFromRGB(0xc2c6da) forState:UIControlStateNormal];
    makeAppointmenbtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [_BottomLocationView addSubview:makeAppointmenbtn];
    [makeAppointmenbtn activateConstraints:^{
        [makeAppointmenbtn.top_attr equalTo:_BottomLocationView.top_attr constant:16];
        [makeAppointmenbtn.left_attr equalTo:_BottomLocationView.centerX_attr constant:14];
        makeAppointmenbtn.width_attr.constant = 50;
        makeAppointmenbtn.height_attr.constant = 15;
    }];
    makeAppointmenbtn.tag = 12345678;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [makeAppointmenbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.selected = YES;
    _tmpBtn = btn;
    
    
    
    _backgroudview = [[UIView alloc]init];
    [_BottomLocationView addSubview:_backgroudview];
    [_backgroudview activateConstraints:^{
        [_backgroudview.bottom_attr equalTo:_BottomLocationView.bottom_attr constant:-69.5];
        [_backgroudview.left_attr equalTo:_BottomLocationView.left_attr constant:0];
        [_backgroudview.right_attr equalTo:self.right_attr constant:0];
        _backgroudview.height_attr.constant = 15;;
    }];
    
    UIImageView *CarLocation = [[UIImageView alloc]init];
    [_backgroudview addSubview:CarLocation];
    [CarLocation activateConstraints:^{
        [CarLocation.left_attr equalTo:_backgroudview.left_attr constant:39];
        [CarLocation.top_attr equalTo:_backgroudview.top_attr constant:0];
        CarLocation.height_attr.constant = 16;
        CarLocation.width_attr.constant = 13;
    }];
    CarLocation.image = [UIImage imageNamed:@"icon-place"];
    
    carAddress = [[UILabel alloc] init];
    [_backgroudview addSubview:carAddress];
    [carAddress activateConstraints:^{
        [carAddress.left_attr equalTo:CarLocation.right_attr constant:8];
        [carAddress.right_attr equalTo:_backgroudview.right_attr constant:-100];
        [carAddress.top_attr equalTo:_backgroudview.top_attr constant:0];
        carAddress.height_attr.constant = 15;
    }];
    carAddress.textColor = UIColorFromRGB(0xb2b2b2);
    carAddress.font = fontStely(@"PingFangSC-Regular", 11);
//    carAddress.text = @"上海市长宁区凯旋路90号";
    
    UIButton * addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroudview addSubview: addressBtn];
    [addressBtn activateConstraints:^{
        [addressBtn.right_attr equalTo:_backgroudview.right_attr constant:-45.5];
        addressBtn.width_attr.constant = 45;
        addressBtn.top_attr = carAddress.top_attr;
        addressBtn.height_attr.constant = 15;
    }];
    addressBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 9);
    [addressBtn setTitle:NSLocalizedString(@"当前地址",nil) forState:UIControlStateNormal];
    addressBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [addressBtn setTitleColor:TextColor forState:UIControlStateNormal];
    addressBtn.layer.cornerRadius = 5;
    [addressBtn addTarget:self action:@selector(addressClike:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * arowimage = [[UIImageView alloc]init];
    arowimage.image = [UIImage imageNamed:@"icon"];
    [_backgroudview addSubview: arowimage];
    [arowimage activateConstraints:^{
        [arowimage.right_attr equalTo:_backgroudview.right_attr constant:-33];
        arowimage.centerY_attr = addressBtn.centerY_attr;
        arowimage.height_attr.constant = 7.5;
    }];
    
     masterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_BottomLocationView addSubview: masterBtn];
    [masterBtn activateConstraints:^{
        [masterBtn.left_attr equalTo:_BottomLocationView.left_attr constant:20];
        [masterBtn.right_attr equalTo:_BottomLocationView.right_attr constant:-20];
        masterBtn.height_attr.constant = 40;
        [masterBtn.bottom_attr equalTo:_BottomLocationView.bottom_attr constant:-18];
    }];
    masterBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [masterBtn setTitle:NSLocalizedString(@"立刻打店",nil) forState:UIControlStateNormal];
    masterBtn.layer.cornerRadius = 20;
    masterBtn.backgroundColor = BlueColor;
    [masterBtn addTarget:self action:@selector(masterAction:) forControlEvents:UIControlEventTouchUpInside];
    masterBtn.tag = 129012390;
    
    _picker = [[WSDatePickerView alloc]init];
    [_BottomLocationView addSubview:_picker];
    [_picker activateConstraints:^{
        [_picker.top_attr equalTo:makeAppointmenbtn.bottom_attr constant:0];
        _picker.width_attr.constant = 187.5;
        _picker.height_attr.constant = 52.5 + 15;
        _picker.centerX_attr = _BottomLocationView.centerX_attr;
    }];
    _picker.backgroundColor = [UIColor whiteColor];
    _isHidde = _picker.hidden = YES;
    
}
- (void)pickerminLimitDate:(NSString *)st
{
    _picker.minLimitDate = [NSDate date:st WithFormat:@"yyyy-MM-dd HH:mm"];
}

- (void)btnClick:(UIButton *)btn
{
    //    btn.selected = !btn.selected;
    
    if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
    }else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        btn.selected = YES;
        _tmpBtn = btn;
    }

    if (_tmpBtn.tag == 12345678) {
        
        if (btn.selected && _isHidde) {
            [UIView animateWithDuration:0.4 animations:^{
                
                self.height_attr.constant = self.height + 52.5;
                _isHidde = NO;
                _picker.hidden = NO;
            }];
        }
        
    }else
    {
        if (_isHidde == NO) {
            [UIView animateWithDuration:0.4 animations:^{
                self.height_attr.constant = self.height - 52.5;
                _isHidde = YES;
                _picker.hidden = YES;
                
            }];
        }
    }
}

- (void)masterAction:(UIButton *)btn
{
    NSLog(@"YES召唤/NO预约");
    if (_isHidde) {
        BLOCK_EXEC(_block,NO);
    } else
    {
        BLOCK_EXEC(_block,YES);

    }
}

- (void)addressClike:(UIButton *)btn
{
    NSLog(@"当前地址");
    BLOCK_EXEC(_addressBlock);
}

- (void)callOrderResp:(NSInteger)time isOrderTpye:(NSInteger)tpye time:(NSString *)times
{
    _timeNumber = time;
    [self timeNumss];
//    _timeNumber = 10;
    ///预约
    if (tpye == 1) {
        [UIView animateWithDuration:0.4 animations:^{
            self.height_attr.constant = 133 + 52.5;
            _isHidde = NO;
            _picker.hidden = NO;
        }];
        _timeBackGroud.hidden = NO;
        timeLaber.text = [NSString stringWithFormat:@"%@",[PattayaTool ConvertStrToTime:times Fromatter:@"MM月dd日 HH:mm"]];
        _picker.hidden = YES;
        timeImage.hidden = NO;
    }///及时
    else if (tpye == 2)
    {
//        [UIView animateWithDuration:0.4 animations:^{
//            self.height_attr.constant = self.height - 52.5;
//            _isHidde = YES;
//            _picker.hidden = YES;
//            
//        }];
        _timeBackGroud.hidden = YES;
        timeImage.hidden = YES;
    }
    
    masterBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    UIButton * btn = [self viewWithTag:8734787343];
    UIButton * btns = [self viewWithTag:12345678];
    btn.hidden = YES;
    btns.hidden = YES;
    _waitStateOrder.hidden= NO;
    [masterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

}
- (void)setAddressUser:(NSString *)addressUser
{
    if (addressUser) {
        carAddress.text = addressUser;
    }
}
- (void)overtimeError
{
    [UIView animateWithDuration:0.4 animations:^{
        self.height_attr.constant = self.height - 133;
        _isHidde = YES;
        _picker.hidden = YES;
        
    }];
    masterBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    UIButton * btn = [self viewWithTag:8734787343];
    UIButton * btns = [self viewWithTag:12345678];
    btn.hidden = NO;
    btns.hidden = NO;
    _waitStateOrder.hidden= NO;
    _picker.hidden = YES;
    _timeBackGroud.hidden = YES;

    [masterBtn setTitle:NSLocalizedString(@"立刻打店",nil) forState:UIControlStateNormal];
    [masterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    masterBtn.backgroundColor = BlueColor;
    DD_Alertview * aler = [[DD_Alertview alloc] initWithFrame:GetAppDelegate.window.bounds stlyeView:DD_AlertviewStlyeOverTime navStatusHeight:0];
    aler.block = ^{
    };
    [aler show];
}
- (void)oldUI
{
    [UIView animateWithDuration:0.4 animations:^{
        self.height_attr.constant = 133;
        _isHidde = YES;
        _picker.hidden = YES;
        
    }];
    masterBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    UIButton * btn = [self viewWithTag:8734787343];
    UIButton * btns = [self viewWithTag:12345678];
    btn.hidden = NO;
    btns.hidden = NO;
    _waitStateOrder.hidden= YES;
    _picker.hidden = YES;
    _timeBackGroud.hidden = YES;
    
    [masterBtn setTitle:NSLocalizedString(@"立刻打店",nil) forState:UIControlStateNormal];
    [masterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    masterBtn.backgroundColor = BlueColor;
}

- (void)PUTcallorderRequest
{
    [[PattayaUserServer singleton] PUTcallorderRequest:_orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"取消订单");
        if ([ResponseModel isData:ret]) {
            [self overtimeError];
            BLOCK_EXEC(_timeoutBlock);
            BLOCK_EXEC(_canlesBlock);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)timeNumss{
   
    [DD_HandlerEnterBackground addObserverUsingBlock:^(NSNotification * _Nonnull note, NSTimeInterval stayBackgroundTime) {
        _timeNumber = _timeNumber-stayBackgroundTime;
    }];
    [self timeINit];
}

-(void)timeINit{
 
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
}
//定时操作，更新UI
- (void)handleTimer {
    if (_timeNumber <= 0) {
        masterBtn.enabled = YES;
        [masterBtn setTitle:NSLocalizedString(@"超时",nil) forState:UIControlStateNormal];
        [masterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self PUTcallorderRequest];
        [self.timer invalidate];
    } else {
        NSString * st = NSLocalizedString(@"正在等待接单",nil);
        masterBtn.enabled = NO;
        [masterBtn setTitle:[NSString stringWithFormat:@"%@(%lds)",st,(long)_timeNumber] forState:UIControlStateNormal];
        [masterBtn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];

    }
    _timeNumber--;
    
    
}
- (void)timeStop{
    [self.timer invalidate];
    self.timer = nil;
    [DD_HandlerEnterBackground removeNotificationObserver:self];

}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
