//
//  UIView+Center.m
//  BingF
//
//  Created by keming on 2017/10/31.
//  Copyright © 2017年 keming. All rights reserved.
//

#import "UIView+Center.h"

@implementation UIView (Center)

@dynamic topBee;
@dynamic bottomBee;
@dynamic leftBee;
@dynamic rightBee;

@dynamic widthBee;
@dynamic heightBee;

@dynamic offsetBee;
@dynamic positionBee;
@dynamic sizeBee;

@dynamic xBee;
@dynamic yBee;
@dynamic wBee;
@dynamic hBee;

- (CGFloat)topBee
{
    return self.frame.origin.y;
}

- (void)setTopBee:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)leftBee
{
    return self.frame.origin.x;
}

- (void)setLeftBee:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)widthBee
{
    return self.frame.size.width;
}

- (void)setWidthBee:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)heightBee
{
    return self.frame.size.height;
}

- (void)setHeightBee:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)bottomBee
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottomBee:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)rightBee
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRightBee:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)xBee
{
    return self.frame.origin.x;
}

- (void)setXBee:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (CGFloat)yBee
{
    return self.frame.origin.y;
}

- (void)setYBee:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (CGFloat)wBee
{
    return self.frame.size.width;
}

- (void)setWBee:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)hBee
{
    return self.frame.size.height;
}

- (void)setHBee:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)offsetBee
{
    CGPoint        point = CGPointZero;
    UIView *    view = self;
    
    while ( view )
    {
        point.x += view.frame.origin.x;
        point.y += view.frame.origin.y;
        
        view = view.superview;
    }
    
    return point;
}

- (void)setOffsetBee:(CGPoint)offset
{
    UIView * view = self;
    if ( nil == view )
        return;
    
    CGPoint point = offset;
    
    while ( view )
    {
        point.x += view.superview.frame.origin.x;
        point.y += view.superview.frame.origin.y;
        
        view = view.superview;
    }
    
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (CGPoint)positionBee
{
    return self.frame.origin;
}

- (void)setPositionBee:(CGPoint)pos
{
    CGRect frame = self.frame;
    frame.origin = pos;
    self.frame = frame;
}

- (CGSize)sizeBee
{
    return self.frame.size;
}

- (void)setSizeBee:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerXBee
{
    return self.center.x;
}

- (void)setCenterXBee:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerYBee
{
    return self.center.y;
}

- (void)setCenterYBee:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGPoint)originBee
{
    return self.frame.origin;
}

- (void)setOriginBee:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)boundsCenterBee
{
    return CGPointMake( CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) );
}

@end
