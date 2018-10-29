//
//  ThirdPartyViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ThirdPartyViewController.h"
#import <WXApi.h>
#import "UserModel.h"
#import "ProtocolKit.h"
@interface ThirdPartyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSArray * arrayText;
@property (nonatomic, strong) NSMutableArray * nameText;
@end

@implementation ThirdPartyViewController
- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (void)addlistTabelview
{
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = self.view.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdthirdBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdthirdQQ" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirdBindSuccess:) name:@"KdthirdBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQsuccess:) name:@"KdthirdQQ" object:nil];
    WS(weakSelf);
    [self leftBarButtonWithTitle:nil barImage:[UIImage imageNamed:@"icon-return"] action:^{
        BLOCK_EXEC(weakSelf.infoBlock);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.customTitle = NSLocalizedString(@"账户与安全",nil);
    _arrayText = @[NSLocalizedString(@"微信",nil),@"QQ"];
    [self loadDataCell];

    [self addlistTabelview];
    
    
    UIButton * logOutUser = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:logOutUser];
    [logOutUser activateConstraints:^{
        [logOutUser.left_attr equalTo:self.view.left_attr constant:25];
        [logOutUser.right_attr equalTo:self.view.right_attr constant:-25];
        logOutUser.height_attr.constant = 40;
        [logOutUser.bottom_attr equalTo:self.view.bottom_attr_safe constant:-58];
    }];
    logOutUser.titleLabel.font = fontStely(@"PingFangSC-Regular", 13);
    [logOutUser setTitle:NSLocalizedString(@"退出登录",nil) forState:UIControlStateNormal];
    [logOutUser setTitleColor:BlueColor forState:UIControlStateNormal];
    logOutUser.backgroundColor = [UIColor whiteColor];
    logOutUser.layer.cornerRadius = 20;
    logOutUser.layer.borderWidth = 1;
    logOutUser.layer.borderColor = BlueColor.CGColor;
    logOutUser.layer.masksToBounds = YES;
    [logOutUser addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
- (void)logOut
{
    //    [PattayaTool outLogin];
    [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerLogout AlerCallBlack:^(NSInteger index, NSString *titl) {
        if (index == 0) {
            [[PattayaUserServer singleton] logOutUserRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                if ([ResponseModel isData:ret]) {
                    [PattayaTool INVALID_ACCESS_TOKEN];
                    [GetAppDelegate getTabbarVC];
                    [PattayaTool chenkLogin:@""];
                } else
                {
                    [self showToast:ret[@"message"]];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            }];
        }
    }];
}
- (void)loadDataCell
{
    NSString * str1 = NSLocalizedString(@"已绑定",nil);
    NSString * str2 = NSLocalizedString(@"未绑定",nil);

    _nameText = [NSMutableArray array];
    if (_listUserSocial.count > 0) {
        
        if (_listUserSocial.count == 1) {
            NSDictionary * dicwecht = _listUserSocial[0];
            if ([dicwecht[@"socialType"] isEqualToString:@"WECHAT"]) {
                [_nameText addObject:str1];
                [_nameText addObject:str2];
            } else
            {
                [_nameText addObject:str2];
                [_nameText addObject:str1];
            }
        } else
        {
            //        NSDictionary * dicwecht = _listUserSocial[0];
            //        NSDictionary * dicQQ = _listUserSocial[1];
            [_nameText addObject:str1];
            [_nameText addObject:str1];
            
        }
    } else
    {
        [_nameText addObject:str2];
        [_nameText addObject:str2];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayText.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return NULL;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return NULL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 54, SCREEN_Width - 32, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [cell.contentView addSubview:lineView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _arrayText[indexPath.row];
    cell.detailTextLabel.text =  _nameText[indexPath.row];
    cell.textLabel.textColor = TextColor;
    cell.detailTextLabel.textColor = TextColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    //    cell.textLabel.text = @"ghjk";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    NSLog(@"%@",_listUserSocial);
    NSString * str = _nameText[indexPath.row];
    if (indexPath.row == 0) {
        if ([str isEqualToString:NSLocalizedString(@"已绑定",nil)]) {
            
            
            [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerLinkThird AlerCallBlack:^(NSInteger index, NSString *titl) {
                if (index == 0) {
                    for (NSDictionary * dic in _listUserSocial) {
                        if ([dic[@"socialType"] isEqualToString:@"WECHAT"]) {
                            [weakSelf deletedUnBind:@{@"openId":dic[@"openId"],@"socialType":@"WECHAT"}];
                        }
                    }
                }
            }];
            
         
        } else
        {
            ///绑定
//            [self thirdBindHttp:@{@"openId":dic[@"openId"],@"socialType":@"WECHAT"}];
            [self weChatLogin];
        }
        
    } else if (indexPath.row == 1)
    {
        if ([str isEqualToString:NSLocalizedString(@"已绑定",nil)]) {
            [RouterObject initWithDelegateRouter:[AlerViewShowUI alloc] EventType:AlerLinkThird AlerCallBlack:^(NSInteger index, NSString *titl) {
                if (index == 0) {
                for (NSDictionary * dic in _listUserSocial) {
                    if ([dic[@"socialType"] isEqualToString:@"QQ"]) {
                        [weakSelf deletedUnBind:@{@"openId":dic[@"openId"],@"socialType":@"QQ"}];
                    }
                    }
                }
            }];
            
        } else
        {
            ///绑定
            [self QQLogin];
            
        }
    }
    
}
- (void)QQLogin
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [GetAppDelegate.tencentOAuth setAuthShareType:AuthShareType_QQ];
    [GetAppDelegate.tencentOAuth authorize:permissions inSafari:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deletedUnBind:(NSDictionary *)dic
{
    [[PattayaUserServer singleton] deleteDunBindOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        if ([ResponseModel isData:ret]) {
            [self userInfoHttp];
        } else
        {
            [self showToast:ret[@"messages"]];
        }
        [_tableview reloadData];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)thirdBindHttp:(NSDictionary *)dic
{
    [[PattayaUserServer singleton]thirdBinOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
           
            [self userInfoHttp];
            
        } else
        {
            [self showToast:ret[@"messages"]];
        }
//        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
- (void)weChatLogin
{
    SendAuthReq * reques = [[SendAuthReq alloc]init];
    reques.scope = @"snsapi_userinfo";
    reques.state = @"iOSPattaya-user";
    if ([WXApi isWXAppInstalled]) {
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:reques];
    } else
    {
        [GetAppDelegate sendAuthReq:reques viewController:self];
    }
}
- (void)thirdBindSuccess:(NSNotification *)info
{
    //
    WS(weakSelf);
    [[PattayaUserServer singleton] WeChatCodeRequest:info.object[@"code"] success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            [weakSelf thirdBindHttp:@{@"openId":ret[@"data"][@"openId"],@"socialType":@"WECHAT",@"nickName":ret[@"data"][@"nickname"],@"headImgUrl":ret[@"data"][@"headImgUrl"]}];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)QQsuccess:(NSNotification *)info
{

    NSDictionary * dic = info.object[@"QQ"];
    [self thirdBindHttp:@{@"openId":GetAppDelegate.tencentOAuth.openId,@"socialType":@"QQ",@"nickName":dic[@"nickname"],@"headImgUrl":dic[@"figureurl_qq_2"]}];

}


- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            UserModel * mode = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
            _listUserSocial = [NSMutableArray array];
            _listUserSocial = mode.userSocialLinks;
            [self loadDataCell];

        } else
        {
            [self showToast:ret[@"message"]];
        }
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
