//
//  YDCycleScrollView.m
//  ZXCashATM
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YDCycleScrollView.h"

@interface YDCycleScrollView () <SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@end

@implementation YDCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placeholdName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        [self setupUI:placeholdName];
    }
    return self;
}

#pragma mark - 初始化UI
- (void)setupUI:(NSString *)placeholdName
{
    UIImage *placeholdImg = [UIImage imageNamed:placeholdName];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_Width, self.height) delegate:self placeholderImage:placeholdImg];
    self.cycleScrollView = cycleScrollView;
    cycleScrollView.backgroundColor = App_TotalGrayWhite;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.autoScrollTimeInterval = 2.0;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 自定义分页控件小圆标颜色
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"banner_icon_dot"];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"banner_icon_currentdot"];

//    cycleScrollView.currentPageDotColor = App_Nav_BarDefalutColor;
//    cycleScrollView.pageDotColor = [App_Nav_BarDefalutColor colorWithAlphaComponent:0.3];
    cycleScrollView.pageControlDotSize = CGSizeMake(12, 5);
    
    [self addSubview:cycleScrollView];
    [SDCycleScrollView clearImagesCache];
}

#pragma mark - 设置数据
- (void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    
    self.cycleScrollView.imageURLStringsGroup = [[bannerArray.rac_sequence map:^id _Nullable(YLBannerModel *model) {
        return model.loadingUrl;
    }] array];
    
    self.cycleScrollView.autoScroll = bannerArray.count > 1;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index image:(UIImage *)image
{
    
}

@end

