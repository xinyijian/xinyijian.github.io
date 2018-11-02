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
    
    UILabel *orderLabel = [[UILabel alloc] init];
    orderLabel.text = @"订单信息";
    orderLabel.textColor = UIColorFromRGB(0x4a4a4a);
    orderLabel.font =  K_LABEL_SMALL_FONT_14;
    [orderLabel sizeToFit];
    [self.contentView addSubview:orderLabel];
    [orderLabel activateConstraints:^{
        [orderLabel.left_attr equalTo:self.headImg.right_attr constant:14];
        orderLabel.height_attr.constant = 20;
        [orderLabel.top_attr equalTo:self.contentView.top_attr constant:16];
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
        _timeLabel.centerY_attr = orderLabel.centerY_attr;
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
        [_messageLabel.top_attr equalTo:orderLabel.bottom_attr constant:2];
    }];
}
@end
