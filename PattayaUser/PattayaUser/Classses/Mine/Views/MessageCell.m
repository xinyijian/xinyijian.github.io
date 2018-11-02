//
//  MessageCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

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
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    _headImg.image = [UIImage imageNamed:@"shoplist_cell_bg"];
    [_headImg activateConstraints:^{
        [_headImg.left_attr equalTo:self.contentView.left_attr constant:12];
        _headImg.height_attr.constant = 48;
        _headImg.width_attr.constant = 48;
        [_headImg.top_attr equalTo:self.contentView.top_attr constant:20];
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"订单信息";
    _titleLabel.textColor = UIColorFromRGB(0x4a4a4a);
    _titleLabel.font =  K_LABEL_SMALL_FONT_14;
    [_titleLabel sizeToFit];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel activateConstraints:^{
        [_titleLabel.left_attr equalTo:self.headImg.right_attr constant:14];
        _titleLabel.height_attr.constant = 20;
        [_titleLabel.top_attr equalTo:self.contentView.top_attr constant:16];
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"2018.08.31 14:00";
    _timeLabel.textColor = TextGrayColor;
    _timeLabel.font =  K_LABEL_SMALL_FONT_10;
    [_timeLabel sizeToFit];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel activateConstraints:^{
        [_timeLabel.right_attr equalTo:self.contentView.right_attr constant:-12];
        _timeLabel.height_attr.constant = 14;
        _timeLabel.centerY_attr = _titleLabel.centerY_attr;
    }];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.text = @"您预约的【来伊份】（沪A123456）已经出发了，大约25分钟后到达地点。";
    _messageLabel.textColor = UIColorFromRGB(0x4a4a4a);
    _messageLabel.font =  K_LABEL_SMALL_FONT_12;
    _messageLabel.numberOfLines = 0;
    [self.contentView addSubview:_messageLabel];
    [_messageLabel activateConstraints:^{
        [_messageLabel.left_attr equalTo:self.headImg.right_attr constant:14];
        [_messageLabel.right_attr equalTo:self.contentView.right_attr constant:-12];
        [_messageLabel.top_attr equalTo:_titleLabel.bottom_attr constant:2];
        [_messageLabel.bottom_attr equalTo:self.contentView.bottom_attr constant:-20];
    }];
}

-(void)setMessageModel:(PushMessageModel *)messageModel{
    _titleLabel.text = messageModel.title;
    _timeLabel.text = messageModel.lastUpdateDate;
    _messageLabel.text = messageModel.message;
    
}
@end
