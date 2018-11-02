//
//  headLocationView.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
@class headLocationView;
@protocol headLocationViewDelegate <NSObject>

@optional

/** 点击城市*/
- (void)Actionlocation;
/** 点击我的召唤 **/
- (void)ActionMessagesImage;
/** 点击的热词 **/
- (void)ActionHOTLabel:(NSString *)text;
//** 点击的搜索 **/
- (void)ActionSeacherImage;


@end
@interface headLocationView : UIView
@property (nonatomic, weak) id<headLocationViewDelegate>DD_delegate;
@property (nonatomic, assign) BOOL rightImageHidde;
@property (nonatomic, strong) UILabel * cityText;
@property (nonatomic, strong) NSMutableArray * arrayText;
@property (nonatomic, strong) JMButton *btn;

@end
