//
//  bannerModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface bannerModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* position;
@property (nonatomic, strong) NSString <Optional>* areas;
@property (nonatomic, strong) NSString <Optional>* id;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* duration;
@property (nonatomic, strong) NSString <Optional>* mediaType;
@property (nonatomic, strong) NSString <Optional>* mediaURL;
@end
