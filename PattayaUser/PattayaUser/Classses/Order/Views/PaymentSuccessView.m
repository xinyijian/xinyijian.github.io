//
//  PaymentSuccessView.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentSuccessView.h"

@implementation PaymentSuccessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = App_TotalGrayWhite;
        [self initViews];
        
        
        
    }
    return self;
}

-(void)initViews{
    
    //adv
    _advImg = [[UIImageView alloc] init];
    _advImg.image = [UIImage imageNamed:@"payment_adv"];
    [self addSubview: _advImg];
    [_advImg activateConstraints:^{
        [_advImg.left_attr equalTo:self.left_attr];
         [_advImg.right_attr equalTo:self.right_attr];
        [_advImg.top_attr equalTo:self.top_attr];
        _advImg.height_attr.constant = IPhone_7_Scale_Width(108);
    }];
    
    //白色背景
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = UIColorWhite;
    [self addSubview:_bgView];
    [_bgView activateConstraints:^{
        [_bgView.left_attr equalTo:self.left_attr];
        [_bgView.right_attr equalTo:self.right_attr];
        [_bgView.top_attr equalTo:_advImg.bottom_attr];
        _bgView.height_attr.constant = IPhone_7_Scale_Height(210);
    }];
    
    //
    _successImg = [[UIImageView alloc] init];
    _successImg.image = [UIImage imageNamed:@"pic_success"];
    [self.bgView addSubview: _successImg];
    [_successImg activateConstraints:^{
        [_successImg.top_attr equalTo:self.bgView.top_attr constant:(IPhone_7_Scale_Height(20))];
        _successImg.height_attr.constant = IPhone_7_Scale_Height(50);
        _successImg.width_attr.constant = IPhone_7_Scale_Height(50);
        _successImg.centerX_attr = _bgView.centerX_attr;
    }];
    
    //支付成功
    _successLabel = [[UILabel alloc] init];
    _successLabel.font = UIBoldFont(16);
    _successLabel.textColor = TextColor;
    _successLabel.text = @"支付成功";
    [_successLabel sizeToFit];
    [self.bgView addSubview: _successLabel];
    [_successLabel activateConstraints:^{
        [_successLabel.top_attr equalTo:_successImg.bottom_attr constant:IPhone_7_Scale_Height(8)];
        _successLabel.height_attr.constant = IPhone_7_Scale_Height(22);
        _successLabel.centerX_attr = _bgView.centerX_attr;
    }];
    
    //支付金额
    _totalAmountLabel = [[UILabel alloc] init];
    _totalAmountLabel.font = fontStely(@"PingFangSC", 24);
    _totalAmountLabel.textColor = TextColor;
    _totalAmountLabel.text = @"￥14.00";
    [_totalAmountLabel sizeToFit];
    [self.bgView addSubview: _totalAmountLabel];
    [_totalAmountLabel activateConstraints:^{
        [_totalAmountLabel.top_attr equalTo:_successLabel.bottom_attr constant:IPhone_7_Scale_Height(8)];
        _totalAmountLabel.height_attr.constant = IPhone_7_Scale_Height(33);
        _totalAmountLabel.centerX_attr = _bgView.centerX_attr;
    }];
    
    //预计到达
    _reachTimeLabel = [[UILabel alloc] init];
    _reachTimeLabel.font = K_LABEL_SMALL_FONT_14;
    _reachTimeLabel.textColor = TextColor;
    _reachTimeLabel.text = @"预计到达";
    _reachTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview: _reachTimeLabel];
    [_reachTimeLabel activateConstraints:^{
        [_reachTimeLabel.top_attr equalTo:_totalAmountLabel.bottom_attr constant:IPhone_7_Scale_Height(12)];
        _reachTimeLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        _reachTimeLabel.width_attr.constant = 100;
        [_reachTimeLabel.left_attr equalTo:_bgView.left_attr constant:((SCREEN_Width-1)/2 - 100)/2];

    }];
    
   // 联系卖家
    _contactLabel = [[UILabel alloc] init];
    _contactLabel.font = K_LABEL_SMALL_FONT_14;
    _contactLabel.textColor = TextColor;
    _contactLabel.text = @"联系卖家";
    _contactLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview: _contactLabel];
    [_contactLabel activateConstraints:^{
        [_contactLabel.top_attr equalTo:_totalAmountLabel.bottom_attr constant:IPhone_7_Scale_Height(12)];
        _contactLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        _contactLabel.width_attr.constant = 100;
        [_contactLabel.right_attr equalTo:_bgView.right_attr constant:-((SCREEN_Width-1)/2 - 100)/2];

    }];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = K_LABEL_SMALL_FONT_16;
    _timeLabel.textColor = App_Nav_BarDefalutColor;
    _timeLabel.text = @"19：00";
    [_timeLabel sizeToFit];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview: _timeLabel];
    [_timeLabel activateConstraints:^{
        [_timeLabel.top_attr equalTo:_reachTimeLabel.bottom_attr constant:IPhone_7_Scale_Height(2)];
        _timeLabel.height_attr.constant = IPhone_7_Scale_Height(22);
        _timeLabel.centerX_attr = _reachTimeLabel.centerX_attr;
    }];
    
    //电话
    _contactBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_contactBT setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [_contactBT setImage:[UIImage imageNamed:@"phone"]  forState:UIControlStateSelected];
    [self addSubview:_contactBT];
    [_contactBT activateConstraints:^{
        [_contactBT.top_attr equalTo:_contactLabel.bottom_attr constant:IPhone_7_Scale_Height(2)];
        _contactBT.height_attr.constant = IPhone_7_Scale_Height(22);
        _contactBT.centerX_attr = _contactLabel.centerX_attr;
    }];
    
    //line
    UIImageView * line = [[UIImageView alloc] init];
    line.image = [UIImage imageNamed:@"payment_line"];
    [self.bgView addSubview: line];
    [line activateConstraints:^{
        [line.top_attr equalTo:self.totalAmountLabel.bottom_attr constant:(IPhone_7_Scale_Height(14))];
        line.height_attr.constant = IPhone_7_Scale_Height(40);
        line.width_attr.constant = 1;
        line.centerX_attr = _bgView.centerX_attr;
    }];
    
    //完成
    _completeBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_completeBT setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _completeBT.backgroundColor = App_Nav_BarDefalutColor;
    _completeBT.layer.cornerRadius = 19;
    _completeBT.layer.masksToBounds = YES;
    [self addSubview:_completeBT];
    [_completeBT activateConstraints:^{
        [_completeBT.top_attr equalTo:self.bgView.bottom_attr constant:IPhone_7_Scale_Height(40)];
        _completeBT.width_attr.constant = IPhone_7_Scale_Width(250);
        _completeBT.height_attr.constant = 38;
        _completeBT.centerX_attr = self.centerX_attr;
    }];


    
}
@end
