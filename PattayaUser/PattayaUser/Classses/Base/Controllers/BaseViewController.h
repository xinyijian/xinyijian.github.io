//
//  BaseViewController.h
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic, copy) NSString *customTitle;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;
- (void)rightBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void(^)(void))actionBlock;
- (void)rightBarButtonWithTitle:(NSString *)title color:(UIColor *)color action:(void (^)(void))actionBlock;
- (void)showToast:(NSString *)message;

- (void)leftBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void(^)(void))actionBlock;
- (void)itemRightBarButtonWithbarImage:(NSArray *)image action:(void (^)(void))actionBlock share:(void (^)(void))shareBlock;
- (void)add_TableviewRefreshfoorte:(UITableView *)tableview refrshBlack:(MJRefreshComponentRefreshingBlock)refreshingBlock;
- (void)add_TableviewRefreshHeader:(UITableView *)tableview refrshBlack:(MJRefreshComponentRefreshingBlock)refreshingBlock;
///是否支持服务城市
- (BOOL)NotSupport:(NSString *)adcode;
@end
