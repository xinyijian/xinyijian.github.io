//
//  TakeawayShopView.h
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeawayShopView : UIView

//店铺ID
@property (nonatomic , copy) NSString *groupId;

- (id)initWithFrame:(CGRect)frame  withGroupID:(NSString *)groupId;

@end
