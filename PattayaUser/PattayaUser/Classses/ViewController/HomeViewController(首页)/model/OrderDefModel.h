//
//  OrderDefModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OrderDefModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* driverAcceptedLatitude;
@property (nonatomic, strong) NSString <Optional>* driverAcceptedLongitude;
@property (nonatomic, strong) NSString <Optional>* productCategoryName;
@property (nonatomic, strong) NSString <Optional>* driverAcceptedFormattedAddress;
@property (nonatomic, strong) NSString <Optional>* userCallLatitude;
@property (nonatomic, strong) NSString <Optional>* userCallLongitude;
@property (nonatomic, strong) NSString <Optional>* userCallFormattedAddress;
@property (nonatomic, strong) NSString <Optional>* driverMobile;
/// NORMAL 即使单
@property (nonatomic, strong) NSString <Optional>* orderType;
///CALLING 等待接单
@property (nonatomic, strong) NSString <Optional>* status;
@property (nonatomic, strong) NSString <Optional>* timeLeft;
@property (nonatomic, strong) NSString <Optional>* callCategoryId;
@property (nonatomic, strong) NSString <Optional>* timeReservation;
@property (nonatomic, strong) NSString <Optional>* appointmentTime;
@property (nonatomic, strong) NSString <Optional>* id;

@end
