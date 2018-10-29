//
//  PaymentActionSheetView.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentActionSheetView : UIView

/// 白色背景
@property (nonatomic,strong) UIView *bgView;
/// 剩余时间
@property (nonatomic,strong) UILabel *surplusTimeLabel;
/// 取消按钮
@property (nonatomic,strong) UIButton *cancelBT;
/// 总额
@property (nonatomic,strong) UILabel *totalAmountLabel;
/// 微信img
@property (nonatomic,strong) UIImageView *wechatImg;
/// 支付宝img
@property (nonatomic,strong) UIImageView *aliPayImg;
/// 微信
@property (nonatomic,strong) UILabel *wechatLabel;
/// 支付宝
@property (nonatomic,strong) UILabel *aliPayLabel;
/// 微信选择按钮
@property (nonatomic,strong) UIButton *wechatSelectBT;
/// 支付宝选择按钮
@property (nonatomic,strong) UIButton *alipaySelectBT;
/// 支付宝按钮
@property (nonatomic,strong) UIButton *paymentBT;

//隐藏视图
-(void)hiddenView;

//展示视图
-(void)showView;


@end
