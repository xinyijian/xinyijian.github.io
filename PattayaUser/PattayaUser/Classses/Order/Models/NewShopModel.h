//
//  NewShopModel.h
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "JSONModel.h"

@interface NewShopModel : JSONModel

@property (nonatomic, strong) NSMutableArray <Optional>*titleArray;

@property (nonatomic, strong) NSMutableArray <Optional>*productArray;



@end
