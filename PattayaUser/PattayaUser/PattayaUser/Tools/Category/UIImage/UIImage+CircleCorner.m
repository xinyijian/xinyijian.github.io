//
//  UIImage+CircleCorner.m
//  项目通用框架
//
//  Created by sqj on 17/3/27.
//  Copyright © 2017年 zsmy. All rights reserved.
//

#import "UIImage+CircleCorner.h"

@implementation UIImage (CircleCorner)

// 边框圆形图片
- (UIImage *)circleImage:(CGSize)size color:(UIColor *)color width:(CGFloat)width
{
    CGFloat scale = [UIScreen mainScreen].scale;
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [color setFill];
    
    CGContextFillEllipseInRect(ctx, rect);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, CGRectMake(width, width, size.width - 2 * width, size.height - 2 * width));
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 圆形图片
- (UIImage *)circleImage:(CGSize)size
{
    return [self circleImage:size radius:size.width];
}

// 圆角图片
- (UIImage *)circleImage:(CGSize)size radius:(CGFloat)radius
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    CGContextAddPath(c, path.CGPath);
    CGContextClip(c);
    
    [self drawInRect:rect];
    
    CGContextDrawPath(c, kCGPathFillStroke);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)drawNavgationBarSeparatorImg
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.3f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [ColorWithRGB(180, 180, 180) CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end











