//
//  DD_Button.m
//  DDKit
//
//  Created by 明克 on 2018/1/25.
//  Copyright © 2018年 明克. All rights reserved.
//
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
#import "DD_Button.h"
@interface DD_Button ()
@property (nonatomic, strong) UIImageView * imageV;
@property (nonatomic,weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) ActionBttonBlock  selectedBlock;
@property (nonatomic,assign) DD_ButtonselectedStyle actionStyle;
@property (nonatomic, assign) BOOL UpInside;
@property (nonatomic, assign) UIColor * oldColor;
@property (nonatomic, assign) ImageTitleStyle  style;


@end
@implementation DD_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _UpInside = YES;
        self.highlightisOn = NO;
        [self addImageTitleView];
        
    }
    return self;
}


- (void)addImageTitleView
{
    _titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _titleLabe.userInteractionEnabled = YES;
    _titleLabe.textAlignment = NSTextAlignmentCenter;
    _titleLabe.font = fontStely(@"PingFangSC-Regular", 11);
    _titleLabe.textColor = TextColor;
    [self addSubview:_titleLabe];
}
//目标动作回调
-(void)addTarget:(id)target action:(SEL)action eventTouch:(DD_ButtonselectedStyle)style
{
    _actionStyle = style;
    if (_actionStyle == DD_ButtonEventTouchUpOutside) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 1.8; //定义按的时间
        [self addGestureRecognizer:longPress];
      
    }
    self.target = target;
    self.action = action;
}

///长按 执行方法
- (void)btnLong:(UILongPressGestureRecognizer *)gesture
{
   
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        [self selectedTargetOrBlock];
        self.highlighted = NO;

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    NSLog(@"%d",self.highlighted);
    [self highlightView];
}
//当button点击结束时，如果结束点在button区域中执行action方法
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    NSLog(@"%d",self.highlighted);

    if (_actionStyle == DD_ButtonEventTouchUpInside) {
        
    //获取触摸对象
    UITouch *touche = [touches anyObject];
    //获取touche的位置
    CGPoint point = [touche locationInView:self];
    //判断点是否在button中
    if (CGRectContainsPoint(self.bounds, point))
    {
        [self selectedTargetOrBlock];
    }
        
  }///长按 中途离开按钮 --- 暂时不做处理
    else if (_actionStyle == DD_ButtonEventTouchUpOutside)
  {
      self.highlighted = NO;
  }
    [self highlightView];

}

- (void)setHighlighted:(BOOL)highlighted
{
    NSLog(@"hig = %d",highlighted);
    if (!self.highlightisOn) {
    if (highlighted) {
        _oldColor = self.backgroundColor;
        
   self.layer.backgroundColor = _highlightColor.CGColor ? _highlightColor.CGColor : [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5].CGColor;
    } else
    {
        self.layer.backgroundColor = _oldColor.CGColor;
    }
    }
}

- (void)highlightView
{
    if (self.highlightisOn) {
        
    if (_UpInside) {
        [UIView animateWithDuration:1 animations:^{
            _oldColor = self.backgroundColor;
            self.layer.backgroundColor = _highlightColor.CGColor ? _highlightColor.CGColor : UIColor.darkGrayColor.CGColor;
        }];
        _UpInside = NO;
    } else
    {
        [self.layer removeAllAnimations];
        [UIView animateWithDuration:1 animations:^{
            self.layer.backgroundColor = _oldColor.CGColor;
        }];
        _UpInside = YES;
    }
        
    }
}

- (void)selectedTargetOrBlock
{
    if (self.target && self.action) {
        //执行action
        SuppressPerformSelectorLeakWarning(
                                           [self.target performSelector:self.action withObject:self]
                                           );
        return;
    }
    if (self.selectedBlock) {
        self.selectedBlock(self);
    }
}

- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    [_imageV removeFromSuperview];
    _imageV = nil;
    _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
    _imageV.userInteractionEnabled = YES;
    [self addSubview:_imageV];
    if (_titleString) {
        
        [self layoutImageToLabel];
    } else
    {
        CGFloat imageWH = [self imageWinthHeight];
        _imageV.frame = CGRectMake(0, 0, imageWH, imageWH);
        _imageV.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    }
    
    
    
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    _titleLabe.text = titleString;
    [_titleLabe sizeToFit];
    if (CGRectGetWidth(_titleLabe.frame) > CGRectGetWidth(self.bounds)) {
        _titleLabe.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) - 10, _titleLabe.frame.size.height);
    }
    _titleLabe.center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
}

- (void)layoutImageToLabel
{
    ///默认 图片在左边
    [self imageTitleStyle:imageLeft];
}

- (void)imageTitleStyle:(ImageTitleStyle)style
{
    _style = style;
    [self imageOutside];
    if (style == imageTop) {
        
        [self imageTopWithRect];
        
    } else if (style == imageRight)
    {
        [self imageRightWithRect];

    } else if (style == imageLeft)
    {
        [self imageLeftWithRect];

    } else if (style == imageBottom)
    {
        [self imageBottomWithRect];
    } else
    {
        [self imageLeftWithRect];

    }
}

- (void)imageOutside
{
    CGFloat imageWH = [self imageWinthHeight];
    CGFloat textX = self.bounds.size.width / 2.0f - [self titleWinthXRight];

    if (imageWH + textX > CGRectGetWidth(self.bounds))
    {
        CGRect  rect = CGRectMake(0, 0, imageWH, imageWH);
        _imageV.frame = rect;
        _imageV.center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
//        return CGRectGetWidth(self.bounds);
        return;
    }
    
}

///图片在下边
- (void)imageBottomWithRect
{
    CGFloat imageWH = [self imageWinthHeight] / 2.0f;
    CGFloat imageX = self.bounds.size.width / 2.0f - imageWH / 2.0f;
    CGFloat inteval = (CGRectGetHeight(self.bounds) / 2 - imageWH) / 2;
    CGRect  rect = CGRectMake(imageX, inteval + CGRectGetHeight(self.bounds) / 2, imageWH, imageWH);
    _imageV.frame = rect;
    CGFloat textX = self.bounds.size.width / 2.0f - self.titleLabe.frame.size.width / 2.0f;
    [_titleLabe sizeToFit];
    if (CGRectGetWidth(_titleLabe.frame) > CGRectGetWidth(self.bounds)) {
        _titleLabe.frame = CGRectMake(5, 0, CGRectGetWidth(self.bounds) - 10, self.bounds.size.height / 2.0f);
    } else
    {
        _titleLabe.frame = CGRectMake(textX, 0, _titleLabe.frame.size.width, self.bounds.size.height / 2.0f);
        CGPoint centers = _titleLabe.center;
        centers.x = self.frame.size.width / 2.0f;
        _titleLabe.center = centers;
    }
}

///图片在上边
- (void)imageTopWithRect
{
    CGFloat imageWH = [self imageWinthHeight] / 2.0f;
    CGFloat imageX = self.bounds.size.width / 2.0f - imageWH / 2.0f;
    CGFloat inteval = (CGRectGetHeight(self.bounds) / 2 - imageWH) / 2;
    CGRect  rect = CGRectMake(imageX, inteval, imageWH, imageWH);
    _imageV.frame = rect;
    CGFloat textX = self.bounds.size.width / 2.0f - self.titleLabe.frame.size.width / 2.0f;
    [_titleLabe sizeToFit];
    if (CGRectGetWidth(_titleLabe.frame) > CGRectGetWidth(self.bounds)) {
        _titleLabe.frame = CGRectMake(5,  CGRectGetHeight(self.bounds) / 2, CGRectGetWidth(self.bounds) - 10, self.bounds.size.height / 2.0f);
    } else
    {
        CGRect  titlerect = CGRectMake(textX, CGRectGetHeight(self.bounds) / 2, _titleLabe.frame.size.width, self.bounds.size.height / 2.0f);

        _titleLabe.frame = titlerect;
        CGPoint centers = _titleLabe.center;
        centers.x = self.frame.size.width / 2.0f;
        _titleLabe.center = centers;
        
    }
    
}


///图片在左边
- (void)imageLeftWithRect
{
    CGFloat imageWH = [self imageWinthHeight];
    CGFloat textX = self.bounds.size.width / 2.0f - [self titleWinthXRight];
    CGFloat inteval = (CGRectGetHeight(self.bounds)-imageWH)/2;
    CGRect  rect = CGRectMake(textX, inteval, imageWH, imageWH);
    _imageV.frame = rect;
    _titleLabe.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame), 0, _titleLabe.frame.size.width, self.bounds.size.height);
}

///图片在右边
- (void)imageRightWithRect
{
    CGFloat imageWH = [self imageWinthHeight];
    CGFloat textX = self.bounds.size.width / 2.0f - [self titleWinthXRight];
     CGRect rectLabe = CGRectMake(textX, 0, _titleLabe.frame.size.width, self.bounds.size.height);
    _titleLabe.frame = rectLabe;
    CGFloat inteval = (CGRectGetHeight(self.bounds)-imageWH)/2;
    CGRect  rect = CGRectMake(CGRectGetMaxX(self.titleLabe.frame), inteval, imageWH, imageWH);
    _imageV.frame = rect;
}

///计算x起始点
- (CGFloat)titleWinthXRight
{
    CGFloat labex = (CGRectGetWidth(self.titleLabe.frame) + [self imageWinthHeight]) / 2.0f;

    if (CGRectGetWidth(self.titleLabe.frame) + CGRectGetWidth(self.imageV.frame) > CGRectGetWidth(self.bounds)) { // 当标题和图片宽度超过按钮宽度时不能越界
        self.titleLabe.frame = CGRectMake(self.titleLabe.frame.origin.x, self.titleLabe.frame.origin.y, CGRectGetWidth(self.bounds) - CGRectGetWidth(self.imageV.frame), self.titleLabe.frame.size.height);
        labex = CGRectGetWidth(self.bounds) / 2 - 10;
        return labex;
    }
    return  labex;
}
///计算图片大小
- (CGFloat)imageWinthHeight
{
    if ( CGRectGetHeight(self.imageV.frame) > CGRectGetHeight(self.bounds) &&  CGRectGetWidth(self.imageV.frame) > CGRectGetWidth(self.bounds)) { // 当标题和图片宽度超过按钮宽度时不能越界
        return   CGRectGetHeight(self.bounds);
    } else if (CGRectGetWidth(self.imageV.frame) > CGRectGetWidth(self.bounds))
    {
        return CGRectGetWidth(self.bounds);
    } else if (CGRectGetHeight(self.imageV.frame) > CGRectGetHeight(self.bounds))
    {
        return   CGRectGetHeight(self.bounds);
    }
    return CGRectGetHeight(self.imageV.frame);
}

///不用tagger 也可以用block
- (void)buttonActionBlock:(ActionBttonBlock)selected
{
    self.selectedBlock = selected;
}


- (void)setTitleLabe:(NSString *)titleLabe event:(DD_ButtonHighlightStyle)style
{
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
