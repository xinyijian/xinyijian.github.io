//
//  StoreCarDetailsVIew.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^addressClick)(void);
@interface StoreCarDetailsVIew : UIView
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * feeLaber;
@property (nonatomic,strong) UILabel * apartLaber;
@property (nonatomic,strong) UILabel * addressLaber;
@property (nonatomic,strong) UIButton * callOrderBtn;
@property (nonatomic,strong) UIButton * detailsBtn;
@property (nonatomic,strong) UIButton * closeBtn;
@property (nonatomic,strong) NSString * dbStore;

@property (nonatomic,copy) addressClick clickEdit;
- (void)callOrderResp:(NSInteger)timeN OrderId:(NSString *)orId;
@end
