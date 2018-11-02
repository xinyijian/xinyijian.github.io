//
//  CarDetailsTitleTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "CarDetailsTitleTableViewCell.h"

@implementation CarDetailsTitleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    UILabel * labe = [[UILabel alloc] init];
    [self.contentView addSubview:labe];
    [labe activateConstraints:^{
        labe.top_attr = self.contentView.top_attr;
        labe.left_attr = self.contentView.left_attr;
        labe.right_attr = self.contentView.right_attr;
        labe.height_attr = self.contentView.height_attr;
    }];
    labe.text = NSLocalizedString(@"商品种类",nil);
    labe.font = fontStely(@"PingFangSC-Medium", 16);
    labe.textColor = TextColor;
    labe.textAlignment = NSTextAlignmentCenter;
    
    
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
