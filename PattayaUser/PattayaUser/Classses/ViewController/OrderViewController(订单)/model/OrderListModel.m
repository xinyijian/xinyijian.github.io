//
//  OrderListModel.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

@end

@implementation detailListModel

@end

@implementation ListOrderModel
- (void)imagesUrlinit
{
    _gseImgUrl = [NSMutableArray array];
    for (detailListModel * mode in self.detailList) {
        if (![PattayaTool isNull:mode.gdsImagePath]) {
            [_gseImgUrl addObject:mode.gdsImagePath];
            }

    }
}
@end
