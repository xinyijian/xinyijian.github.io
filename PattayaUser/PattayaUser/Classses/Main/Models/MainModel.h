
#import <JSONModel/JSONModel.h>

@interface ProductModel : JSONModel

@property (nonatomic, strong) NSString <Optional>* avatarURL;
@property (nonatomic, strong) NSString <Optional>* barcode;
@property (nonatomic, strong) NSString <Optional>* costPrice;
@property (nonatomic, strong) NSString <Optional>* dbCargowayId;
@property (nonatomic, strong) NSString <Optional>* dbGoodsId;
@property (nonatomic, strong) NSString <Optional>* description;
@property (nonatomic, strong) NSString <Optional>* Id;
@property (nonatomic, strong) NSString <Optional>* identifyHarwareCode;
@property (nonatomic, strong) NSString <Optional>* lowInventory;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* priceType;
@property (nonatomic, strong) NSString <Optional>* salePrice;
@property (nonatomic, strong) NSString <Optional>* quantity;
@property (nonatomic, strong) NSString <Optional>* sku;
@property (nonatomic, strong) NSString <Optional>* unit;
@property (nonatomic, strong) NSString <Optional>* weight;
@property (nonatomic, assign) NSString <Optional>*selectCount;

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
@property (nonatomic, strong) NSString <Optional>*enterType;
@property (nonatomic, strong) NSString <Optional>*deviceNo;
@property (nonatomic, strong) NSString <Optional>*Id;
@property (nonatomic, strong) NSString <Optional>*avatarURL;
@property (nonatomic, strong) NSString <Optional>*canBeCalling;
@property (nonatomic, strong) NSString <Optional>*geoDistance;
@property (nonatomic, strong) NSString <Optional>*saleAmountMonth;

@property (nonatomic, strong) NSMutableArray <Optional,ProductModel>*goodsList;

@end


@protocol ShopModel
@end
@interface MainModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*size;
//车的数量
@property (nonatomic, strong) NSNumber <Optional>*numberOfElements;

@property (nonatomic, strong) NSMutableArray <Optional,ShopModel>*content;
@end
