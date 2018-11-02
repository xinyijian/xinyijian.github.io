//
//  LoacationTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "LoacationTableViewCell.h"

@implementation LoacationTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    _loaction = [[UILabel alloc]init];
    [self.contentView addSubview:_loaction];
    [_loaction activateConstraints:^{
        [_loaction.left_attr equalTo:self.contentView.left_attr constant:15];
        _loaction.height_attr.constant = 60;
    }];
    _loaction.textColor = TextColor;
    _loaction.font = fontStely(@"PingFangSC-Regular", 13);
    _loaction.textAlignment = NSTextAlignmentLeft;
//    _loaction.text = NSLocalizedString(@"百脑通数码城",nil);
    
    _refreshLoaction = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview: _refreshLoaction];
    [_refreshLoaction activateConstraints:^{
        [_refreshLoaction.right_attr equalTo:self.contentView.right_attr constant:-15];
        _refreshLoaction.height_attr.constant = 60;
        
    }];
    [_refreshLoaction setTitle:NSLocalizedString(@"重新定位",nil) forState:UIControlStateNormal];
    [_refreshLoaction setTitleColor:BlueColor forState:UIControlStateNormal];
    _refreshLoaction.titleLabel.font = fontStely(@"PingFangSC-Regular", 13);
    [_refreshLoaction addTarget:self action:@selector(refreshLocation) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
- (void)refreshLocation
{
    BLOCK_EXEC(_refreshBlcok);
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
