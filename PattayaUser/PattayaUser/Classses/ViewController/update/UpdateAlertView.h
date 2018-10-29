//
//  UpdateAlertView.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateModel.h"
@interface UpdateAlertView : UIView
@property (strong, nonatomic) UpdateModel *updateModel;
@property (strong, nonatomic) NSString *versionNum;
@property (strong, nonatomic) NSString *detailInfo;
@property (strong,nonatomic) NSString *updateUrl;
@end
