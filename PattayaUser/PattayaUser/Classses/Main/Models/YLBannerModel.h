//
//  YDBannerModel.h
//  ZXCashATM
//
//  Created by iOS on 2018/8/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YLBaseModel.h"

@interface YLBannerModel : YLBaseModel

@property (nonatomic, copy  ) NSString *jumpUrl;
@property (nonatomic, copy  ) NSString *loadingUrl;

@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSNumber *hits;
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *updateTime;

@end
