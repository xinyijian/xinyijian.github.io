//
//  ProccesingModel.h
//  PattayaUser
//
//  Created by yanglei on 2018/11/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProccesingModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*timeCreated;
@property (nonatomic, strong) NSString <Optional>*acceptedTime;

@property (nonatomic, strong) NSString <Optional> *callCategoryId;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedAdcode;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedFormattedAddress;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedLatitude;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedLongitude;
@property (nonatomic, strong) NSString <Optional> *driverMobile;
@property (nonatomic, strong) NSString <Optional> *driverId;
@property (nonatomic, strong) NSString <Optional> *id;
@property (nonatomic, strong) NSString <Optional> *orderType;
@property (nonatomic, strong) NSString <Optional> *reservationTime;
@property (nonatomic, strong) NSString <Optional> *serviceFee;
@property (nonatomic, strong) NSString <Optional> *status;
@property (nonatomic, strong) NSString <Optional> *userCallFormattedAddress;
@property (nonatomic, strong) NSString <Optional> *userCallLatitude;
@property (nonatomic, strong) NSString <Optional> *userCallLongitude;
@property (nonatomic, strong) NSString <Optional> *userId;
@property (nonatomic, strong) NSString <Optional> *userMobile;
@property (nonatomic, strong) NSString <Optional> *userName;
@property (nonatomic, strong) NSString <Optional> *timeLeft;
@property (nonatomic, strong) NSString <Optional> *callOrderId;


@end

NS_ASSUME_NONNULL_END
