
#import <JSONModel/JSONModel.h>

@interface ProductModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*gdsType;
@property (nonatomic, strong) NSString <Optional>*productBarcode;
@property (nonatomic, strong) NSString <Optional>*gdsName;
@property (nonatomic, strong) NSString <Optional>*marketPrice;
@property (nonatomic, strong) NSString <Optional>*costPrice;
@property (nonatomic, strong) NSString <Optional>*productStock;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*updateTime;
@property (nonatomic, strong) NSString <Optional>*gdsImagePath;
@property (nonatomic, strong) NSString <Optional>*selectCount;

@end

@protocol ProductModel
@end

@interface ShopModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*categoryName;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*category;
@property (nonatomic, strong) NSString <Optional>*lat;
@property (nonatomic, strong) NSString <Optional>*lon;
@property (nonatomic, strong) NSString <Optional>*bindingDriverId;
@property (nonatomic, strong) NSString <Optional>*serviceFee;
@property (nonatomic, strong) NSString <Optional>*storeAddress;
@property (nonatomic, strong) NSString <Optional>*licenceNo;
@property (nonatomic, strong) NSString <Optional>*enterType;
@property (nonatomic, strong) NSString <Optional>*deviceNo;
@property (nonatomic, strong) NSString <Optional>*Id;
@property (nonatomic, strong) NSString <Optional>*avatarURL;
@property (nonatomic, strong) NSString <Optional>*canBeCalling;
@property (nonatomic, strong) NSString <Optional>*geoDistance;
@property (nonatomic, strong) NSString <Optional>*saleAmountMonth;
@property (nonatomic, strong) NSString <Optional>*dbStoreId;

@property (nonatomic, strong) NSMutableArray <Optional,ProductModel>*gdsCategoryList;

@end


@protocol ShopModel
@end
@interface MainModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*size;
//车的数量
@property (nonatomic, strong) NSNumber <Optional>*numberOfElements;

@property (nonatomic, strong) NSMutableArray <Optional,ShopModel>*content;
@end
