//
//  DD_Alertview.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])

#import "DD_Alertview.h"
@interface DD_Alertview ()
@property (nonatomic, assign) DD_AlertviewStlye stlyeView;
@property (nonatomic, strong) UIButton * editBtn;
@property (nonatomic, assign) CGFloat  navStatusHeight;



@end
@implementation DD_Alertview
- (id)initWithFrame:(CGRect)frame stlyeView:(DD_AlertviewStlye)stlyeview navStatusHeight:(CGFloat)navStatusHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navStatusHeight = navStatusHeight;
        self.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = RGBA(0, 0, 0, 0.25);

        if (stlyeview == DD_AlertviewStlyeNone) {
            [self NoneViewInit];
        } else if (stlyeview == DD_AlertviewStlyeOverTime)
        {
            [self overTimeInit];
        } else if (stlyeview == DD_AlertviewStlyeConfirm)
        {
            [self ConfirmInit];
        } else if (stlyeview == DD_AlertviewStlyeDidDonw)
        {
            [self DidDonwInit];
        } else if (stlyeview == DD_AlertviewStlyeNonSopport)
        {
            //        self.backgroundColor = [UIColor clearColor];
//            self.backgroundColor = [UIColor clearColor];
            [self NonSopportInit];
        } else if (stlyeview == DD_AlertviewStlyeCancelOrder)
        {
            [self CancelOrder];
        }
   
     
        
    }
    
    return self;
}
/**
 DD_AlertviewStlyeNone, //接单成功
 DD_AlertviewStlyeOverTime, //超时
 DD_AlertviewStlyeConfirm, //确认
 DD_AlertviewStlyeDidDonw, //到达
 DD_AlertviewStlyeNonSopport// 不支持
 **/
- (void)NoneViewInit
{
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-75];
        backGrouView.height_attr.constant = 332;
//        [backGrouView.top_attr equalTo:self.top_attr constant:64 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];
        [backGrouView.left_attr equalTo:self.left_attr constant:37.5];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;

    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"成功接单"]];
    [self addSubview:image];
    [image activateConstraints:^{
        [image.top_attr equalTo:backGrouView.top_attr constant:38];
        image.centerX_attr = self.centerX_attr;
    }];
    
    UILabel * laberNone = [[UILabel alloc]init];
    [self addSubview:laberNone];
    [laberNone activateConstraints:^{
        [laberNone.top_attr equalTo:image.bottom_attr constant:17.5];
        laberNone.height_attr.constant = 32;
        laberNone.width_attr = backGrouView.width_attr;
        laberNone.left_attr = backGrouView.left_attr;
    }];
    laberNone.text = NSLocalizedString(@"成功接单",nil);
    laberNone.font = fontStely(@"PingFangSC-Regular", 16);
    laberNone.textColor = TextColor;
    laberNone.textAlignment = NSTextAlignmentCenter;
    
    
    _storeLaber = [[UILabel alloc]init];
    [self addSubview:_storeLaber];
    [_storeLaber activateConstraints:^{
        [_storeLaber.top_attr equalTo:laberNone.bottom_attr constant:8.5];
        [_storeLaber.left_attr equalTo:laberNone.left_attr constant:15];
        [_storeLaber.right_attr equalTo:laberNone.right_attr constant:-15];
        _storeLaber.height_attr.constant = 24;
    }];
//    _storeLaber.text = @"商品种类：蔬菜";
    _storeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _storeLaber.textAlignment = NSTextAlignmentCenter;
    _storeLaber.numberOfLines = 2;
    
    _locationLaber = [[UILabel alloc]init];
    [self addSubview:_locationLaber];
    
    [_locationLaber activateConstraints:^{
        [_locationLaber.left_attr equalTo:laberNone.left_attr constant:0];
        [_locationLaber.right_attr equalTo:laberNone.right_attr];
        _locationLaber.height_attr.constant = 24;
        [_locationLaber.top_attr equalTo:_storeLaber.bottom_attr];
    }];
    
//    _locationLaber.text = @"距离您：1489米";
    _locationLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _locationLaber.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLaber = [[UILabel alloc]init];
    [self addSubview:_timeLaber];
    [_timeLaber activateConstraints:^{
        [_timeLaber.left_attr equalTo:laberNone.left_attr constant:0];
        [_timeLaber.right_attr equalTo:laberNone.right_attr];
        _timeLaber.height_attr.constant = 24;
        [_timeLaber.top_attr equalTo:_locationLaber.bottom_attr];
    }];
//    _timeLaber.text = @"大约需要：14分钟";
    _timeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _timeLaber.textAlignment = NSTextAlignmentCenter;
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_editBtn];
    [_editBtn activateConstraints:^{
        _editBtn.height_attr.constant = 40;
        _editBtn.width_attr.constant = 150;
        [_editBtn.bottom_attr equalTo:backGrouView.bottom_attr constant:-40];
        [_editBtn.centerX_attr equalTo:backGrouView.centerX_attr];
    }];
    _editBtn.layer.cornerRadius = 20;
    _editBtn.backgroundColor = BlueColor;
    [_editBtn setTitle:NSLocalizedString(@"知道了",nil) forState:UIControlStateNormal];
    _editBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    
    [_editBtn addTarget:self action:@selector(deitAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)overTimeInit
{
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-75];
        backGrouView.height_attr.constant = 251.5;
//        [backGrouView.top_attr equalTo:self.top_attr constant:100.5 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];
        [backGrouView.left_attr equalTo:self.left_attr constant:37.5];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;
    
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"超时"]];
    [self addSubview:image];
    [image activateConstraints:^{
        [image.top_attr equalTo:backGrouView.top_attr constant:26.5];
        image.centerX_attr = self.centerX_attr;
    }];
    
    UILabel * laberNone = [[UILabel alloc]init];
    [self addSubview:laberNone];
    [laberNone activateConstraints:^{
        [laberNone.top_attr equalTo:image.bottom_attr constant:12];
        laberNone.height_attr.constant = 32;
        laberNone.width_attr = backGrouView.width_attr;
        laberNone.left_attr = backGrouView.left_attr;
    }];
    laberNone.text = NSLocalizedString(@"超时",nil);
    laberNone.font = fontStely(@"PingFangSC-Regular", 16);
    laberNone.textColor = TextColor;
    laberNone.textAlignment = NSTextAlignmentCenter;
    
    
    _storeLaber = [[UILabel alloc]init];
    [self addSubview:_storeLaber];
    [_storeLaber activateConstraints:^{
        [_storeLaber.top_attr equalTo:laberNone.bottom_attr constant:1.5];
        [_storeLaber.left_attr equalTo:laberNone.left_attr constant:15];
        [_storeLaber.right_attr equalTo:laberNone.right_attr constant:-15];
        _storeLaber.height_attr.constant = 48;
    }];
    _storeLaber.text = NSLocalizedString(@"附近可能没有空闲的智慧商店",nil);
    _storeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _storeLaber.textAlignment = NSTextAlignmentCenter;
    _storeLaber.numberOfLines = 2;
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_editBtn];
    [_editBtn activateConstraints:^{
        _editBtn.height_attr.constant = 40;
        _editBtn.width_attr.constant = 150;
        [_editBtn.bottom_attr equalTo:backGrouView.bottom_attr constant:-38];
        [_editBtn.centerX_attr equalTo:backGrouView.centerX_attr];
    }];
    _editBtn.layer.cornerRadius = 20;
    _editBtn.backgroundColor = BlueColor;
    [_editBtn setTitle:NSLocalizedString(@"返回",nil) forState:UIControlStateNormal];
    _editBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    
    [_editBtn addTarget:self action:@selector(deitAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)ConfirmInit
{
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-111];
        backGrouView.height_attr.constant = 265;
//        [backGrouView.top_attr equalTo:self.top_attr constant:161.5 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];

        [backGrouView.centerX_attr equalTo:self.centerX_attr];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;
    
   
    UILabel * laberNone = [[UILabel alloc]init];
    [self addSubview:laberNone];
    [laberNone activateConstraints:^{
        [laberNone.top_attr equalTo:backGrouView.top_attr constant:26];
        laberNone.height_attr.constant = 32;
        laberNone.width_attr = backGrouView.width_attr;
        laberNone.left_attr = backGrouView.left_attr;
    }];
    laberNone.text = NSLocalizedString(@"确认下单",nil);
    laberNone.font = fontStely(@"PingFangSC-Regular", 16);
    laberNone.textColor = TextColor;
    laberNone.textAlignment = NSTextAlignmentCenter;
    
    
    _storeLaber = [[UILabel alloc]init];
    [self addSubview:_storeLaber];
    [_storeLaber activateConstraints:^{
        [_storeLaber.top_attr equalTo:laberNone.bottom_attr constant:1.5];
        [_storeLaber.left_attr equalTo:laberNone.left_attr constant:15];
        [_storeLaber.right_attr equalTo:laberNone.right_attr constant:-15];
//        _storeLaber.height_attr.constant = 32;
        [_storeLaber.bottom_attr equalTo:self.centerY_attr constant:0];
    }];
    _storeLaber.text = NSLocalizedString(@"附近可能没有空闲的智慧商店",nil);
    _storeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _storeLaber.textAlignment = NSTextAlignmentCenter;
    _storeLaber.numberOfLines = 2;
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_editBtn];
    [_editBtn activateConstraints:^{
        _editBtn.height_attr.constant = 33;
        [_editBtn.bottom_attr equalTo:backGrouView.bottom_attr constant:-17.5];
        [_editBtn.left_attr equalTo:backGrouView.left_attr constant:22];
        [_editBtn.right_attr equalTo:backGrouView.centerX_attr constant:-10];
    }];
    _editBtn.layer.cornerRadius = 16.5;
    _editBtn.backgroundColor = BlueColor;
    [_editBtn setTitle:NSLocalizedString(@"确定",nil) forState:UIControlStateNormal];
    _editBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    
    [_editBtn addTarget:self action:@selector(deitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:rightBtn];
    [rightBtn activateConstraints:^{
        rightBtn.height_attr.constant = 33;
        [rightBtn.bottom_attr equalTo:backGrouView.bottom_attr constant:-17.5];
        [rightBtn.left_attr equalTo:backGrouView.centerX_attr constant:10];
        [rightBtn.right_attr equalTo:backGrouView.right_attr constant:-22];
    }];
    rightBtn.layer.cornerRadius = 16.5;
    rightBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [rightBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(delegateAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}



- (void)DidDonwInit
{
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-111];
        backGrouView.height_attr.constant = 205;
        //        [backGrouView.top_attr equalTo:self.top_attr constant:161.5 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];
        
        [backGrouView.centerX_attr equalTo:self.centerX_attr];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;
    
    UILabel * laberNone = [[UILabel alloc]init];
    [self addSubview:laberNone];
    [laberNone activateConstraints:^{
        [laberNone.top_attr equalTo:backGrouView.top_attr constant:45];
        laberNone.height_attr.constant = 32;
        laberNone.width_attr = backGrouView.width_attr;
        laberNone.left_attr = backGrouView.left_attr;
    }];
    laberNone.text = NSLocalizedString(@"到达通知",nil);
    laberNone.font = fontStely(@"PingFangSC-Regular", 16);
    laberNone.textColor = TextColor;
    laberNone.textAlignment = NSTextAlignmentCenter;
    
    _locationLaber = [[UILabel alloc]init];
    [self addSubview:_locationLaber];
    
    [_locationLaber activateConstraints:^{
        [_locationLaber.left_attr equalTo:laberNone.left_attr constant:0];
        [_locationLaber.right_attr equalTo:laberNone.right_attr];
        _locationLaber.height_attr.constant = 48;
        [_locationLaber.top_attr equalTo:laberNone.bottom_attr constant:8.5];
    }];
    
//    _locationLaber.text = @"您召唤的智慧购物车已经到达";
    _locationLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _locationLaber.textAlignment = NSTextAlignmentCenter;
    _locationLaber.numberOfLines = 2;

    
    _timeLaber = [[UILabel alloc]init];
    [self addSubview:_timeLaber];
    [_timeLaber activateConstraints:^{
        [_timeLaber.left_attr equalTo:laberNone.left_attr constant:0];
        [_timeLaber.right_attr equalTo:laberNone.right_attr];
        _timeLaber.height_attr.constant = 24;
        [_timeLaber.top_attr equalTo:_locationLaber.bottom_attr];
    }];
//    _timeLaber.text = @" 车牌号：沪A0000  白色";
    _timeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _timeLaber.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: closeBtn];
    [closeBtn activateConstraints:^{
       
        closeBtn.height_attr.constant = 46;
        closeBtn.width_attr.constant = 46;
        [closeBtn.top_attr equalTo:backGrouView.top_attr];
        [closeBtn.right_attr equalTo:backGrouView.right_attr];
    }];
    [closeBtn setImage:[UIImage imageNamed:@"icon-Close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)CancelOrder
{
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-111];
        backGrouView.height_attr.constant = 133;
        //        [backGrouView.top_attr equalTo:self.top_attr constant:161.5 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];
        
        [backGrouView.centerX_attr equalTo:self.centerX_attr];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;
    
    _locationLaber = [[UILabel alloc]init];
    [self addSubview:_locationLaber];
    
    [_locationLaber activateConstraints:^{
        [_locationLaber.left_attr equalTo:backGrouView.left_attr constant:0];
        [_locationLaber.right_attr equalTo:backGrouView.right_attr];
        _locationLaber.height_attr.constant = 24;
        [_locationLaber.top_attr equalTo:backGrouView.top_attr constant:35];
    }];
    _locationLaber.numberOfLines = 1;
    //    _locationLaber.text = @"您召唤的智慧购物车已经到达";
    _locationLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _locationLaber.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLaber = [[UILabel alloc]init];
    [self addSubview:_timeLaber];
    [_timeLaber activateConstraints:^{
        [_timeLaber.left_attr equalTo:backGrouView.left_attr constant:15];
        [_timeLaber.right_attr equalTo:backGrouView.right_attr constant:-15];
        _timeLaber.height_attr.constant = 48;
        [_timeLaber.top_attr equalTo:_locationLaber.bottom_attr];
    }];
    //    _timeLaber.text = @" 车牌号：沪A0000  白色";
    _timeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _timeLaber.textAlignment = NSTextAlignmentCenter;
    _timeLaber.numberOfLines = 2;

    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: closeBtn];
    [closeBtn activateConstraints:^{
        
        closeBtn.height_attr.constant = 46;
        closeBtn.width_attr.constant = 46;
        [closeBtn.top_attr equalTo:backGrouView.top_attr];
        [closeBtn.right_attr equalTo:backGrouView.right_attr];
    }];
    [closeBtn setImage:[UIImage imageNamed:@"icon-Close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)NonSopportInit
{
    
    UIView * backGrouView = [[UIView alloc] init];
    [self addSubview: backGrouView];
    [backGrouView activateConstraints:^{
        [backGrouView.width_attr equalTo:self.width_attr constant:-111];
        backGrouView.height_attr.constant = 133;
        //        [backGrouView.top_attr equalTo:self.top_attr constant:161.5 + self.navStatusHeight];
        [backGrouView.centerY_attr equalTo:self.centerY_attr constant:-10];
        
        [backGrouView.centerX_attr equalTo:self.centerX_attr];
    }];
    backGrouView.backgroundColor =[UIColor whiteColor];
    backGrouView.layer.cornerRadius = 5;
  
    _locationLaber = [[UILabel alloc]init];
    [self addSubview:_locationLaber];
    
    [_locationLaber activateConstraints:^{
        [_locationLaber.left_attr equalTo:backGrouView.left_attr constant:0];
        [_locationLaber.right_attr equalTo:backGrouView.right_attr];
        _locationLaber.height_attr.constant = 24;
        [_locationLaber.top_attr equalTo:backGrouView.top_attr constant:45];
    }];
    _locationLaber.numberOfLines = 2;
//    _locationLaber.text = @"您召唤的智慧购物车已经到达";
    _locationLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _locationLaber.textAlignment = NSTextAlignmentCenter;
    
    
    _timeLaber = [[UILabel alloc]init];
    [self addSubview:_timeLaber];
    [_timeLaber activateConstraints:^{
        [_timeLaber.left_attr equalTo:backGrouView.left_attr constant:0];
        [_timeLaber.right_attr equalTo:backGrouView.right_attr];
        _timeLaber.height_attr.constant = 24;
        [_timeLaber.top_attr equalTo:_locationLaber.bottom_attr];
    }];
//    _timeLaber.text = @" 车牌号：沪A0000  白色";
    _timeLaber.font = fontStely(@"PingFangSC-Regular", 13);
    _timeLaber.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: closeBtn];
    [closeBtn activateConstraints:^{
        
        closeBtn.height_attr.constant = 46;
        closeBtn.width_attr.constant = 46;
        [closeBtn.top_attr equalTo:backGrouView.top_attr];
        [closeBtn.right_attr equalTo:backGrouView.right_attr];
    }];
    [closeBtn setImage:[UIImage imageNamed:@"icon-Close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    
}



- (void)closeView
{
    [self dissmiss];
    BLOCK_EXEC(_block);

}

- (void)show {
    self.tag = 21000;
    self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    [UIView animateWithDuration:0.25 animations:^{
        [self dissmiss];
        self.transform = CGAffineTransformIdentity;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    } completion:^(BOOL finished) {
    }];
}

- (void)dissmiss {
    NSEnumerator *subviewsEnum = [[UIApplication sharedApplication].keyWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if (subview.tag == 21000) {
            [subview removeFromSuperview];
        }
    }
}

- (void)delegateAction
{
    [self dissmiss];

}

///知道了.返回
- (void)deitAction:(UIButton *)btn
{
    [self dissmiss];
    BLOCK_EXEC(_block);
}

- (void)setCategoryText:(NSString *)categoryText
{
    _categoryText = categoryText;
    if (categoryText) {
    NSString * st = NSLocalizedString(@"商品种类：",nil);
    _storeLaber.text = [NSString stringWithFormat:@"%@%@",st,_categoryText];
    }

}

- (void)setNeedsTimeText:(NSString *)needsTimeText
{
    _needsTimeText = needsTimeText;
    if (needsTimeText) {
        NSString * st = NSLocalizedString(@"大约需要：",nil);
        NSString * st1 = NSLocalizedString(@"分",nil);
        _timeLaber.text = [NSString stringWithFormat:@"%@%@ %@",st,_needsTimeText,st1];
    }
    
}

- (void)setDistantText:(NSString *)distantText
{
    _distantText = distantText;
    if (distantText) {
        NSString * st = NSLocalizedString(@"距离您：",nil);
        _locationLaber.text = [NSString stringWithFormat:@"%@%@",st,distantText];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
