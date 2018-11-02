//
//  UserModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel
///获取微信信息用的
@property (nonatomic, strong) NSString <Optional>* openId;
@property (nonatomic, strong) NSString <Optional>* nickname;
@property (nonatomic, strong) NSString <Optional>* headImgUrl;
@property (nonatomic, strong) NSString <Optional>* unionId;
@property (nonatomic, strong) NSString <Optional>* sex;
@property (nonatomic, strong) NSString <Optional>* loginType;

#pragma mark -- 获取用户信息用的
@property (nonatomic, strong) NSString <Optional>* mobile;
@property (nonatomic, strong) NSString <Optional>* userName;
@property (nonatomic, strong) NSMutableArray <Optional>* userSocialLinks;
@property (nonatomic, strong) NSString <Optional>* maskMobile;

@end
