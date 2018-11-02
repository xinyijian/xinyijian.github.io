//
//  YDFontSize.h
//  Flk-ContractApp
//
//  Created by iOS on 2018/4/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIBoldFont(a)   [UIFont boldSystemFontOfSize:[YLFontSize yl_fontSize:a]]
#define UISystemFont(a) [UIFont systemFontOfSize:[YLFontSize yl_fontSize:a]]

@interface YLFontSize : NSObject

+ (CGFloat)yl_fontSize:(CGFloat)size;

@end
