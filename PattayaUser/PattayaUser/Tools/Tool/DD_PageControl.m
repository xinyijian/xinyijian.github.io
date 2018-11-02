//
//  DD_PageControl.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/30.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "DD_PageControl.h"

@implementation DD_PageControl
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        if (subviewIndex == currentPage)
        {
            subview.layer.masksToBounds = YES;
            subview.layer.borderWidth = 0.5f;
            subview.layer.borderColor = [UIColor grayColor].CGColor;
            subview.backgroundColor = [UIColor clearColor];
        }
        else
        {
            
            subview.layer.masksToBounds = YES;
            
        }
        
    }

}
@end
