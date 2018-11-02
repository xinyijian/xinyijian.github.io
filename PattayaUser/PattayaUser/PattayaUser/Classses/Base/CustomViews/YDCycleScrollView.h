//
//  YDCycleScrollView.h
//  ZXCashATM
//
//  Created by iOS on 2018/8/27.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBannerModel.h"

#define YDCycleScrollViewH IPhone_7_Scale_Width(180)

@interface YDCycleScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame placehold:(NSString *)placeholdName;

// 轮播图片数组
@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, weak, readonly) SDCycleScrollView *cycleScrollView;

@end
