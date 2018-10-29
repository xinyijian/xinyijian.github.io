//
//  storeCategoryModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/5.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface storeCategoryModel : JSONModel
@property (nonatomic,strong) NSString <Optional> * avatarURL;
@property (nonatomic,strong) NSString <Optional> * categoryId;
@property (nonatomic,strong) NSString <Optional> * id;
@property (nonatomic,strong) NSString <Optional> * name;

@end

@protocol storeCategoryModel
@end

@interface CategoryListModel: JSONModel
@property (nonatomic,strong) NSMutableArray <Optional,storeCategoryModel> * data;
@end
