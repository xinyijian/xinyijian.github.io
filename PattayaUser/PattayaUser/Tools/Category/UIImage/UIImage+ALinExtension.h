//
//  UIImage+ALinExtension.h
//  MiaowShow
//
//  Created by ALin on 16/6/16.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALinExtension)
/**
 *  修改图片的背景颜色
 *
 *  @param color 对应的颜色
 *
 *  @return 修改后的图片
 */
- (UIImage *)updateImageWithColor:(UIColor *)color;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  拉伸图片
 *
 *  @param imgName 原始图片
 *
 *  @return 返回一张拉伸的图片
 */
+ (UIImage *)resizeImage:(NSString *)imgName;

/**
 *  防止渲染，显示原始图片
 *
 *  @param imageName 图片名称
 *
 *  @return 显示原始图片
 */
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

/**
 *  压缩和旋转图片
 *
 *  @param image 原始图片
 *
 *  @return 压缩处理后的图片
 */
+ (UIImage *)compressImageWith:(UIImage *)image;

/**
 *  等比例缩放图片
 *
 *  @param image 原始图片
 *  @param width 缩放目标宽度
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)scaleImageWith:(UIImage *)image targetWidth:(CGFloat)width;

/**
 *  NSBundle中获取图片 - 不会有缓存
 *
 *  @param name 图片资源的名称
 *
 *  @return 获取的图片
 */
+ (UIImage *)imageResourceName:(NSString *)name;

@end


























































