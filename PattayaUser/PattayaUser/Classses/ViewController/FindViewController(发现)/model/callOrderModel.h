//
//  callOrderModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CarDetailesProtocol.h"
@interface callOrderModel : JSONModel<CarDetailesProtocol>
/**
 callCategoryId = 2;
 driverAcceptedAdcode = "<null>";
 driverAcceptedFormattedAddress = "<null>";
 driverAcceptedLatitude = "<null>";
 driverAcceptedLongitude = "<null>";
 driverId = "<null>";
 id = 382;
 orderType = NORMAL;
 reservationTime = "<null>";
 serviceFee = "<null>";
 status = CALLING;
 timeAccepted = "<null>";
 timeDeparture = "<null>";
 timeExpiration = "<null>";
 timeFinished = "<null>";
 timeLeft = "<null>";
 timeReservation = "<null>";
 userCallFormattedAddress = "\U4e0a\U6d77\U5e02\U957f\U5b81\U533a\U6c5f\U82cf\U8def\U8857\U9053\U5b89\U5316\U8def300\U5f045\U53f7\U798f\U4e16\U5c0f\U533a";
 userCallLatitude = "31.215179";
 userCallLongitude = "121.425948";
 userId = 24;
 userMobile = 13889777895;
 userName = 13889777895;
 vehicleId = "<null>";
 **/
@property (nonatomic, strong) NSString <Optional> *callCategoryId;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedAdcode;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedFormattedAddress;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedLatitude;
@property (nonatomic, strong) NSString <Optional> *driverAcceptedLongitude;
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
