//
//  PattAmapLocationManager.h
//  pattaya-dri
//
//  Created by 明克 on 2018/2/23.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import <AMapLocationKit/AMapLocationKit.h>
#import "locationModel.h"
typedef void(^LocationManagerBlock)(CLLocation *location,NSString * address);
@interface PattAmapLocationManager : AMapLocationManager<AMapLocationManagerDelegate>

@property (nonatomic, strong) NSNumber * lng;
@property (nonatomic, strong) NSNumber * lat;
@property (nonatomic, assign) BOOL  isLocation;
@property (nonatomic, copy) LocationManagerBlock locationBlock;
@property (nonatomic, copy) LocationManagerBlock isNowlocationBlock;
@property (nonatomic, strong) locationModel * selectedLocation;
@property (nonatomic, strong) locationModel * presentLocation;
+ (void)locationManagerBegn;

@end
