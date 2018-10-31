//
//  PaymentBottomView.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentBottomView.h"


@interface PaymentBottomView()

@end

@implementation PaymentBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0x3E3E3E);
        
        [self initViews];
        
    }
    return self;
}

-(void)initViews{
    
    
    //优惠
    _discountLabel = [[UILabel alloc] init];
    _discountLabel.font = K_LABEL_SMALL_FONT_10;
    _discountLabel.textColor = UIColorFromRGB(0xB5B5B5);
    _discountLabel.text = @"已优惠￥6.00";
    _discountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview: _discountLabel];
    [_discountLabel activateConstraints:^{
        [_discountLabel.left_attr equalTo:self.left_attr constant:IPhone_7_Scale_Width(10)];
        _discountLabel.height_attr.constant = BottomH;
        [_discountLabel.bottom_attr equalTo:self.bottom_attr constant:-(SafeAreaBottomHeight)];
    }];
    
    //去支付
    _paymentBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_paymentBT setTitle:@"去支付" forState:UIControlStateNormal];
    [_paymentBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _paymentBT.backgroundColor = App_Nav_BarDefalutColor;
    [self addSubview:_paymentBT];
    [_paymentBT activateConstraints:^{
        [_paymentBT.right_attr equalTo:self.right_attr constant:0];
        [_paymentBT.top_attr equalTo:self.top_attr constant:0];
        _paymentBT.width_attr.constant = 110;
        [_paymentBT.bottom_attr equalTo:self.bottom_attr constant:-SafeAreaBottomHeight];
    }];
    
    //总额
    _totalAmountLabel = [[UILabel alloc] init];
    _totalAmountLabel.font = K_LABEL_SMALL_FONT_16;
    _totalAmountLabel.textColor = UIColorWhite;
    _totalAmountLabel.text = @"￥14.00";
    _totalAmountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview: _totalAmountLabel];
    [_totalAmountLabel activateConstraints:^{
        [_totalAmountLabel.right_attr equalTo:_paymentBT.left_attr constant:IPhone_7_Scale_Width(-20)];
        _totalAmountLabel.height_attr.constant = BottomH;
        [_totalAmountLabel.bottom_attr equalTo:self.bottom_attr constant:-SafeAreaBottomHeight];
    }];
    
    //合计
    UILabel *hejiLabel = [[UILabel alloc] init];
    hejiLabel.font = K_LABEL_SMALL_FONT_10;
    hejiLabel.textColor = UIColorWhite;
    hejiLabel.text = @"合计";
    hejiLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview: hejiLabel];
    [hejiLabel activateConstraints:^{
        [hejiLabel.right_attr equalTo:_totalAmountLabel.left_attr constant:0];
        hejiLabel.height_attr.constant = BottomH;
        [hejiLabel.bottom_attr equalTo:self.bottom_attr constant:-SafeAreaBottomHeight];

    }];
    

    
    
}

@end

