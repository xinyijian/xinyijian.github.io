//
//  UserHeadView.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeadView : UIView
/// 直接set model 然后赋值头像 姓名 手机号.
//@property (nonatomic, strong) UserModel * model;
@property (nonatomic, strong) UILabel * userName;
@property (nonatomic, strong) UIImageView * userImg;
@property (nonatomic, strong) UILabel * userMobil;
@end
