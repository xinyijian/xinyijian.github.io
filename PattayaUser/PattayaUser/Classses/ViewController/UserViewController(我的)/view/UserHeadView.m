//
//  UserHeadView.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "UserHeadView.h"
@interface UserHeadView ()

@end
@implementation UserHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headinit];
    }
    
    return self;
}
- (void)headinit{
    
    
    UIImageView * backgroud = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    [self addSubview:backgroud];
    
    _userImg = [[UIImageView alloc] init];
    [self addSubview:_userImg];
    _userImg.userInteractionEnabled = YES;
    [_userImg activateConstraints:^{
        [_userImg.top_attr equalTo:self.top_attr constant:40];
        _userImg.height_attr.constant = 71;
        _userImg.width_attr.constant = 71;
        [_userImg.centerX_attr equalTo:self.centerX_attr];
    }];
    
    
    _userImg.layer.cornerRadius = 35.5f;
    _userImg.layer.masksToBounds = YES;
    _userName =[[UILabel alloc] init];
    [self addSubview:_userName];
    
    [_userName activateConstraints:^{
        [_userName.top_attr equalTo:_userImg.bottom_attr constant:12.5];
        [_userName.width_attr equalTo:self.width_attr];
        _userName.height_attr.constant = 20;
        [_userName.left_attr equalTo:self.left_attr];
    }];
    _userName.text = NSLocalizedString(@"用户名",nil);
    _userName.font = fontStely(@"PingFangSC-Medium", 14);
    _userName.textColor = TextColor;
    _userName.textAlignment = NSTextAlignmentCenter;
    
    
    _userMobil =[[UILabel alloc] init];
    [self addSubview:_userMobil];
    
    [_userMobil activateConstraints:^{
        [_userMobil.top_attr equalTo:_userName.bottom_attr constant:2.5];
        [_userMobil.width_attr equalTo:self.width_attr];
        _userMobil.height_attr.constant = 16.5;
        [_userMobil.left_attr equalTo:self.left_attr];
    }];
    _userMobil.text = NSLocalizedString(@"电话号码",nil);
    _userMobil.font = fontStely(@"PingFangSC-Regular", 12);
    _userMobil.textColor = TextColor;
    _userMobil.textAlignment = NSTextAlignmentCenter;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
