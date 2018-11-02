//
//  OtherLogins.m
//  PattayaUser
//
//  Created by 明克 on 2018/5/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OtherLogins.h"

@implementation OtherLogins
+ (BOOL)QQLogin
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [GetAppDelegate.tencentOAuth setAuthShareType:AuthShareType_QQ];
    BOOL isSussc = [GetAppDelegate.tencentOAuth authorize:permissions inSafari:NO];
    return isSussc;
}
+ (void)weChatLogin:(UIViewController *)controller
{
    SendAuthReq * reques = [[SendAuthReq alloc]init];
    reques.scope = @"snsapi_userinfo";
    reques.state = @"iOSPattaya-user";
    if ([WXApi isWXAppInstalled]) {
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:reques];
    } else
    {
        [GetAppDelegate sendAuthReq:reques viewController:controller];
    }
}
+(void)registerOtherLoginsSuccess
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logintypeSuccess:) name:KdLOGINTPYE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQlogintype:) name:@"KdQQlogin" object:nil];

    
}
+ (void )QQlogintype:(NSNotification *)info
{
    NSDictionary * dic = info.object[@"QQ"];
    NSMutableDictionary * qqModelDic = [[NSMutableDictionary alloc]init];
    [qqModelDic setObject:@"QQ" forKey:@"loginType"];
    [qqModelDic setObject:GetAppDelegate.tencentOAuth.openId forKey:@"openId"];
    [qqModelDic setObject:dic[@"nickname"] forKey:@"nickname"];
    [qqModelDic setObject:dic[@"figureurl_qq_2"] forKey:@"headImgUrl"];
//    [self loginHttp:@{@"loginType":_wechatModel.loginType,@"openId":_wechatModel.openId,@"nickName":_wechatModel.nickname,@"headImgUrl":_wechatModel.headImgUrl,@"deviceType":@"IOS"}];
    [[OtherLogins singleton].Loginsdelegate otherSuccess:2 NSNotification:qqModelDic];
    

}

+ (void)logintypeSuccess:(NSNotification *)info
{
    //
    [[PattayaUserServer singleton] WeChatCodeRequest:info.object[@"code"] success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
//            _wechatModel = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
//            _wechatModel.loginType = @"WECHAT";
//            [weakSelf loginHttp:@{@"loginType":_wechatModel.loginType,@"openId":_wechatModel.openId,@"nickName":_wechatModel.nickname,@"unionId":_wechatModel.unionId,@"headImgUrl":_wechatModel.headImgUrl,@"sex":_wechatModel.sex,@"deviceType":@"IOS"}];
//            return ret[@"data"];
            if(![PattayaTool isNull:ret[@"data"]])
            {
                [[OtherLogins singleton].Loginsdelegate otherSuccess:1 NSNotification:ret[@"data"]];
            }
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

+(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end
