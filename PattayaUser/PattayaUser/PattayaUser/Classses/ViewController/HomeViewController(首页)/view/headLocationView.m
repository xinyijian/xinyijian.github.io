//
//  headLocationView.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "headLocationView.h"
#import "JMButton.h"
#define topHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@implementation headLocationView
{
        UIImageView * seacherImage;
        UIImageView * messagesImage;
        UIScrollView * shopBlackgrouView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI{
    
    
    UIImageView * iocnView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-placeholder"]];
    [self addSubview:iocnView];
    [iocnView activateConstraints:^{
        [iocnView.top_attr equalTo:self.top_attr constant:12 + topHeight];
        [iocnView.left_attr equalTo:self.left_attr constant:15];
        
    }];
    
    _cityText = [[UILabel alloc] init];
    _cityText.font = fontStely(@"PingFangSC-Medium", 13);
    _cityText.textColor = [UIColor whiteColor];
    [self addSubview:_cityText];
    [_cityText activateConstraints:^{
        [_cityText.left_attr equalTo:iocnView.right_attr constant:10.25f];
        _cityText.centerY_attr = iocnView.centerY_attr;
        _cityText.width_attr.constant= (SCREEN_Width / 3.0f) * 2;
    }];
    _cityText.userInteractionEnabled = YES;
    iocnView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tapText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(location:)];
    [_cityText addGestureRecognizer:tapText];
    
    UITapGestureRecognizer * tapimg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(location:)];
    [iocnView addGestureRecognizer:tapimg];
    
    
//    messagesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-bell"]];
////    [self addSubview:messagesImage];
//
//    [messagesImage activateConstraints:^{
//        [messagesImage.top_attr equalTo:self.top_attr constant:13 + topHeight];
//        [messagesImage.left_attr equalTo:self.right_attr constant:-30];
//        messagesImage.height_attr.constant = 15.5f;
//        messagesImage.width_attr.constant = 13.75f;
//    }];
//    messagesImage.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tapMessage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageHid:)];
//    [messagesImage addGestureRecognizer:tapMessage];
//
    
    
    JMBaseButtonConfig *buttonConfig = [JMBaseButtonConfig buttonConfig];
    buttonConfig.backgroundColor = [UIColor clearColor];
    buttonConfig.image = [UIImage imageNamed:@"icon-bell"];
    _btn = [[JMButton alloc] initWithFrame:CGRectMake(SCREEN_Width - 30 , 13 + topHeight, 15.5f, 13.75) ButtonConfig:buttonConfig];
    _btn.badgeSize = CGSizeMake(8, 8);
    _btn.badgeRadius = 4;
    _btn.badgeTextFont = fontStely(@"PingFangSC-Regular", 7);
//    [_btn showNumberBadgeValue:@"1"];
    NSLog(@"%ld",_btn.tag);
//    [_btn addTarget:self action:@selector(messageHid) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn];
    
    UIButton * eidnbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eidnbtn.frame = CGRectMake(SCREEN_Width - 60, topHeight, 60, 60);
    [eidnbtn addTarget:self action:@selector(messageHid) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:eidnbtn];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:searchBtn];
    searchBtn.layer.cornerRadius = 29/2.0f;
    searchBtn.backgroundColor = UIColor.whiteColor;
    searchBtn.userInteractionEnabled = YES;
    [searchBtn activateConstraints:^{
        searchBtn.height_attr.constant = 29;
        [searchBtn.width_attr equalTo:self.width_attr constant:-30];
        [searchBtn.top_attr equalTo:self.top_attr constant:42.5 + topHeight];
        [searchBtn.left_attr equalTo:self.left_attr constant:15];
    }];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchBtn setTitle:@"输入商品名称或关键字" forState:UIControlStateNormal];
    [searchBtn setTitleColor:LineColor forState:UIControlStateNormal];
    [searchBtn addTarget:seacherImage action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
  
}
- (void)imageAction:(UIButton *)tap
{
    [self.DD_delegate ActionSeacherImage];
//    NSLog(@"点击 搜索图片");
}
- (void)messageHid
{
    [self.DD_delegate ActionMessagesImage];
    NSLog(@"显示 '我的召唤'");
}

- (void)location:(UITapGestureRecognizer *)tap
{
    [self.DD_delegate Actionlocation];
    NSLog(@"点击地图");
}
- (void)labelHotText{
    
    CGFloat widthBtn = (SCREEN_Width - 94) / 5.0f;
    
    for (int i = 0;i< _arrayText.count;i++) {
        NSString * textString = _arrayText[i];
        UIButton * btnText = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnText setTitle:textString forState:UIControlStateNormal];
        [btnText setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btnText.backgroundColor = BlueColor;
        btnText.frame = CGRectMake(i * widthBtn + 47, 79.5 + topHeight, widthBtn, 14);
        [self addSubview:btnText];
        btnText.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btnText.titleLabel.font = fontStely(@"PingFangSC-Regular", 10);
        [btnText addTarget:self action:@selector(textAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)setArrayText:(NSMutableArray *)arrayText
{
    _arrayText = arrayText;
    if (arrayText) {
        [self labelHotText];
    }
}

- (void)textAction:(UIButton *)btn
{
    [self.DD_delegate ActionHOTLabel:btn.titleLabel.text];
//    NSLog(@"%@",btn.titleLabel.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
