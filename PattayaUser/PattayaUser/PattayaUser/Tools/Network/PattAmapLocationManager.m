//
//  PattAmapLocationManager.m
//  pattaya-dri
//
//  Created by 明克 on 2018/2/23.
//  Copyright © 2018年 大卫. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "PattAmapLocationManager.h"
@interface PattAmapLocationManager ()
@end
@implementation PattAmapLocationManager
- (id)init
{
    self = [super init];
    if (self) {

//        self.allowsBackgroundLocationUpdates = YES;
        [self setPausesLocationUpdatesAutomatically:NO];
        
        [self setDesiredAccuracy:kCLLocationAccuracyBest];//定位精度
        self.isLocation = NO;
        //   定位超时时间，最低2s，此处设置为2s
        self.locationTimeout = 12;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        self.reGeocodeTimeout = 12;
        self.locatingWithReGeocode = YES;//连续定位是否返回逆地理信息，默认NO。
        self.delegate = self;
        [self startUpdatingLocation];
//        self.distanceFilter = 20
        
    }
    return self;
}


- (void)setIsLocation:(BOOL)isLocation
{
    _isLocation = isLocation;
    if (isLocation == NO) {
        [self startUpdatingLocation];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (![PattayaTool isNull:[NSNumber numberWithFloat:location.coordinate.latitude]]) {
        self.lat = [NSNumber numberWithFloat:location.coordinate.latitude];
        self.lng = [NSNumber numberWithFloat:location.coordinate.longitude];
        GetAppDelegate.latitude =[NSNumber numberWithFloat:location.coordinate.latitude];
        GetAppDelegate.longitude =[NSNumber numberWithFloat:location.coordinate.longitude];
        }
    
    if (reGeocode != nil) {
        self.lat = [NSNumber numberWithFloat:location.coordinate.latitude];
        self.lng = [NSNumber numberWithFloat:location.coordinate.longitude];
        _address = [NSString stringWithFormat:@"%@%@%@%@",reGeocode.district,reGeocode.street,reGeocode.number,reGeocode.POIName];
        _city = reGeocode.city ? reGeocode.city : reGeocode.province;
        if ([PattayaTool isNull:reGeocode.district] && [PattayaTool isNull:reGeocode.street] && [PattayaTool isNull:reGeocode.number]) {
            _address = NSLocalizedString(@"上海市",nil);
        }
        if ([PattayaTool isNull:_city]) {
            _city = reGeocode.street ? reGeocode.street : NSLocalizedString(@"上海市",nil);
        }
        _adcode = reGeocode.adcode;
        _Geocode = reGeocode.POIName ? reGeocode.POIName : reGeocode.AOIName ? reGeocode.AOIName : @"";
        if (_isLocation == NO && ![PattayaTool isNull:self.lat])
        {
            BLOCK_EXEC(_locationBlock,location,_address);
            _isLocation = YES;
        }
        GetAppDelegate.latitude =[NSNumber numberWithFloat:location.coordinate.latitude];
        GetAppDelegate.longitude =[NSNumber numberWithFloat:location.coordinate.longitude];
        BLOCK_EXEC(_isNowlocationBlock,location,_address);

    }
}
@end
