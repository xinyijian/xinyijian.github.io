//
//  AddressListCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell

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
    _addressLabel = [[UILabel alloc] init];
    [self.contentView addSubview: _addressLabel];
    [_addressLabel activateConstraints:^{
        [_addressLabel.top_attr equalTo:self.contentView.top_attr constant:10];
        [_addressLabel.left_attr equalTo:self.contentView.left_attr constant:12];
        _addressLabel.height_attr.constant = 22;
    }];
    [_addressLabel sizeToFit];
    _addressLabel.font = fontStely(@"PingFangSC-Regular", 16);
    _addressLabel.textColor = TextColor;
    _addressLabel.text = @"缤谷大厦";
    
    _subAddressLabel = [[UILabel alloc] init];
    [self.contentView addSubview: _subAddressLabel];
    [_subAddressLabel activateConstraints:^{
        [_subAddressLabel.top_attr equalTo:_addressLabel.bottom_attr constant:8];
        [_subAddressLabel.left_attr equalTo:self.contentView.left_attr constant:12];
        _subAddressLabel.height_attr.constant = 20;
    }];
    [_subAddressLabel sizeToFit];
    _subAddressLabel.font = fontStely(@"PingFangSC-Regular", 14);
    _subAddressLabel.textColor = TextColor;
    _subAddressLabel.text = @"11楼 前台";
    
    
    _userNameMobl = [[UILabel alloc]init];
    [self.contentView addSubview:_userNameMobl];
    [_userNameMobl activateConstraints:^{
        [_userNameMobl.top_attr equalTo:_subAddressLabel.bottom_attr constant:10];
        [_userNameMobl.left_attr equalTo:self.contentView.left_attr constant:12];
        _userNameMobl.height_attr.constant = 20;
        
    }];
    [_userNameMobl sizeToFit];
    _userNameMobl.font = fontStely(@"PingFangSC-Regular", 14);
    _userNameMobl.textColor = TextGrayColor;
    _userNameMobl.text = @"闻（女士）15083958903";
    
    //编辑按钮
    _editBT = [[UIImageView alloc]init];
    _editBT.image = [UIImage imageNamed:@"btn_edit"];
    _editBT.userInteractionEnabled = YES;
    [self.contentView addSubview:_editBT];
    [_editBT activateConstraints:^{
        [_editBT.right_attr equalTo:self.contentView.right_attr constant:-12];
        _editBT.centerY_attr = _subAddressLabel.centerY_attr;
        _editBT.height_attr.constant = 20;
        _editBT.width_attr.constant = 20;
    }];
    
    _addressTypeImg = [[UIImageView alloc]init];
    _addressTypeImg.image = [UIImage imageNamed:@"address_type2"];
    [self.contentView addSubview:_addressTypeImg];
    [_addressTypeImg activateConstraints:^{
        [_addressTypeImg.left_attr equalTo:_addressLabel.right_attr constant:7];
        _addressTypeImg.centerY_attr = _addressLabel.centerY_attr;
        _addressTypeImg.height_attr.constant = 16;
        _addressTypeImg.width_attr.constant = 30;
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AddressModel *)model
{
    _model = model;
    if (model) {
        _addressLabel.text = model.formattedAddress;
        _subAddressLabel.text = model.houseNumber;
        _userNameMobl.text = [NSString stringWithFormat:@"%@ %@",model.contactName,model.contactMobile];
        if ([model.tagAlias isEqualToString:@"家"]) {
            _addressTypeImg.image = [UIImage imageNamed:@"address_type1"];
        }else if ([model.tagAlias isEqualToString:@"公司"]) {
            _addressTypeImg.image = [UIImage imageNamed:@"address_type2"];
        }else if ([model.tagAlias isEqualToString:@"学校"]) {
            _addressTypeImg.image = [UIImage imageNamed:@"address_type3"];
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
