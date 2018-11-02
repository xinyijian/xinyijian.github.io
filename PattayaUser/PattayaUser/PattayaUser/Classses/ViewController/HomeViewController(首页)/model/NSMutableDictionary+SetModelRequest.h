//
//  NSMutableDictionary+SetModelRequest.h
//  PattayaUser
//
//  Created by 明克 on 2018/5/22.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarDetailesProtocol.h"
@interface NSMutableDictionary (SetModelRequest)<CarDetailesProtocol>
+ (id)SeachStoreCodeRequest:(NSInteger)pageSize categpry:(NSString *)categpryId seacherText:(NSString *)seacher type:(NSInteger)tpy;
+ (id)SeachStoreCodeRequestorderBy:(NSInteger)pageSize latitude:(NSString *)latitude longitude:(NSString *)longitude type:(NSInteger)tpy;
+ (id)CarDetail:(id<CarDetailesProtocol>)model type:(NSString *)typ;
@end
