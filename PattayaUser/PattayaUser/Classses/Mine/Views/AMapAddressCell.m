//
//  AMapAddressCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AMapAddressCell.h"

@implementation AMapAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI
{
    
    _locationImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_locationImg];
    _locationImg.image = [UIImage imageNamed:@"icon_location"];
    [_locationImg activateConstraints:^{
        [_locationImg.left_attr equalTo:self.contentView.left_attr constant:12];
        _locationImg.height_attr.constant = 15;
        _locationImg.width_attr.constant = 12;
        [_locationImg.top_attr equalTo:self.contentView.top_attr constant:20];
    }];
    
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.text = @"深兰人工智能大厦";
    _locationLabel.textColor =App_Nav_BarDefalutColor;
    _locationLabel.font =  K_LABEL_SMALL_FONT_16;
    [_locationLabel sizeToFit];
    [self.contentView addSubview:_locationLabel];
    [_locationLabel activateConstraints:^{
        [_locationLabel.left_attr equalTo:self.locationImg.right_attr constant:20];
        _locationLabel.height_attr.constant = 22;
        [_locationLabel.top_attr equalTo:self.contentView.top_attr constant:7];
    }];
    
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.text = @"深兰人工智能大厦";
    _numberLabel.textColor =TextGrayColor;
    _numberLabel.font =  K_LABEL_SMALL_FONT_12;
    [_numberLabel sizeToFit];
    [self.contentView addSubview:_numberLabel];
    [_numberLabel activateConstraints:^{
        [_numberLabel.left_attr equalTo:self.locationImg.right_attr constant:20];
        _numberLabel.height_attr.constant = 17;
        [_numberLabel.top_attr equalTo:self.locationImg.bottom_attr constant:3];
    }];

}
    
@end
