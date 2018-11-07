//
//  OrderListModel.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface detailListModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*productName;
@property (nonatomic, strong) NSString <Optional>*productUnit;
@property (nonatomic, strong) NSString <Optional>*number;
@property (nonatomic, strong) NSString <Optional>*retailPriceShow;
@property (nonatomic, strong) NSString <Optional>*gdsImagePath;
@property (nonatomic, strong) NSString <Optional>*productPrice;
@property (nonatomic, strong) NSNumber <Optional>* weight;
@property (nonatomic, strong) NSString <Optional>* unit;
@property (nonatomic, strong) NSNumber <Optional>* priceType;


@end
@protocol detailListModel

@end

@interface ListOrderModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*brandId;
@property (nonatomic, strong) NSString <Optional>*createBy;
@property (nonatomic, strong) NSString <Optional>*memberCardno;
@property (nonatomic, strong) NSString <Optional>*paymentStatusDESC;
///订单编号
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*storeId;
@property (nonatomic, strong) NSString <Optional>*paymentTypeId;
///支付方式
@property (nonatomic, strong) NSString <Optional>*paymentTypeIdDESC;
@property (nonatomic, strong) NSString <Optional>*preTaxAmount;
@property (nonatomic, strong) NSString <Optional>*userAccount;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*paymentStatus;
@property (nonatomic, strong) NSString <Optional>*storeName;
@property (nonatomic, strong) NSString <Optional>*orderPrice;
@property (nonatomic, strong) NSString <Optional>*orderTotal;
@property (nonatomic, strong) NSMutableArray <Optional>*gseImgUrl;
@property (nonatomic, strong) NSMutableArray <Optional,detailListModel>*detailList;
- (void)imagesUrlinit;
@end
@protocol ListOrderModel
@end
@interface OrderListModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *id;
@property (nonatomic, strong) NSNumber <Optional>*isLastPage;
@property (nonatomic, strong) NSNumber <Optional>*isFirstPage;
@property (nonatomic, strong) NSNumber <Optional>*total;
@property (nonatomic, strong) NSNumber <Optional>*lastPage;
@property (nonatomic, strong) NSMutableArray <Optional,ListOrderModel>*list;
@end
