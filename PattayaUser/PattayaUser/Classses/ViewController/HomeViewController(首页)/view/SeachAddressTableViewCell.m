//
//  SeachAddressTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "SeachAddressTableViewCell.h"

@implementation SeachAddressTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    _ressName = [[UILabel alloc] init];
    [self.contentView addSubview: _ressName];
    [_ressName activateConstraints:^{
        [_ressName.left_attr equalTo:self.contentView.left_attr constant:15];
        [_ressName.right_attr equalTo:self.contentView.right_attr constant:-15];
        [_ressName.top_attr equalTo:self.contentView.top_attr constant:15];
        [_ressName.bottom_attr equalTo:self.contentView.bottom_attr constant:-36.5];
    }];
    _ressName.font = fontStely(@"PingFangSC-Regular", 13);
    _ressName.textColor = TextColor;
    _ressName.textAlignment = NSTextAlignmentLeft;
    
    _addressDef = [[UILabel alloc] init];
    [self.contentView addSubview:_addressDef];
    
    [_addressDef activateConstraints:^{
        [_addressDef.left_attr equalTo:self.contentView.left_attr constant:15];
        [_addressDef.right_attr equalTo:self.contentView.right_attr constant:-15];
        [_addressDef.top_attr equalTo:self.ressName.bottom_attr constant:3];
        [_addressDef.bottom_attr equalTo:self.contentView.bottom_attr constant:-15];
    }];
    _addressDef.font = fontStely(@"PingFangSC-Regular", 13);
    _addressDef.textColor = UIColorFromRGB(0x8a8fab);
    _addressDef.textAlignment = NSTextAlignmentLeft;
    
    UIView * line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor =UIColorFromRGB(0xf4f4f6);
    [line activateConstraints:^{
        [line.left_attr equalTo:self.contentView.left_attr constant:15];
        [line.right_attr equalTo:self.contentView.right_attr constant:-15];
        [line.top_attr equalTo:self.contentView.bottom_attr constant:-1];
        line.height_attr.constant = 1.0f;
    }];
    
}
- (void)setModel:(AMapPOI *)model
{
    _model = model;
    if (model) {
        _ressName.text = model.name;
        _addressDef.text = model.address;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
