//
//  UpdateModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UpdateModel : JSONModel
@property (strong ,nonatomic) NSString<Optional> *appVersion;
@property (strong, nonatomic) NSString<Optional> *createdBy;
@property (strong, nonatomic) NSString<Optional> *createdDate;
@property (strong, nonatomic) NSNumber<Optional> *current;
@property (strong, nonatomic) NSString<Optional> *deletedFlag;
@property (strong, nonatomic) NSNumber<Optional> *deviceType;
@property (strong, nonatomic) NSNumber<Optional> *id;
@property (strong, nonatomic) NSString<Optional> *note;
@property (strong, nonatomic) NSNumber<Optional> *type;
@property (strong, nonatomic) NSString<Optional> *updatedBy;
@property (strong, nonatomic) NSString<Optional> *updatedDate;
@property (strong, nonatomic) NSString<Optional> *updateDescription;
@property (strong, nonatomic) NSString<Optional> *url;
@property (strong, nonatomic) NSNumber<Optional> *version;
@property (strong, nonatomic) NSString<Optional> *updateUrl;
@property (strong, nonatomic) NSNumber <Optional> *forceUpdate;
@end
