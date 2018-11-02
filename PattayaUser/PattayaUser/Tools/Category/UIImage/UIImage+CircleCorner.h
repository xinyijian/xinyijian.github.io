//
//  UIImage+CircleCorner.h
//  项目通用框架
//
//  Created by sqj on 17/3/27.
//  Copyright © 2017年 zsmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleCorner)

/**
 *  画圆角
 *
 *  @param size 图片所在imageView的size
 *
 *  @return 圆形图片
 */
- (UIImage *)circleImage:(CGSize)size;

/**
 *  画圆角
 *
 *  @param size 图片所在imageView的size
 *
 *  @param radius 圆角半径
 *
 *  @return 圆角图片
 */
- (UIImage *)circleImage:(CGSize)size radius:(CGFloat)radius;

/**
 *  画圆角
 *
 *  @param size  图片所在imageView的size
 *  @param color 边框的颜色
 *  @param width 边框的宽度
 *
 *  @return 带边框的圆形图片
 */
- (UIImage *)circleImage:(CGSize)size color:(UIColor *)color width:(CGFloat)width;
/**
 *  画分割线
 *
 *  @return 分割线图片
 */
+ (UIImage *)drawNavgationBarSeparatorImg;

@end







