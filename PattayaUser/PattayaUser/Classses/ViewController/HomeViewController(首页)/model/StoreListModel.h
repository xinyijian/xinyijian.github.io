//
//  StoreListModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface StoreGoodsListModel : JSONModel
///单位
@property (nonatomic, strong) NSString <Optional>* unit;
///还有多少量
@property (nonatomic, strong) NSString <Optional>* quantity;
///成本费
@property (nonatomic, strong) NSString <Optional>* costPrice;
///市场价格
@property (nonatomic, strong) NSString <Optional>* marketPrice;
///销售价格
@property (nonatomic, strong) NSNumber <Optional>* salePrice;
@property (nonatomic, strong) NSNumber <Optional>* priceType;
///姓名
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSNumber <Optional>* lowInventory;
@property (nonatomic, strong) NSNumber <Optional>* weight;

@end

@protocol StoreGoodsListModel
@end

@interface StoreDefileModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* categoryDescription;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* geoDistance;
@property (nonatomic, strong) NSArray  <Optional,StoreGoodsListModel> * goodsList;
@property (nonatomic, strong) NSString <Optional>* categoryName;
@property (nonatomic, strong) NSString <Optional>* lon;
@property (nonatomic, strong) NSString <Optional>* lat;
@property (nonatomic, strong) NSString <Optional>* id;
@property (nonatomic, strong) NSNumber <Optional>* dbStoreId;
@property (nonatomic, strong) NSString <Optional>* avatarURL;
@property (nonatomic, strong) NSString <Optional>* serviceFee;
@property (nonatomic, strong) NSString <Optional>* saleAmountMonth;


//@property (nonatomic, strong) NSArray <Optional>* content;
//@property (nonatomic, strong) NSArray <Optional>* content;
//@property (nonatomic, strong) NSArray <Optional>* content;

@end
@protocol StoreDefileModel
@end

@interface StoreListModel : JSONModel
@property (nonatomic, strong) NSMutableArray <Optional,StoreDefileModel>* content;
//@property (nonatomic, strong) NSNumber <Optional>*isLastPage;
//@property (nonatomic, strong) NSNumber <Optional>*isFirstPage;
//@property (nonatomic, strong) NSNumber <Optional>*last;
//@property (nonatomic, strong) NSNumber <Optional>*first;
@property (nonatomic, strong) NSNumber <Optional>*totalPages;
@end
