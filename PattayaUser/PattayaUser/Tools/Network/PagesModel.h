//
//  PagesModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/21.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PagesModel : JSONModel
@property(nonatomic, strong) NSNumber <Optional>* number;
@property(nonatomic, strong) NSNumber <Optional>* content;
@property(nonatomic, strong) NSNumber <Optional>* totalPages;
@property(nonatomic, strong) NSNumber <Optional>* size;
@property(nonatomic, strong) NSNumber <Optional>* last;
@property(nonatomic, strong) NSNumber <Optional>* numberOfElements;
@property(nonatomic, strong) NSNumber <Optional>* first;
@property(nonatomic, strong) NSNumber <Optional>* totalElements;
+ (BOOL)isPageLastRelod;
@end
