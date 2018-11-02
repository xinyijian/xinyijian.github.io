//
//  YDBaseController.h
//  项目通用框架
//
//  Created by sqj on 17/3/27.
//  Copyright © 2017年 zsmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YDProgressType) {
    YDProgressTypeNone,     // 没有加载框
    YDProgressTypeCover,    // 整个界面覆盖加载
    YDProgressTypeBezel     // 档板HUD的加载框
};

@interface YDBaseController : UIViewController

@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

#pragma mark - 属性
/**
 * 导航栏的样式 默认 NavgationStyleDefalute
 */
@property (nonatomic, assign) NavgationStyle navStyle;
/**
 * 加载框的样式 默认 YDProgressTypeNone
 */
@property (nonatomic, assign) YDProgressType progressType;
/**
 *  导航栏隐藏和显示 - 默认：NO
 */
@property (nonatomic, assign) BOOL navigationBarHidden;
/**
 * 是否需要滑动返回：默认 YES
 *
 * 在使用TYPagerController库的时候，当tableView对应的控制器添加到分页控制器。
 这时候去除滑动返回设置，要不然会影响系统的滑动返回
 *
 */
@property (nonatomic, assign) BOOL isGestureRecognizerBack;

#pragma mark - 网络请求结果界面的相关数据
/// 空数据页面的标题 - 在setupData设置
@property (nonatomic, strong) NSString *emptyTitle;
/// 空数据页面的图片 - 在setupData设置
@property (nonatomic, strong) NSString *emptyImgName;
/// 请求失败页面的标题 - 在请求结束,后台返回的msg或者根据code判断
@property (nonatomic, strong) NSString *errorTitle;
/// 请求失败页面的图片 - 整个app一般都是统一的图片
@property (nonatomic, strong) NSString *errorImgName;

#pragma mark - 方法
/**
 *  初始化UI
 */
- (void)setupUI;
/**
 *  导航栏右边按钮
 */
- (void)rightBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void(^)(void))actionBlock;
/**
 * 导航栏左边按钮
 */
- (void)leftBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void(^)(void))actionBlock;

/**
 *  请求网络数据 初始化请求数据
 */
- (MBProgressHUD *)setupRequest;

/**
 *  设置基础的数据
 */
- (void)setupData;

/**
 *  网络请求数据，子类实现，进行重写
 */
- (void)netRequestData;

/**
 *  请求处理的结果
 */
- (void)handleNetReslut:(YDNetResultStatus)status;

@end

































