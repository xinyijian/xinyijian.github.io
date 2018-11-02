//
//  ConditionQueryView.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/10.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^conditionClickViewBlock) (NSInteger tag);
@interface ConditionQueryView : UIView
@property (nonatomic, copy) conditionClickViewBlock clickBlock;
@end
