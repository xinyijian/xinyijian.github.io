//
//  PushMessageModel.h
//  PattayaUser
//
//  Created by yanglei on 2018/11/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushMessageModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*message;
@property (nonatomic, strong) NSString <Optional>*lastUpdateDate;

@end

NS_ASSUME_NONNULL_END
