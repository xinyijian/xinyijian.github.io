//
//  UpdateObject.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "UpdateObject.h"
#import "UpdateAlertView.h"
@implementation UpdateObject

- (void)updateApp:(UpdateModel *)updateM
{
    UpdateAlertView *alert = [[UpdateAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height+64)];
    alert.updateModel = updateM;
    alert.versionNum = [NSString stringWithFormat:@"版本号%@",
                        updateM.version];
    alert.detailInfo = updateM.updateDescription;
    alert.updateUrl = updateM.url;
    [GetAppDelegate.window addSubview:alert];
}

- (void)checkUpdate
{
    WS(weakSelf);//[NSString stringWithFormat:@"/version/check/%@/2",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
    
    [[PattayaUserServer singleton]checkUpdateRequest:nil success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isSucceed:ret]) {
            UpdateModel *model = [[UpdateModel alloc]initWithDictionary:ret[@"data"] error:nil];
               
                [weakSelf updateApp:model];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
