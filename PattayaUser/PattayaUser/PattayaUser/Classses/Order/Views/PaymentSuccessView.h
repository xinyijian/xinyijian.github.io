//
//  PaymentSuccessView.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentSuccessView : UIView

/// adv
@property (nonatomic,strong) UIImageView *advImg;
/// 白色背景
@property (nonatomic,strong) UIView *bgView;
/// 支付成功
@property (nonatomic,strong) UIImageView *successImg;
/// 支付成功Label
@property (nonatomic,strong) UILabel *successLabel;
/// 总额
@property (nonatomic,strong) UILabel *totalAmountLabel;
/// 预计到达
@property (nonatomic,strong) UILabel *reachTimeLabel;
/// 联系卖家
@property (nonatomic,strong) UILabel *contactLabel;
/// 预计到达时间
@property (nonatomic,strong) UILabel *timeLabel;
/// 联系卖家
@property (nonatomic,strong) UIButton *contactBT;
/// 完成
@property (nonatomic,strong) UIButton *completeBT;

@end
