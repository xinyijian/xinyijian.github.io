//
//  OrderNumberTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderNumberTableViewCell.h"
@interface OrderNumberTableViewCell ()

@end
@implementation OrderNumberTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    _title = [[UILabel alloc]init];
    _title.textColor = TextColor;
    _title.font = fontStely(@"PingFangSC-Regular", 13);
    _title.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_title];
    [_title activateConstraints:^{
        [_title.left_attr equalTo:self.contentView.left_attr constant:15];
        _title.height_attr.constant = 49;
    }];
    
    _defText = [[UILabel alloc] init];
    _defText.textColor = TextGrayColor;
    _defText.font = fontStely(@"PingFangSC-Regular", 13);
    _defText.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_defText];
    [_defText activateConstraints:^{
        [_defText.right_attr equalTo:self.contentView.right_attr constant:-15];
        _defText.height_attr.constant = 49;
    }];
    
    
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
