//
//  newsreelView.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HotActionBlock)(NSString * text);
@interface newsreelView : UIView
@property (nonatomic, strong) NSMutableArray * arrayHotText;
@property (nonatomic, copy) HotActionBlock hotBlcok;

@end
