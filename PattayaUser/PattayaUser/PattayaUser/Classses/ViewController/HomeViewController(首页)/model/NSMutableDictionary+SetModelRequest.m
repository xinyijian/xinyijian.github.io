//
//  NSMutableDictionary+SetModelRequest.m
//  PattayaUser
//
//  Created by 明克 on 2018/5/22.
//  Copyright © 2018年 明克. All rights reserved.
//
//#import "<#header#>"
#import "NSMutableDictionary+SetModelRequest.h"

@implementation NSMutableDictionary (SetModelRequest)
+ (id)SeachStoreCodeRequest:(NSInteger)pageSize categpry:(NSString *)categpryId seacherText:(NSString *)seacher type:(NSInteger)tpy
{
    NSMutableDictionary * dicSave = [[NSMutableDictionary alloc] init];
    if ([PattayaTool isNull:GetAppDelegate.locationAddress.latitude]) {
        [PattAmapLocationManager singleton].isLocation = NO;
    } else
    {
        [dicSave setObject:GetAppDelegate.locationAddress.latitude forKey:@"latitude"];
        [dicSave setObject:GetAppDelegate.locationAddress.longitude forKey:@"longitude"];
    }
    [dicSave setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"pageNum"];
    [dicSave setObject:@"10" forKey:@"pageSize"];
    if (![PattayaTool isNull:seacher] && ![PattayaTool isNull:categpryId]) {
        [dicSave setObject:seacher forKey:@"keyword"];
    } else if ([PattayaTool isNull:categpryId] && ![PattayaTool isNull:seacher])
    {
        [dicSave setObject:seacher forKey:@"keyword"];
    } else if (![PattayaTool isNull:categpryId] && [PattayaTool isNull:seacher])
    {
        [dicSave setObject:categpryId forKey:@"category"];
        
    }
    if (tpy == 0) {
        [dicSave setObject:@"DISTANCE" forKey:@"orderBy"];
    } else if (tpy == 1)
    {
        [dicSave setObject:@"DISCOUNT" forKey:@"orderBy"];
    } else
    {
        [dicSave setObject:@"SERVICE_FEE" forKey:@"orderBy"];
    }
    return dicSave;
}

+ (id)SeachStoreCodeRequestorderBy:(NSInteger)pageSize latitude:(NSString *)latitude longitude:(NSString *)longitude type:(NSInteger)tpy
{
    NSMutableDictionary * dicSave = [[NSMutableDictionary alloc] init];
    
    if ([PattayaTool isNull:latitude]){
        [PattAmapLocationManager singleton].isLocation = NO;
    } else
    {
        [dicSave setObject:latitude forKey:@"latitude"];
        [dicSave setObject:longitude forKey:@"longitude"];
    }
    [dicSave setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"pageNum"];
    [dicSave setObject:@"10" forKey:@"pageSize"];
    if (tpy == 0) {
        [dicSave setObject:@"DISTANCE" forKey:@"orderBy"];
    } else if (tpy == 1)
    {
        [dicSave setObject:@"SERVICE_FEE" forKey:@"orderBy"];
    } else
    {
        [dicSave setObject:@"DISCOUNT" forKey:@"orderBy"];
    }
    return dicSave;
}

+ (id)CarDetail:(id<CarDetailesProtocol>)model type:(NSString *)typ;
{
    NSMutableDictionary * dic;
    
//    if ([typ isEqualToString:@"RESERVATION"]) {
//        dic = @{@"userCallFormattedAddress":_carDetailModel.formattedAddress,@"userCallLatitude":_carDetailModel.latitude,@"userCallLongitude":_carDetailModel.longitude,@"vehicleId":_model.dbStoreId,@"userMobile":[PattayaTool isNull:_carDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _carDetailModel.contactMobile,@"userName":[PattayaTool isNull:_carDetailModel.contactName] ?  [PattayaTool driName] : _carDetailModel.contactName,@"orderType":orderTpye,@"reservationTime":
//                    [NSNumber numberWithLongLong:_dayTime]};
//        //        tpy = 1;
//    } else
//    {
//        dic = @{@"userCallFormattedAddress":_carDetailModel.formattedAddress,@"userCallLatitude":_carDetailModel.latitude,@"userCallLongitude":_carDetailModel.longitude,@"vehicleId":_model.dbStoreId,@"userMobile":[PattayaTool isNull:_carDetailModel.contactMobile] ?  [PattayaTool mobileDri] : _carDetailModel.contactMobile,@"userName":[PattayaTool isNull:_carDetailModel.contactName] ?  [PattayaTool driName] : _carDetailModel.contactName,@"orderType":orderTpye};
//        //        tpy = 2;
//    }
    return dic;
}

@end
