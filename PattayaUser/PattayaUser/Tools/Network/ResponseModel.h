//
//  ResponseModel.h
//  pattaya-dri
//
//  Created by 明克 on 2018/2/25.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ResponseModel : JSONModel
@property(nonatomic, strong) NSNumber <Optional>* success;
@property(nonatomic, strong) NSString <Optional>* code;
@property(nonatomic, strong) NSString <Optional>* message;
@property(nonatomic, strong) id <Optional> data;
+ (BOOL)isSucceed:(NSDictionary*)dic;
+ (BOOL)isData:(NSDictionary *)dic;
@end
