//
//  EmptyView.h
//  PattayaUser
//
//  Created by yanglei on 2018/11/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock)(void);


NS_ASSUME_NONNULL_BEGIN

@interface EmptyView : UIView

- (id)initWithFrame:(CGRect)frame  withImage:(NSString *)imageName withTitle:(NSString*)title;

@property (nonatomic, copy) refreshBlock block;

@end

NS_ASSUME_NONNULL_END
