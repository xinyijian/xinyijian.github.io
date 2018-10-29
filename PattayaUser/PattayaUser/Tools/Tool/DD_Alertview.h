//
//  DD_Alertview.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DD_AlertviewStlye) {
    DD_AlertviewStlyeNone, //接单成功
    DD_AlertviewStlyeOverTime, //超时
    DD_AlertviewStlyeConfirm, //确认
    DD_AlertviewStlyeDidDonw, //到达
    DD_AlertviewStlyeNonSopport,//不支持当前城市
    DD_AlertviewStlyeCancelOrder,//取消订单

};
typedef void(^alerviewActionBlock) (void);
@interface DD_Alertview : UIView
@property (nonatomic, strong) UILabel * storeLaber;
@property (nonatomic, strong) UILabel * locationLaber;
@property (nonatomic, strong) UILabel * timeLaber;
@property (nonatomic, copy) alerviewActionBlock  block;
@property (nonatomic, strong) NSString * categoryText;
@property (nonatomic, strong) NSString * distantText;
@property (nonatomic, strong) NSString * needsTimeText;


- (void)show;
- (id)initWithFrame:(CGRect)frame stlyeView:(DD_AlertviewStlye)stlyeview navStatusHeight:(CGFloat)navStatusHeight;

@end
