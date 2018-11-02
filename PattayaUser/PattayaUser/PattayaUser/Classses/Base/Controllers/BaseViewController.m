//
//  BaseViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//
#define BAR_BUTTON_FONT         [UIFont systemFontOfSize:14.]

#import "BaseViewController.h"
#import <objc/runtime.h>
#import "PattayaTool.h"
#import "DD_Alertview.h"
#import "UIViewController+util.h"

@interface BaseViewController ()



@end

@implementation BaseViewController
static char buttonActionBlockKey;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewControllerWillAppear];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self viewControllerWillDisappear];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleViewController];
    if (self != [self.navigationController.viewControllers firstObject]) {
        __weak typeof(self) weakSelf = self;
        [self leftBarButtonWithTitle:nil barImage:[UIImage imageNamed:@"icon-return"] action:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self createTitleLabel];
    // Do any additional setup after loading the view.
}
//左按钮返回键
- (void)leftBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void (^)(void))actionBlock{
    UIButton *button = [self buttonWithTitle:title buttonImage:image];
    button.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.leftBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}
/** 右边按钮 */
- (void)rightBarButtonWithTitle:(NSString *)title barImage:(UIImage *)image action:(void (^)(void))actionBlock{
    
    UIButton *button = [self buttonWithTitle:title buttonImage:image];
    self.rightBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
- (void)itemRightBarButtonWithbarImage:(NSArray *)image action:(void (^)(void))actionBlock share:(void (^)(void))shareBlock{
    UIButton *button = [self buttonWithTitle:nil buttonImage:image[1]];
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *button1 = [self buttonWithTitle:nil buttonImage:image[0]];
    objc_setAssociatedObject(button1, &buttonActionBlockKey, shareBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItems =@[barButtonItem,barButtonItem1];
    //    [self.navigationItem setRightBarButtonItems:];
}
- (void)rightBarButtonWithTitle:(NSString *)title color:(UIColor *)color action:(void (^)(void))actionBlock{
    
    UIButton *button = [self buttonWithTitle:title buttonImage:nil];
    button.bounds = CGRectMake(0, 0, 32, 30);
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [button setTitleColor:color forState:UIControlStateNormal];
    self.rightBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color barImage:(UIImage *)image action:(void (^)(void))actionBlock{
    
    UIButton *button = [self buttonWithTitle:title buttonImage:image];
    button.frame = CGRectMake(0, 0, 66, 16);
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    self.rightBtn=button;
    objc_setAssociatedObject(button, &buttonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (UIButton *)buttonWithTitle:(NSString *)title buttonImage:(UIImage *)image{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.widthBee = 60;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    button.tintColor=[UIColor colorWithHexString:@"E61C62"];
    button.tintColor=[UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = BAR_BUTTON_FONT;
    [button sizeToFit];
    
    return button;
}

- (void)actionButtonClicked:(UIButton *)sender{
    
    void (^actionBlock) (void) = objc_getAssociatedObject(sender, &buttonActionBlockKey);
    actionBlock();
}
- (void)createTitleLabel {
    
    //Create custom label for titleView
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_Width-208, 40)];
    NSString *title = [PattayaTool isNull:self.title]? self.customTitle : self.title;
    _titleLabel.text = title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.textColor = UIColorWhite;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = self.titleLabel;
}

-(void)setCustomTitle:(NSString *)customTitle
{
    
    _customTitle = customTitle;
    _titleLabel.text = customTitle;
    _titleLabel.textColor = UIColorWhite;
}

-(void)showToast:(NSString *)message
{
    if (![PattayaTool isNull:message]) {
        
        [self showMessage:message toView:GetAppDelegate.window];
    } else
    {
        [self showMessage:NSLocalizedString(@"暂无数据",nil) toView:GetAppDelegate.window];
        
    }
}
/*
 根据需要可以自定义其sleep时间，显示位置，提示语mode。下面添加适配器方法即可。
 */
- (void)showMessage:(NSString *)message toView:(UIView *)myView
{
    
    //    [myView makeToast:message duration:3.0 position:@"center"];
    
    __block MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:myView];
    [myView addSubview:hud];
    hud.cornerRadius = 0;
    hud.detailsLabelText = message;
    
    hud.yOffset = -50;
    hud.color = [PattayaTool colorWithHexString:@"111D2D" Alpha:0.8] ;
    hud.mode = MBProgressHUDModeText;
    hud.labelColor = [UIColor whiteColor];
    hud.alpha = 0.8f;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(3);
    } completionBlock:^{
        [hud removeFromSuperview];
        hud = nil;
    }];
}
- (void)showMessage:(NSString *)message image:(NSString *)imageName toView:(UIView *)myView
{
    __block MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:myView];
    [myView addSubview:hud];
    CGFloat padding = 73.0f;
    hud.cornerRadius = 0;
    hud.minSize = CGSizeMake(myView.wBee-padding*2, 100);
    hud.detailsLabelText = message;
    hud.yOffset = -50;
    hud.color = [PattayaTool colorWithHexString:@"111D2D" Alpha:0.8];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelColor = [UIColor whiteColor];
    hud.alpha = 0.8f;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(3);
    } completionBlock:^{
        [hud removeFromSuperview];
        hud = nil;
    }];
}


- (void)add_TableviewRefreshHeader:(UITableView *)tableview refrshBlack:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.footer resetNoMoreData];
//        [tableview.mj_header endRefreshing];

        refreshingBlock();

        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    self.header.lastUpdatedTimeLabel.hidden = YES;
    self.header.stateLabel.textColor = TextGrayColor;
    tableview.mj_header  = self.header;
    
    
}
- (void)add_TableviewRefreshfoorte:(UITableView *)tableview refrshBlack:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        refreshingBlock();
        
//        [tableview.mj_footer endRefreshing];
//        tableview.mj_footer.state =  MJRefreshStateNoMoreData;
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.footer.automaticallyChangeAlpha = YES;
    self.footer.stateLabel.hidden = NO;
    // 隐藏时间
    //    self.footer.lastUpdatedTimeLabel.hidden = YES;
    self.footer.refreshingTitleHidden =YES;
    self.footer.stateLabel.textColor = TextGrayColor;
    tableview.mj_footer  = self.footer;
    
}
- (BOOL)NotSupport:(NSString *)adcode
{
    BOOL nonsupport = [GetAppDelegate.cityModel cityService:adcode];
    if (nonsupport == NO) {
        DD_Alertview * alertview = [[DD_Alertview alloc] initWithFrame:self.view.bounds stlyeView:DD_AlertviewStlyeNonSopport navStatusHeight:0];
        [alertview show];
        alertview.locationLaber.text = NSLocalizedString(@"您当前所在的城市",nil);
        alertview.timeLaber.text = NSLocalizedString(@"暂未开通此服务哦，敬请期待～",nil);
    }
    return nonsupport;
}


//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
  return  [self StatusBarStyle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
