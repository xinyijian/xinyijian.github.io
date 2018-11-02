//
//  YLFontSize.m
//  Flk-ContractApp
//
//  Created by iOS on 2018/4/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YLFontSize.h"

@implementation YLFontSize

+ (CGFloat)yl_fontSize:(CGFloat)size
{
    if (SCREEN_Width == 320) {
        return size - 2.0;
    }
    
    if (SCREEN_Height == 414.0) {
        return size + 2;
    }
    
    return size;
}

@end
