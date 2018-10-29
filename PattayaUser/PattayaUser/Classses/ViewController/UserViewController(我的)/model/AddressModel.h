//
//  AddressModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/3.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* id;
@property (nonatomic, strong) NSString <Optional>* formattedAddress;
@property (nonatomic, strong) NSString <Optional>* contactName;
@property (nonatomic, strong) NSString <Optional>* contactMobile;
@property (nonatomic, strong) NSString <Optional>* tagAlias;
@property (nonatomic, strong) NSString <Optional>* contactGender;
@property (nonatomic, strong) NSString <Optional>* longitude;
@property (nonatomic, strong) NSString <Optional>* latitude;
@property (nonatomic, strong) NSString <Optional>* areaId;
@end
@protocol AddressModel
@end
@interface AddressListModel : JSONModel
@property (nonatomic, strong) NSMutableArray <Optional,AddressModel>* data;
@end
