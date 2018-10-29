//
//  UIView+Center.h
//  BingF
//
//  Created by keming on 2017/10/31.
//  Copyright © 2017年 keming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Center)
@property (assign, nonatomic) CGFloat    topBee;
@property (assign, nonatomic) CGFloat    bottomBee;
@property (assign, nonatomic) CGFloat    leftBee;
@property (assign, nonatomic) CGFloat    rightBee;

@property (assign, nonatomic) CGPoint    offsetBee;
@property (assign, nonatomic) CGPoint    positionBee;

@property (assign, nonatomic) CGFloat    xBee;
@property (assign, nonatomic) CGFloat    yBee;
@property (assign, nonatomic) CGFloat    wBee;
@property (assign, nonatomic) CGFloat    hBee;

@property (assign, nonatomic) CGFloat    widthBee;
@property (assign, nonatomic) CGFloat    heightBee;
@property (assign, nonatomic) CGSize    sizeBee;

@property (assign, nonatomic) CGFloat    centerXBee;
@property (assign, nonatomic) CGFloat    centerYBee;
@property (assign, nonatomic) CGPoint    originBee;
@property (readonly, nonatomic) CGPoint    boundsCenterBee;
@end
