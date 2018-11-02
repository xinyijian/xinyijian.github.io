//
//  CarStoreMAPointAnntation.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CarStoreMAPointAnntation : MAPointAnnotation
@property (nonatomic, strong) NSString * carId;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * lon;
@property (nonatomic, strong) NSString * feeLaber;
@property (nonatomic, strong) NSString * addressLaber;
@property (nonatomic, strong) NSString * apartLaber;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * storeName;

@end
