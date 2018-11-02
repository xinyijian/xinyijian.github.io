//
//  OrderStoreNameTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderStoreNameTableViewCell.h"

@implementation OrderStoreNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    _storeName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_Width - 30, 49)];
    _storeName.textAlignment = NSTextAlignmentLeft;
    _storeName.textColor = TextColor;
    _storeName.font = fontStely(@"PingFangSC-Medium", 15);
    [self.contentView addSubview:_storeName];
//    _storeName.text = @"宇宙超级无敌购物店";
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
