//
//  HotModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/14.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HotModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * key;
@end
@protocol HotModel
@end

@interface HotListModel : JSONModel
@property (nonatomic, strong) NSArray <Optional,HotModel>*data;
@end
