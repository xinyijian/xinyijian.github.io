//
//  FindCarView.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDatePickerView.h"
typedef void(^CallCarBlock)(BOOL isCallNow);
typedef void(^clickAddressBlock)(void);
@interface FindCarView : UIView
- (id)initWithFrame:(CGRect)frame stlype:(NSInteger)tpye;
- (void)addressToShow:(NSString *)address;
- (void)callOrderResp:(NSInteger)time isOrderTpye:(NSInteger)tpye time:(NSString *)times;
- (void)overtimeError;
- (void)oldUI;
- (void)isEdinBtn:(BOOL)click;
- (void)timeStop;
- (void)pickerminLimitDate:(NSString *)st;
@property (nonatomic,strong) WSDatePickerView * picker;
@property (nonatomic,copy) CallCarBlock block;
@property (nonatomic,copy) clickAddressBlock addressBlock;
@property (nonatomic,copy) clickAddressBlock canlesBlock;
@property (nonatomic,strong) NSString * orderId;
@property (nonatomic,strong) UILabel * deitle;
@property (nonatomic,strong) NSString * addressUser;
@property (nonatomic,copy) clickAddressBlock timeoutBlock;

@end
