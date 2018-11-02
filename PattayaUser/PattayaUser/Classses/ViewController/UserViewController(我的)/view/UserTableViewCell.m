//
//  UserTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "UserTableViewCell.h"
@interface UserTableViewCell ()
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIImageView * img;

@end
@implementation UserTableViewCell
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
    [self.contentView addSubview: _title];
    [_title activateConstraints:^{
        [_title.left_attr equalTo:self.contentView.left_attr constant:15];
        [_title.height_attr equalTo:self.contentView.height_attr];
        _title.width_attr.constant = SCREEN_Width / 2.0f;
    }];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = fontStely(@"PingFangSC-Regular", 14);
    _title.textColor = TextColor;
    
    _img = [[UIImageView alloc] init];
    [self.contentView addSubview:_img];
    [_img activateConstraints:^{
        [_img.centerY_attr equalTo:self.contentView.centerY_attr];
        _img.height_attr.constant = 11;
        _img.width_attr.constant = 6.5;
        [_img.right_attr equalTo:self.contentView.right_attr constant:-16];
    }];
    _img.image = [UIImage imageNamed:@"Imported Layers Copy"];
//    _img.backgroundColor = [UIColor cyanColor];
    
    UIView * line = [[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [line activateConstraints:^{
       
        [line.left_attr equalTo:self.contentView.left_attr constant:15];
        [line.right_attr equalTo:self.contentView.right_attr constant:-15];
        [line.bottom_attr equalTo:self.contentView.bottom_attr constant:-1.5];
        line.height_attr.constant = 1.5f;
        
    }];
    
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    if (titleText) {
        _title.text = titleText;
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
