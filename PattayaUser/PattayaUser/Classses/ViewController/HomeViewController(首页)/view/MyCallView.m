//
//  MyCallView.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/7.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MyCallView.h"

@implementation MyCallView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    _titleLaber = [[UILabel alloc] init];
    [self addSubview:_titleLaber];
    [_titleLaber activateConstraints:^{
        [_titleLaber.left_attr equalTo:self.left_attr constant:15];
        [_titleLaber.right_attr equalTo:self.right_attr constant:-15];
//        [_titleLaber.top_attr equalTo:self.top_attr constant:17.5];
        [_titleLaber.top_attr equalTo:self.top_attr constant:25];
//        _titleLaber.height_attr.constant = 21;
    }];
    _titleLaber.font = fontStely(@"PingFangSC-Medium", 15);
    _titleLaber.textAlignment = NSTextAlignmentCenter;
//    _titleLaber.text = @"上海市国际大剧院";
    _titleLaber.numberOfLines = 2;
//    _addressLaber = [[UILabel alloc] init];
//    [self addSubview:_addressLaber];
//    [_addressLaber activateConstraints:^{
//        [_addressLaber.left_attr equalTo:self.left_attr];
//        [_addressLaber.right_attr equalTo:self.right_attr];
//        [_addressLaber.top_attr equalTo:_titleLaber.bottom_attr constant:2.5];
//        _addressLaber.height_attr.constant = 18.5;
//    }];
//    _addressLaber.font = fontStely(@"PingFangSC-Regular", 13);
//    _addressLaber.textAlignment = NSTextAlignmentCenter;
//    _addressLaber.textColor = UIColorFromRGB(0x8a8fab);
//    _addressLaber.text = @"上海市黄浦区鲁班路89弄";
//
    _callCarDirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: _callCarDirBtn];
    [_callCarDirBtn activateConstraints:^{
       
        [_callCarDirBtn.left_attr equalTo:self.left_attr constant:20];
        [_callCarDirBtn.right_attr equalTo:self.right_attr constant:-20];
        _callCarDirBtn.height_attr.constant = 40;
        [_callCarDirBtn.bottom_attr equalTo:self.bottom_attr constant:-20];
    }];
    _callCarDirBtn.layer.cornerRadius = 20;
    _callCarDirBtn.backgroundColor = BlueColor;
    [_callCarDirBtn setImage:[UIImage imageNamed:@"icon-呼叫司机"] forState:UIControlStateNormal];
    [_callCarDirBtn setTitle:NSLocalizedString(@"呼叫司机",nil) forState:UIControlStateNormal];
    [_callCarDirBtn addTarget:self action:@selector(callMoblie:) forControlEvents:UIControlEventTouchUpInside];
    _callCarDirBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    _callCarDirBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _callCarDirBtn.adjustsImageWhenHighlighted = NO;
    
}
- (void)callMoblie:(UIButton *)btn
{
    if (_moblieNumber) {
        
        [PattayaTool phoneNumber:_moblieNumber];
        NSLog(@"呼叫司机");
    }
    NSLog(@"司机手机号为空");

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
