//
//  DD_SeachbarView.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DD_SeachbarViewDelegate <NSObject>

@optional
/** 点击取消*/
- (void)back;
/** 点击seach开始 **/
- (void)beginSeachText;
/** 结束 **/
- (void)didSeachText;
/** 点击的搜索 **/
- (void)changText:(NSString *)string;
/** 清空 **/
- (void)closeText;
/** 点击城市 **/
- (void)locationClinkeCityName:(NSString *)st;
/** 新增地址 **/
- (void)addressCliket;

@end
@interface DD_SeachbarView : UIView
@property (nonatomic, strong) UITextField * seachView;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, weak) id<DD_SeachbarViewDelegate>DD_delegate;
- (void)initUI;
- (void)locationView;
- (void)seachAddressView;
@end
