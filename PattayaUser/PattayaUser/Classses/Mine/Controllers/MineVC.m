//
//  MineVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "MineVC.h"
#import "AddressListVC.h"
#import "AboutVC.h"
#import "AccountSafeVC.h"
#import "UserViewController.h"
#import "ThirdPartyViewController.h"
#import "UserModel.h"
#import "MessageVC.h"

#define TITLES @[@"常用地址",@"账户安全",@"关于打店"]
#define ICONS  @[@"mine_location",@"mine_safe",@"mine_about"]

@interface MineVC ()

//导航栏按钮
@property (nonatomic, strong) UIButton *rightPopBT;

///头部视图
@property (nonatomic,strong) UIView *headBgView;
///头像
@property (nonatomic,strong) UIImageView *headImg;
///头像
@property (nonatomic,strong) UILabel *nameLabel;
///名字
@property (nonatomic,strong) UILabel *numberLabel;

///电话号码
@property (nonatomic,strong) UIImageView *advImg;

///底部
@property (nonatomic,strong) UIView *bottomBgView;


@property (nonatomic,strong) UserModel * userModel;
@end

@implementation MineVC

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self netRequestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoHttp) name:@"KdUserInfoHtppLoad" object:nil];
    
}

-(void)setupUI{
    [super setupUI];
    self.navigationItem.title = @"我的";
    //导航栏
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:self.rightPopBT];
    self.navigationItem.rightBarButtonItem=rightitem;
    
    //headBgView
    _headBgView = [[UIView alloc]init];
    _headBgView.backgroundColor = UIColorWhite;
    [self.view addSubview:self.headBgView];
    [_headBgView activateConstraints:^{
        [_headBgView.left_attr equalTo:self.view.left_attr];
        [_headBgView.right_attr equalTo:self.view.right_attr];
        [_headBgView.top_attr equalTo:self.view.top_attr constant:IPhone_7_Scale_Height(10)];
        _headBgView.height_attr.constant = IPhone_7_Scale_Height(90);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToCountSafe:)];
    [_headBgView addGestureRecognizer:tap];
    //头像
    _headImg = [[UIImageView alloc]init];
    _headImg.image = [UIImage imageNamed:@"main_cell_headImg_bg"];
    [self.headBgView addSubview:self.headImg];
    [_headImg activateConstraints:^{
        [_headImg.left_attr equalTo:self.headBgView.left_attr constant:IPhone_7_Scale_Width(12)];
        _headImg.height_attr.constant = IPhone_7_Scale_Height(52);
        _headImg.width_attr.constant = IPhone_7_Scale_Height(52);
        _headImg.centerY_attr = _headBgView.centerY_attr;
    }];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = K_LABEL_SMALL_FONT_16;
    _nameLabel.textColor = TextColor;
   // _nameLabel.text = @"Yvonne";
    [_nameLabel sizeToFit];
    [self.headBgView addSubview: _nameLabel];
    [_nameLabel activateConstraints:^{
        [_nameLabel.left_attr equalTo:_headImg.right_attr constant:IPhone_7_Scale_Width(20)];
        _nameLabel.height_attr.constant = IPhone_7_Scale_Height(26);
        _nameLabel.top_attr = _headImg.top_attr;
    }];
    
    //电话号码
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = K_LABEL_SMALL_FONT_12;
    _numberLabel.textColor = TextColor;
    //_numberLabel.text = @"15071047088";
    [_numberLabel sizeToFit];
    [self.headBgView addSubview: _numberLabel];
    [_numberLabel activateConstraints:^{
        [_numberLabel.left_attr equalTo:_headImg.right_attr constant:IPhone_7_Scale_Width(20)];
        _numberLabel.height_attr.constant = IPhone_7_Scale_Height(26);
        _numberLabel.bottom_attr = _headImg.bottom_attr;
    }];
    
    //箭头
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [self.headBgView addSubview:arrow];
    [arrow activateConstraints:^{
        [arrow.right_attr equalTo:_headBgView.right_attr constant:IPhone_7_Scale_Width(-12)];
        arrow.centerY_attr = _headBgView.centerY_attr;
        arrow.height_attr.constant = IPhone_7_Scale_Width(11);
        arrow.width_attr.constant = IPhone_7_Scale_Width(11);
    }];
    
    //广告
    _advImg = [[UIImageView alloc]init];
    _advImg.image = [UIImage imageNamed:@"main_adv_4"];
     [self.view addSubview:self.advImg];
    [_advImg activateConstraints:^{
        [_advImg.top_attr equalTo:_headBgView.bottom_attr constant:IPhone_7_Scale_Height(10)];
        _advImg.width_attr.constant = IPhone_7_Scale_Width(350);
        _advImg.height_attr.constant = IPhone_7_Scale_Width(80);
        _advImg.centerX_attr = self.view.centerX_attr;
    }];
    
    //底部视图
    _bottomBgView = [[UIView alloc]init];
    _bottomBgView.backgroundColor = UIColorWhite;
      [self.view addSubview:self.bottomBgView];
    [_bottomBgView activateConstraints:^{
        [_bottomBgView.left_attr equalTo:self.view.left_attr];
        [_bottomBgView.right_attr equalTo:self.view.right_attr];
        [_bottomBgView.top_attr equalTo:self.advImg.bottom_attr constant:IPhone_7_Scale_Height(10)];
        _bottomBgView.height_attr.constant = IPhone_7_Scale_Height(118);
    }];
  
    //工具箱
    UILabel *toolsLabel = [[UILabel alloc] init];
    toolsLabel.font = K_LABEL_SMALL_FONT_16;
    toolsLabel.textColor = TextColor;
    toolsLabel.text = @"工具箱";
    [toolsLabel sizeToFit];
    [self.bottomBgView addSubview: toolsLabel];
    [toolsLabel activateConstraints:^{
        [toolsLabel.left_attr equalTo:_bottomBgView.left_attr constant:IPhone_7_Scale_Width(12)];
        toolsLabel.height_attr.constant = IPhone_7_Scale_Height(22);
        [toolsLabel.top_attr equalTo:_bottomBgView.top_attr constant:IPhone_7_Scale_Height(9)];

    }];
    CGFloat margin = (SCREEN_Width - IPhone_7_Scale_Height(28)*5 - IPhone_7_Scale_Width(24)*2)/4;
    //icon
    for (int i = 0; i < 3; i++) {
        UIButton *iconBT= [[UIButton alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(24) + i*(margin + IPhone_7_Scale_Height(28)), toolsLabel.YD_bottom + IPhone_7_Scale_Height(26), IPhone_7_Scale_Height(28), IPhone_7_Scale_Height(28))];
        [iconBT setImage:[UIImage imageNamed:ICONS[i]] forState:UIControlStateNormal];
        [iconBT setImage:[UIImage imageNamed:ICONS[i]] forState:UIControlStateNormal];
        iconBT.tag = i;
        [iconBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomBgView addSubview:iconBT];
        
        UILabel *title = [[UILabel alloc]init];
        title.text = TITLES[i];
        title.font = K_LABEL_SMALL_FONT_12;
        title.textColor = TextColor;
        [title sizeToFit];
        [self.bottomBgView addSubview:title];
        [title activateConstraints:^{
            [title.top_attr equalTo:iconBT.bottom_attr constant:IPhone_7_Scale_Height(10)];
            title.height_attr.constant = IPhone_7_Scale_Height(17);
            title.centerX_attr = iconBT.centerX_attr;
        }];
        
    }

}

-(void)netRequestData{
    [self userInfoHttp];
}

#pragma mark - 获取用户数据
- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            _userModel = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
            self.nameLabel.text = _userModel.userName;
            self.numberLabel.text = _userModel.maskMobile;
            NSString *url = (_userModel.headImgUrl) ? (_userModel.headImgUrl) : (_userModel.userSocialLinks.count > 0 ? _userModel.userSocialLinks[0][@"headImgUrl"] : @"");
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
//            _socialArray = [NSMutableArray array];
//            _socialArray = mode.userSocialLinks;
//            [_headview.userImg sd_setImageWithURL:[NSURL URLWithString:mode.headImgUrl] placeholderImage:[UIImage imageNamed:@"boy"]];
            [PattayaTool loginSavename:_userModel.userName mobile:_userModel.mobile];
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark - 常用地址 账户安全 关于打店
-(void)btnClick:(UIButton*)btn{
   
    
    NSLog(@"%@",TITLES[btn.tag]);
    if (btn.tag == 0) {
        AddressListVC *vc = [[AddressListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (btn.tag == 1){
        
        AccountSafeVC *vc = [[AccountSafeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (btn.tag == 2){
        
        AboutVC *vc = [[AboutVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(void)pushToCountSafe:(UITapGestureRecognizer *)tap{
    AccountSafeVC *vc = [[AccountSafeVC alloc]init];
    vc.userModel = _userModel;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 导航栏按钮
-(UIButton*)rightPopBT{
    if (!_rightPopBT) {
        
        _rightPopBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightPopBT addTarget:self action:@selector(pushMessageVC) forControlEvents:UIControlEventTouchUpInside];
        [_rightPopBT setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        [_rightPopBT setImage:[UIImage imageNamed:@"news_null"] forState:UIControlStateSelected];
    }
    return _rightPopBT;
}

#pragma mark - 推送消息
-(void)pushMessageVC{
    
    MessageVC *vc = [[MessageVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
