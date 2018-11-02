//
//  CodeObject.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/12.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <Foundation/Foundation.h>
///维护Code码
@interface CodeObject : NSObject
@property (nonatomic,strong) NSArray * codeArray;
+ (NSInteger)codeFind:(NSDictionary *)retCode;
@end
