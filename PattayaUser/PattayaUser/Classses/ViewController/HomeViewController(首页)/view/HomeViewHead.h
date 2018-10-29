//
//  HomeViewHead.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/30.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeViewHeadDelegate <NSObject>

@optional

/** 点击城市*/
- (void)Actionlocation;
/** 点击我的召唤 **/
- (void)ActionMessagesImage;
/** 点击的热词 **/
- (void)ActionHOTLabel:(NSString *)text;
//** 点击的搜索 **/
- (void)ActionSeacherImage;
/** 点击品类 **/
- (void)ActionCategoryBtn:(NSInteger)tag;
/** 筛选条件 **/
- (void)ActionConditionQueryBtn:(NSInteger)tag;

@end

@interface HomeViewHead : UIView
@property (nonatomic, strong) NSMutableArray * arrayText;
@property (nonatomic, strong) NSString * cityString;
@property (nonatomic, strong) NSArray * arrayImage;
@property (nonatomic, strong) NSString * pointsNumber;
@property (nonatomic, strong) NSString * duration;
@property (nonatomic, strong) NSMutableArray * catayerImage;
@property (nonatomic, strong) NSMutableArray * catayerText;
@property (nonatomic, weak) id<HomeViewHeadDelegate>homeDelegate;
- (void)reloadInfiniteScrollview;
@end
