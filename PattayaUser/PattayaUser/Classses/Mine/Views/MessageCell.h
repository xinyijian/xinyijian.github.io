//
//  MessageCell.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushMessageModel.h"

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headImg;
@property (nonatomic, strong) UILabel * titleLabel;//时间
@property (nonatomic, strong) UILabel * timeLabel;//时间
@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) PushMessageModel * messageModel;


@end
