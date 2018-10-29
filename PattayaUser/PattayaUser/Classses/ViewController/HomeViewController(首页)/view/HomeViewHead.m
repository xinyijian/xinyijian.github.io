//
//  HomeViewHead.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/30.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "HomeViewHead.h"
#import "DD_Button.h"
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>
#import "headLocationView.h"
#import <UIButton+WebCache.h>
#import "ConditionQueryView.h"
#define topHeight [[UIApplication sharedApplication] statusBarFrame].size.height
@interface HomeViewHead ()<BHInfiniteScrollViewDelegate,headLocationViewDelegate>
{
    UILabel * nearText;
    ConditionQueryView * hotview;
}
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
@property (nonatomic, strong) UIButton * tmpBtn;
@property (nonatomic, strong) UIView * lineBottom;

@end
@implementation HomeViewHead
{
    UIImageView * seacherImage;
    UILabel * cityText;
    UIImageView * messagesImage;
    UIView * blackgrouView;
    UIScrollView * shopBlackgrouView;
    headLocationView * navigationView;

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
    
    [self locationView];
    
}

- (void)reloadInfiniteScrollview
{
    [_infinitePageView removeFromSuperview];
    _infinitePageView = nil;
    [navigationView removeFromSuperview];
    navigationView = nil;
    [nearText removeFromSuperview];
    nearText = nil;
    [hotview removeFromSuperview];
    hotview = nil;
    [self ScrollViewPageControl];
    [self locationView];
    [self nearCarInit];
}

- (void)ScrollViewPageControl
{
    CGFloat infiniteX;
    if (shopBlackgrouView) {
        infiniteX =  109 + [[UIApplication sharedApplication] statusBarFrame].size.height + 87;
    } else
    {
        infiniteX =  109 + [[UIApplication sharedApplication] statusBarFrame].size.height + 20;

    }
    if (!_infinitePageView) {
 
    _infinitePageView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(15, infiniteX, SCREEN_Width - 30, 109) Delegate:self ImagesArray:self.arrayImage];
    _infinitePageView.dotSize = 4;
    _infinitePageView.dotSpacing = 6.0f;
    _infinitePageView.pageControlAlignmentOffset = CGSizeMake(0, 2.5);
    _infinitePageView.titleView.textColor = UIColorFromRGB(0xD8D8D8);
    _infinitePageView.selectedDotColor = [UIColor clearColor];
    _infinitePageView.titleView.hidden = NO;
    _infinitePageView.scrollTimeInterval = _duration.integerValue;
    _infinitePageView.autoScrollToNextPage = YES;
    _infinitePageView.delegate = self;
    _infinitePageView.placeholderImage = [UIImage imageNamed:@"广告占位图"];
    [self addSubview:_infinitePageView];
    }
    [self nearCarInit];
        
}

- (void)nearCarInit{
    if (!nearText) {
    nearText = [[UILabel alloc] initWithFrame:CGRectMake(0, _infinitePageView.bottomBee + 20, 80, 22.5)];
    nearText.text = NSLocalizedString(@"附近购物车",nil);
    nearText.font = fontStely(@"PingFangSC-Medium", 16);
    nearText.textColor = TextColor;
    nearText.centerX = SCREEN_Width / 2.0f;
    [self addSubview:nearText];
    WS(weakSelf);
    ConditionQueryView * hotview = [[ConditionQueryView alloc] initWithFrame:CGRectMake(0, nearText.bottomBee + 10, 273, 30)];
    hotview.clickBlock = ^(NSInteger tag) {
        [weakSelf.homeDelegate ActionConditionQueryBtn:tag];
    };
    [self addSubview:hotview];
        
    }
}

- (UIButton *)initbuttonStyeframe:(CGRect)frame font:(UIFont *)font text:(NSString *)title
{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:TextColor forState:UIControlStateSelected];
    [btn setTitleColor:UIColorFromRGB(0xC2C6DA) forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)actionBtn:(UIButton *)btn
{
 if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
     [self animateWithBtn:_tmpBtn];
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
    }else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [self animateWithBtnDidcompletion:_tmpBtn];
        btn.selected = YES;
        [self animateWithBtn:btn];

        _tmpBtn = btn;
    }
    
   
}

- (void)animateWithBtn:(UIButton *)btn
{
    [UIView animateWithDuration:0.2  animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        btn.transform = transform;
        _lineBottom.centerX = btn.centerX;

        
    } completion:nil];
}
- (void)animateWithBtnDidcompletion:(UIButton *)btn
{
    [UIView animateWithDuration:0.2  animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        
        btn.transform = transform;
        
    } completion:nil];
}



- (void)shopTpye
{
    if (!shopBlackgrouView) {

//    NSArray * ar = @[@"零食",@"水果",@"蔬菜",@"理发",@"配镜",@"零食",@"水果",@"蔬菜",@"理发",@"配镜",];
    CGFloat widthShop = (_catayerText.count / 5) * SCREEN_Width;
    shopBlackgrouView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationView.bottomBee, SCREEN_Width, 87)];
    
   
    shopBlackgrouView.contentSize = CGSizeMake(widthShop, 0);
    shopBlackgrouView.backgroundColor = [UIColor whiteColor];
    shopBlackgrouView.scrollEnabled = YES;
    shopBlackgrouView.pagingEnabled = YES;
    [self addSubview:shopBlackgrouView];
    CGFloat widtBtn = widthShop / _catayerText.count;
    for (int i = 0; i < _catayerText.count; i++) {

        UIView * iamgeBtn = [self imageAttContentMode:_catayerImage[i] frame:CGRectMake(i * widtBtn , 0, widtBtn, 86.5) title:_catayerText[i]];
        [shopBlackgrouView addSubview:iamgeBtn];
        iamgeBtn.tag = i + 100000;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
        [iamgeBtn addGestureRecognizer:tap];
    }
//        UIImageView * images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widtBtn - 30, widtBtn - 30)];
//        [shopBlackgrouView addSubview:images];
//        images.image = [UIImage imageNamed:_catayerImage[0]];
//        images.contentMode = UIViewContentModeScaleAspectFit;
//        [images sd_setImageWithURL:[NSURL URLWithString:_catayerImage[0]]];
        
    }
}

- (UIView *)imageAttContentMode:(NSString *)img frame:(CGRect)frame title:(NSString *)text
{
    
    UIView * ImageblackView = [[UIView alloc] initWithFrame:frame];
    ImageblackView.userInteractionEnabled = YES;
    
    UIImageView * images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35,35)];
    [shopBlackgrouView addSubview:images];
    images.userInteractionEnabled = YES;
    [images sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@""]];
    images.contentMode = UIViewContentModeScaleAspectFit;
    images.center = CGPointMake(frame.size.width / 2, frame.size.height / 2 - 10);
    [ImageblackView addSubview:images];
    UILabel *TextLaber = [[UILabel alloc]init];
    TextLaber.yBee = images.bottomBee;
    TextLaber.xBee = 0;
    TextLaber.heightBee = 25;
    TextLaber.widthBee = frame.size.width;
    TextLaber.font = [UIFont systemFontOfSize:13];
    TextLaber.textColor = TextColor;
    TextLaber.text = text;
    TextLaber.userInteractionEnabled = YES;
    TextLaber.textAlignment = NSTextAlignmentCenter;
    [ImageblackView addSubview:TextLaber];

    return ImageblackView;
}

- (void)locationView
{
    if (!navigationView) {
    navigationView = [[headLocationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 109 +
                                                                                 [[UIApplication sharedApplication] statusBarFrame].size.height)];
    navigationView.DD_delegate = self;
    navigationView.backgroundColor = BlueColor;
    navigationView.cityText.text = NSLocalizedString(@"正在定位中....",nil);
    [self addSubview:navigationView];
        
    }
}

- (void)setArrayText:(NSMutableArray *)arrayText
{
    _arrayText = arrayText;
    if (arrayText) {
        navigationView.arrayText = arrayText;
    }
}
- (void)setCityString:(NSString *)cityString
{
    _cityString = cityString;
    if (cityString) {
        navigationView.cityText.text = cityString;
    } else
    {
        navigationView.cityText.text = NSLocalizedString(@"正在定位中....",nil);
    }
}

- (void)setArrayImage:(NSArray *)arrayImage
{
    _arrayImage = arrayImage;
    if (arrayImage) {
        [self ScrollViewPageControl];
    }
}
- (void)setPointsNumber:(NSString *)pointsNumber
{
    _pointsNumber = pointsNumber;
//    if (pointsNumber) {
    if ([pointsNumber isEqualToString:@"0"] || [pointsNumber isEqualToString:@""]) {
        [navigationView.btn removeBadgeValue];
    } else
    {
        [navigationView.btn showNumberBadgeValue:pointsNumber];
    }
//    }
}

-(void)setCatayerText:(NSMutableArray *)catayerText
{
    _catayerText = catayerText;
    if (_catayerImage.count > 0 && _catayerText > 0) {
        [self shopTpye];
    }
    
}

-(void)setCatayerImage:(NSMutableArray *)catayerImage
{
    _catayerImage = catayerImage;
    if (_catayerImage.count > 0 && _catayerText.count > 0) {
        [self shopTpye];
        
    }
}


- (void)btnClick:(UITapGestureRecognizer *)btn
{
    UIView * views = btn.view;
    [self.homeDelegate ActionCategoryBtn:views.tag - 100000];
}
- (void)textAction:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
}
#pragma mark -- BHInfiniteScrollViewDelegate
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"did select item at index %ld", index);
}

#pragma mark -- headLocationViewDelegate
- (void)Actionlocation
{
    ///点击地址 跳转
    [self.homeDelegate Actionlocation];
}

- (void)ActionMessagesImage
{
    ///点击右边 按钮... 召唤 rightimage
    [self.homeDelegate ActionMessagesImage];
}
- (void)ActionHOTLabel:(NSString *)text
{
    NSLog(@"点击的热词--- = %@",text);
    [self.homeDelegate ActionHOTLabel:text];
}

- (void)ActionSeacherImage
{
    NSLog(@"点击搜索");
    [self.homeDelegate ActionSeacherImage];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
