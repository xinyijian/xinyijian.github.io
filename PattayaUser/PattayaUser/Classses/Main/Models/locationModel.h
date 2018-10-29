//
//  locationModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/10/29.
//  Copyright © 2018 明克. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface locationModel : JSONModel
@property (nonatomic, strong) NSNumber * lng;
@property (nonatomic, strong) NSNumber * lat;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * adcode;
@property (nonatomic, strong) NSString * Geocode;
@end

NS_ASSUME_NONNULL_END
