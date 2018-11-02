//
//  DD_Button.h
//  DDKit
//
//  Created by 明克 on 2018/1/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    imageTop = 0,   // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    imageRight,     // 图片右 标题左
} ImageTitleStyle;

typedef enum {
    DD_ButtonEventTouchUpOutside = 0,   // 点击离开以后
    DD_ButtonEventTouchUpInside,      // 长按 到一个时间 然后出发事件
}DD_ButtonselectedStyle;

typedef enum {
    DD_ButtonEventDefnStyle = 0,       // 默认
    DD_ButtonEventHighlightStyle,      // 高亮
}DD_ButtonHighlightStyle;

@class DD_Button;
typedef void (^ActionBttonBlock)(DD_Button * btn);
@interface DD_Button : UIControl
///textLabel
@property (nonatomic, strong) UILabel * titleLabe;
///图片
@property (nonatomic, copy) NSString * imageString;
///文字
@property (nonatomic, copy) NSString * titleString;
///长按变换颜色  //暂时没用到
@property (nonatomic, copy) UIColor * ColorString;
///是否开启点击高亮动画 --- 默认 关闭
@property (nonatomic, assign) BOOL highlightisOn;
///高亮 颜色
@property (nonatomic, copy) UIColor * highlightColor;

///设置字体是否点击模式 //暂时只有高亮 跟 默认
- (void)setTitleLabe:(NSString *)titleLabe event:(DD_ButtonHighlightStyle)style;
/// block  target  按个人喜好 二选一
-(void)addTarget:(id)target action:(SEL)action eventTouch:(DD_ButtonselectedStyle)style;
/// 设置图片跟文字方向 要先设置好图片
- (void)imageTitleStyle:(ImageTitleStyle)style;
/// block  target  按个人喜好 二选一
- (void)buttonActionBlock:(ActionBttonBlock)selected;
@end
