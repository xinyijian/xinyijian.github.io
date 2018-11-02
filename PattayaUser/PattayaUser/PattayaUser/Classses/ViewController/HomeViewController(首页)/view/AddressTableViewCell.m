//
//  AddressTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell
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
    _addName = [[UILabel alloc] init];
    [self.contentView addSubview: _addName];
    _addName.numberOfLines = 3;;
    [_addName activateConstraints:^{
        [_addName.top_attr equalTo:self.contentView.top_attr constant:18];
        [_addName.left_attr equalTo:self.contentView.left_attr constant:15];
        _addName.width_attr.constant = 34;
    }];
    _addName.font = fontStely(@"PingFangSC-Regular", 10);
    _addName.textColor = BlueColor;
    _addName.textAlignment = NSTextAlignmentCenter;
    _addName.layer.borderColor = BlueColor.CGColor;
    _addName.layer.borderWidth = 0.5f;
    _addName.layer.cornerRadius = 5;
    
    _address = [[UILabel alloc] init];
    [self.contentView addSubview:_address];
    _address.numberOfLines = 2;
    [_address activateConstraints:^{
        [_address.left_attr equalTo:_addName.right_attr constant:7.5];
        [_address.top_attr equalTo:self.contentView.top_attr constant:15];
        [_address.right_attr equalTo:self.contentView.right_attr constant:-15];
    }];
    _address.font = fontStely(@"PingFangSC-Regular", 13);
    _address.textColor = TextColor;
    _address.textAlignment = NSTextAlignmentLeft;
    
    
    _userNameMobl = [[UILabel alloc]init];
    [self.contentView addSubview:_userNameMobl];
    [_userNameMobl activateConstraints:^{
        _userNameMobl.left_attr = _address.left_attr;
        _userNameMobl.right_attr = _address.right_attr;
        _userNameMobl.height_attr.constant = 18.5;
        [_userNameMobl.top_attr equalTo:_address.bottom_attr constant:1.5];
        
    }];
    _userNameMobl.font = fontStely(@"PingFangSC-Regular", 13);
    _userNameMobl.textColor = UIColorFromRGB(0x8a8fab);
    _userNameMobl.textAlignment = NSTextAlignmentLeft;
    
    UIView * line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    [line activateConstraints:^{
        [line.top_attr equalTo:self.contentView.bottom_attr constant:-1];
        [line.left_attr equalTo:self.contentView.left_attr constant:15];
        [line.right_attr equalTo:self.contentView.right_attr constant:-15];
        line.height_attr.constant = 1.0f;
    }];
    line.backgroundColor = UIColorFromRGB(0xf4f4f6);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AddressModel *)model
{
    _model = model;
    if (model) {
        _addName.text = model.tagAlias;
        _address.text = model.formattedAddress;
        _userNameMobl.text = [NSString stringWithFormat:@"%@ %@",model.contactName,model.contactMobile];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
