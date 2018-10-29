//
//  ShoppingBottomView.m
//  PattayaUser
//
//  Created by yanglei on 2018/9/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ShoppingBottomView.h"

@interface ShoppingBottomView()
{
    
    int count;
    float totalAmount;
}

@end

@implementation ShoppingBottomView

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
    
    
    _shopCarBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shopCarBT setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
    [_shopCarBT setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateHighlighted];
    [self addSubview:_shopCarBT];
    [_shopCarBT activateConstraints:^{
        [_shopCarBT.left_attr equalTo:self.left_attr constant:IPhone_7_Scale_Width(18)];
        _shopCarBT.height_attr.constant = 49;
        _shopCarBT.width_attr.constant = 49;
        [_shopCarBT.bottom_attr equalTo:self.bottom_attr constant:-(12+SafeAreaBottomHeight)];
        
    }];
    
    //总额
    _countLabel = [[UILabel alloc] init];
    _countLabel.font = [UIFont systemFontOfSize:11];
    _countLabel.textColor = UIColorWhite;
    _countLabel.backgroundColor = UIColorFromRGB(0xFF3B30);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.layer.cornerRadius = 10;
    _countLabel.layer.masksToBounds = 10;
    _countLabel.hidden = YES;
    [_shopCarBT addSubview: _countLabel];
    [_countLabel activateConstraints:^{
        [_countLabel.left_attr equalTo:_shopCarBT.right_attr constant:-15];
        _countLabel.height_attr.constant = 20;
        _countLabel.width_attr.constant = 20;
        [_countLabel.top_attr equalTo:_shopCarBT.top_attr constant:-5];
        
    }];
    
    
    //总额
    _totalAmountLabel = [[UILabel alloc] init];
    _totalAmountLabel.font = K_LABEL_SMALL_FONT_16;
    _totalAmountLabel.textColor = UIColorWhite;
    _totalAmountLabel.text = @"￥0";
    [self addSubview: _totalAmountLabel];
    [_totalAmountLabel activateConstraints:^{
        [_totalAmountLabel.left_attr equalTo:_shopCarBT.right_attr constant:0];
        _totalAmountLabel.height_attr.constant = BottomH;
        _totalAmountLabel.width_attr.constant = 200;
        [_totalAmountLabel.bottom_attr equalTo:self.bottom_attr constant:-SafeAreaBottomHeight];

    }];
    
    //去结算
    _settleAccountsBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settleAccountsBT setTitle:@"去结算" forState:UIControlStateNormal];
    [_settleAccountsBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _settleAccountsBT.backgroundColor = UIColorFromRGB(0x707070);

    [self addSubview:_settleAccountsBT];
    [_settleAccountsBT activateConstraints:^{
        [_settleAccountsBT.right_attr equalTo:self.right_attr constant:0];
        _settleAccountsBT.height_attr.constant = BottomH
        ;
        _settleAccountsBT.width_attr.constant = 110;
        [_settleAccountsBT.bottom_attr equalTo:self.bottom_attr constant:-SafeAreaBottomHeight];
    }];
    
    
}

-(void)setShopModel:(ShopModel *)shopModel{
    
    count = 0;
    for (ProductModel *model in shopModel.goodsList) {
        count = [model.selectCount intValue] + count;
    }
    _settleAccountsBT.enabled = count > 0 ? YES : NO;
    self.settleAccountsBT.backgroundColor = (count == 0 ? UIColorFromRGB(0x707070) : App_Nav_BarDefalutColor);
}

-(void)changeBottomUIWith:(ShopModel *)shopModel{
       NSLog(@"选择商品");
    count = 0;
    totalAmount = 0;
    for (ProductModel *model in shopModel.goodsList) {
        count = [model.selectCount intValue] + count;
        totalAmount = [model.selectCount intValue]*[model.salePrice floatValue]+totalAmount;
        
    }
    self.countLabel.hidden = (count == 0 ? YES : NO);
    self.countLabel.text = [NSString stringWithFormat:@"%d",count];
    
    
    NSString * stringNumber =   [NSString stringWithFormat:@"%f",totalAmount];
    NSNumber * nsNumber = @(stringNumber.floatValue);
    self.totalAmountLabel.text = [NSString stringWithFormat:@"%@",nsNumber];
    
    
    self.settleAccountsBT.backgroundColor = (count == 0 ? UIColorFromRGB(0x707070) : App_Nav_BarDefalutColor);
    self.settleAccountsBT.enabled = (count == 0 ? NO : YES);


    
}


@end
