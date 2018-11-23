//
//  NewShopListModel.h
//  AppPark
//
//  Created by 池康 on 2018/3/7.
//

#import <Foundation/Foundation.h>

@interface NewShopListModel : JSONModel

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
@property (nonatomic, strong) NSString <Optional>*soldNum;


@end




