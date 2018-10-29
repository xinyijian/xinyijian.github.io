//
//  newsreelView.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "newsreelView.h"
@interface newsreelView ()
//删除按钮
@property (nonatomic, strong) UIButton * deleteBT;
@property (nonatomic, strong) UILabel * titleNewSreel;
@property (nonatomic, strong) UILabel * titleHot;
@property (nonatomic, strong) NSMutableArray * SreelArray;
@property (nonatomic, assign) CGFloat hotViewTop;


@end
@implementation newsreelView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self SreelLoad];
    }
    
    return self;
}
- (void)initUI{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _titleNewSreel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleNewSreel.font = K_LABEL_SMALL_FONT_16;
    _titleNewSreel.textColor = TextColor;
    [self addSubview:_titleNewSreel];
    
    _deleteBT = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBT.frame = CGRectZero;
    [_deleteBT addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBT setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_deleteBT setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateSelected];
    [self addSubview:_deleteBT];
    
    _titleHot = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleHot.font = K_LABEL_SMALL_FONT_16;
    _titleHot.textColor = TextColor;
    [self addSubview:_titleHot];
    _hotViewTop = 20;
}

-(void)deleteClick{
   
    NSMutableArray *searTXT = [NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"myArray"];
    
    [self initUI];
    [self SreelLoad];
    [self setArrayHotText:self.arrayHotText];
}
- (void)SreelLoad
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    _SreelArray = [NSMutableArray array];
    _SreelArray = [myArray mutableCopy];
    
    if (_SreelArray.count > 0) {
        _titleNewSreel.frame = CGRectMake(12,20, 100, 22);
        _deleteBT.frame = CGRectMake(SCREEN_Width - 12 - 14,24, 14, 14);
        //[_titleNewSreel sizeToFit];
        _titleNewSreel.text = NSLocalizedString(@"历史搜索",nil);
        [self needTitle:_SreelArray bottom:_titleNewSreel.bottomBee + 10];
    }
}


- (void)needTitle:(NSMutableArray *)array bottom:(CGFloat)laberHeight
{
    CGFloat witd = 0;
    CGFloat laberY = 0;
    CGFloat laberWitd = 0;
    for (int i = 0; i < array.count; i++) {
        NSString * string = array[i];
        UILabel * text = [[UILabel alloc] init];
        text.text = string;
        text.textAlignment = NSTextAlignmentCenter;
        text.font = fontStely(@"PingFangSC-Regular", 13);
        [text sizeToFit];
        text.layer.masksToBounds = YES;
        text.layer.cornerRadius = 2.0f;
        text.textColor = UIColorFromRGB(0x4a4a4a);
        text.backgroundColor = UIColorFromRGB(0xF5F5F5);
        NSLog(@"text.widthBee = %f",text.widthBee);
        witd = text.widthBee + 12 + laberWitd;
        NSLog(@"%f,---- %f",witd,SCREEN_Width - 12*2);
        if (SCREEN_Width - 12*2 < witd) {
            laberY++;
            laberWitd = 0;
            witd = 0;
        }
        text.frame = CGRectMake(12 + laberWitd , laberHeight + (15 * laberY + 32 * laberY), text.widthBee + 12, 32);
        [self addSubview:text];
        text.tag = i + 200000;
        text.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionText:)];
        [text addGestureRecognizer:tap];
        laberWitd += text.widthBee + 12;
        if (array.count-1 == i) {
            _hotViewTop = text.bottomBee + 20;
           // _hotViewTop = (15 * laberY + 22 * laberY) + 110;
        }
    }
    
}



- (void)setArrayHotText:(NSMutableArray *)arrayHotText
{
    _arrayHotText = arrayHotText;
    ///如果历史纪录 有的话 在历史纪录下面 根据个数创建 算好高度
    ///如果没有历史纪录 就直接在最上面创建;
    if (arrayHotText.count > 0) {
        if (_SreelArray.count > 0) {
            _titleHot.text = NSLocalizedString(@"热门搜索",nil);
            _titleHot.frame = CGRectMake(12,_hotViewTop, 100, 22);
            [self needTitle:arrayHotText bottom:_titleHot.bottomBee + 10];
        } else
        {
            _titleHot.frame = CGRectMake(12,11, 100, 22);
            _titleHot.text = NSLocalizedString(@"热门搜索",nil);
            [self needTitle:arrayHotText bottom:_titleHot.bottomBee + 10];
        }
      
    }
}

- (void)actionText:(UITapGestureRecognizer *)tap
{
    UILabel * laber = (UILabel*)tap.view;
    NSLog(@"%@===%ld",laber.text,laber.tag - 200000);
    BLOCK_EXEC(_hotBlcok,laber.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
