//
//  ServiceCityModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ServiceCityModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * cityId;
@property (nonatomic, strong) NSString <Optional> * name;
@property (nonatomic, strong) NSString <Optional> * provinceId;
@property (nonatomic, strong) NSString <Optional> * enabled;

@end

@protocol ServiceCityModel
@end

@interface cityListModel : JSONModel
@property (nonatomic, strong) NSArray <Optional,ServiceCityModel> * data;
- (BOOL)cityService:(NSString *)cityCode;
@end
