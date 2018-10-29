//
//  PaymentDetailCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentDetailCell.h"

@implementation PaymentDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.backgroundColor = App_TotalGrayWhite;
    }
    
    return self;
}

- (void)initUI{
    
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = UIColorWhite;
    [self.contentView addSubview:bgView];
    [bgView activateConstraints:^{
        [bgView.top_attr equalTo:self.contentView.top_attr constant:1];
        [bgView.left_attr equalTo:self.contentView.left_attr constant:IPhone_7_Scale_Width(8)];
        [bgView.right_attr equalTo:self.contentView.right_attr constant:IPhone_7_Scale_Width(-8)];
        [bgView.bottom_attr equalTo:self.contentView.bottom_attr constant:IPhone_7_Scale_Width(0)];

    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"订单编号";
    _titleLabel.font = K_LABEL_SMALL_FONT_14;
    _titleLabel.textColor = TextColor;
    [_titleLabel sizeToFit];
    [bgView addSubview:_titleLabel];
    [_titleLabel activateConstraints:^{
        [_titleLabel.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(12)];
        _titleLabel.height_attr.constant = 22;
        _titleLabel.centerY_attr = bgView.centerY_attr;
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.text = @"#20188907777";
    _detailLabel.font = K_LABEL_SMALL_FONT_14;
    _detailLabel.textColor = TextColor;
    [_detailLabel sizeToFit];
    [bgView addSubview:_detailLabel];
    [_detailLabel activateConstraints:^{
        [_detailLabel.right_attr equalTo:bgView.right_attr constant:IPhone_7_Scale_Width(-12)];
        _detailLabel.height_attr.constant = 22;
        _detailLabel.centerY_attr = bgView.centerY_attr;
    }];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title) {
        _titleLabel.text = title;
        
    }
}

- (void)setDetailTitle:(NSString *)DetailTitle{
    _DetailTitle = DetailTitle;
    if (_DetailTitle) {
        _detailLabel.text = _DetailTitle;

    }
}


@end
