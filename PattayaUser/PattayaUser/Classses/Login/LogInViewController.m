//
//  LogInViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "WebHelpViewController.h"
#import "LogInViewController.h"
#import <WXApi.h>
#import "UserModel.h"
#import "WeChatViewController.h"
#import "OtherLogins.h"
@interface LogInViewController ()<UITextFieldDelegate,OtherLoginsDelegate>
//@property (nonatomic, strong) UILabel * titleLaber;
//@property (nonatomic, strong) UILabel * titleDetails;
@property (nonatomic, strong) UITextField * moblieName;
@property (nonatomic, strong) UITextField * codeField;
@property (nonatomic, strong) UIButton * codeBtn;
@property (nonatomic, strong) UIButton * logInBtn;
@property (nonatomic, assign) NSInteger timeNumber;
@property (nonatomic, assign) BOOL isCode;
@property (nonatomic, strong) UserModel * wechatModel;
@end

@implementation LogInViewController
- (void)dealloc
{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [OtherLogins removeNotification];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logintypeSuccess:) name:KdLOGINTPYE object:self];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logintypeSuccess:) name:KdLOGINTPYE object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQlogintype:) name:@"KdQQlogin" object:nil];
    
    [OtherLogins registerOtherLoginsSuccess];
    [OtherLogins singleton].Loginsdelegate = self;
    _timeNumber = 60;
    _isCode = NO;
    self.title = @"登录叮咚打车";
    [self rightBarButtonWithTitle:nil barImage:[UIImage imageNamed:@"nav_cancel"] action:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    _moblieName = [[UITextField alloc]init];
    [self.view addSubview:_moblieName];
    [_moblieName activateConstraints:^{
        [_moblieName.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(15)];
        [_moblieName.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-15)];
        [_moblieName.top_attr equalTo:self.view.top_attr_safe constant:12];
        _moblieName.height_attr.constant = 45.5;
    }];
    _moblieName.placeholder = @"请输入手机号";
    _moblieName.keyboardType = UIKeyboardTypePhonePad;
    _moblieName.font = fontStely(@"PingFangSC-Regular", 14);
    UILabel * leftViewField = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40 + 20, 45.5)];
    leftViewField.textAlignment = NSTextAlignmentLeft;
    leftViewField.textColor = TextColor;
    leftViewField.text = @"+86";
    leftViewField.font = fontStely(@"PingFangSC-Regular", 14);
    
    _moblieName.leftViewMode = UITextFieldViewModeAlways;
    _moblieName.leftView = leftViewField;
    UIView * line = [[UIView alloc]init];
    [self.view addSubview:line];
    [line activateConstraints:^{
        line.left_attr = _moblieName.left_attr;
        line.right_attr = _moblieName.right_attr;
        line.height_attr.constant = 1.5;
        [line.top_attr equalTo:_moblieName.bottom_attr constant:12];
    }];
    line.backgroundColor = UIColorFromRGB(0xEBEBEB);
    
    _codeField = [[UITextField alloc]init];
    [self.view addSubview:_codeField];
    [_codeField activateConstraints:^{
        [_codeField.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(15)];
        [_codeField.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-15)];
        [_codeField.top_attr equalTo:line.bottom_attr constant:12];
        _codeField.height_attr.constant = 45.5;
    }];
    _codeField.keyboardType = UIKeyboardTypePhonePad;
    _codeField.placeholder = @"请输入验证码";
    _codeField.font = fontStely(@"PingFangSC-Regular", 14);
    UILabel * leftViewFieldCode = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40+20, 45.5)];
    leftViewFieldCode.textAlignment = NSTextAlignmentLeft;
    leftViewFieldCode.textColor = TextColor;
    leftViewFieldCode.text = NSLocalizedString(@"验证码",nil);
    leftViewFieldCode.font = fontStely(@"PingFangSC-Regular", 14);
    
    _codeField.leftViewMode = UITextFieldViewModeAlways;
    _codeField.leftView = leftViewFieldCode;
    //    _codeField.delegate = self;
    
    UIView * linecode = [[UIView alloc]init];
    [self.view addSubview:linecode];
    [linecode activateConstraints:^{
        linecode.left_attr = _codeField.left_attr;
        linecode.right_attr = _codeField.right_attr;
        linecode.height_attr.constant = 1.5;
        [linecode.top_attr equalTo:_codeField.bottom_attr constant:12];
    }];
    linecode.backgroundColor = UIColorFromRGB(0xEBEBEB);
    
    
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_codeBtn];
    [_codeBtn activateConstraints:^{
        [_codeBtn.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-15)];
        _codeBtn.height_attr.constant = IPhone_7_Scale_Height(30);
        _codeBtn.width_attr.constant = IPhone_7_Scale_Width(72);
        _codeBtn.centerY_attr =_moblieName.centerY_attr;
    }];
    [_codeBtn setTitle:NSLocalizedString(@"获取验证码",nil) forState:UIControlStateNormal];
    [_codeBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _codeBtn.backgroundColor = App_Nav_BarDefalutColor;
    _codeBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    _codeBtn.layer.cornerRadius = 2;
    _codeBtn.layer.masksToBounds = YES;
    [_codeBtn addTarget:self action:@selector(clikeCode) forControlEvents:UIControlEventTouchUpInside];
    
    _logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_logInBtn];
    [_logInBtn activateConstraints:^{
        [_logInBtn.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-62)];
        _logInBtn.height_attr.constant = 40;
        [_logInBtn.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(62)];
        [_logInBtn.top_attr equalTo:linecode.bottom_attr constant:40];
    }];
    [_logInBtn setTitle:NSLocalizedString(@"登录",nil) forState:UIControlStateNormal];
    [_logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _logInBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 16);
    _logInBtn.backgroundColor = UIColorFromRGB(0xF4F4F4);
    _logInBtn.layer.cornerRadius = 20;
    [_logInBtn addTarget:self action:@selector(logInGo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *  textlabe = [[UILabel alloc] init];
    [self.view addSubview:textlabe];
    [textlabe activateConstraints:^{
        [textlabe.left_attr equalTo:self.view.left_attr];
        [textlabe.right_attr equalTo:self.view.right_attr];
        textlabe.height_attr.constant = 15;
        [textlabe.top_attr equalTo:_logInBtn.bottom_attr constant:10];
    }];
    textlabe.font = fontStely(@"PingFangSC-Regular", 10);
    textlabe.textColor = App_Nav_BarDefalutColor;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"登录即代表您已同意《叮咚打店用户协议》"];
    [aString addAttribute:NSForegroundColorAttributeName value:TextGrayColor range:NSMakeRange(0,9)];
    textlabe.attributedText = aString;
    textlabe.textAlignment = NSTextAlignmentCenter;
    textlabe.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLaberAction:)];
    [textlabe addGestureRecognizer:tap];
    
    
    
    UILabel *  wechatQQtext = [[UILabel alloc] init];
    [self.view addSubview:wechatQQtext];
    [wechatQQtext activateConstraints:^{
        [wechatQQtext.left_attr equalTo:self.view.left_attr];
        [wechatQQtext.right_attr equalTo:self.view.right_attr];
        wechatQQtext.height_attr.constant = IPhone_7_Scale_Height(20);
        [wechatQQtext.top_attr equalTo:textlabe.bottom_attr constant:IPhone_7_Scale_Height(95)];
    }];
    wechatQQtext.font = fontStely(@"PingFangSC-Regular", 14);
    wechatQQtext.textColor = TextColor;
    wechatQQtext.text = @"或其他账号登录";
    wechatQQtext.textAlignment = NSTextAlignmentCenter;
    
    UIButton * wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview: wechatBtn];
    [wechatBtn activateConstraints:^{
        [wechatBtn.top_attr equalTo:wechatQQtext.bottom_attr constant:IPhone_7_Scale_Height(24)];
        [wechatBtn.left_attr equalTo:self.view.left_attr_safe constant:IPhone_7_Scale_Width(90)];
        wechatBtn.height_attr.constant = IPhone_7_Scale_Width(55);
        wechatBtn.width_attr.constant = IPhone_7_Scale_Width(55);
    }];
    [wechatBtn setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    
    UILabel *  wechatLabel = [[UILabel alloc] init];
    [self.view addSubview:wechatLabel];
    [wechatLabel activateConstraints:^{
        [wechatLabel.centerX_attr equalTo:wechatBtn.centerX_attr];
        wechatLabel.width_attr.constant = wechatBtn.width_attr.constant + 5;
        wechatLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        [wechatLabel.top_attr equalTo:wechatBtn.bottom_attr constant:IPhone_7_Scale_Height(12)];
    }];
    wechatLabel.font = fontStely(@"PingFangSC-Regular", 14);
    wechatLabel.textColor = TextColor;
    wechatLabel.text = @"微信登录";
    wechatLabel.textAlignment = NSTextAlignmentCenter;

    
    UIButton * QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview: QQBtn];
    [QQBtn activateConstraints:^{
        QQBtn.centerY_attr = wechatBtn.centerY_attr;
        [QQBtn.right_attr equalTo:self.view.right_attr_safe constant:IPhone_7_Scale_Width(-90)];
        QQBtn.height_attr = wechatBtn.height_attr;
        QQBtn.width_attr = wechatBtn.width_attr;
    }];
    [QQBtn setImage:[UIImage imageNamed:@"login_QQ"] forState:UIControlStateNormal];
    
    UILabel *  QQLabel = [[UILabel alloc] init];
    [self.view addSubview:QQLabel];
    [QQLabel activateConstraints:^{
        [QQLabel.left_attr equalTo:QQBtn.left_attr];
        QQLabel.width_attr = QQBtn.width_attr;
        QQLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        [QQLabel.top_attr equalTo:QQBtn.bottom_attr constant:IPhone_7_Scale_Height(12)];
    }];
    QQLabel.font = fontStely(@"PingFangSC-Regular", 14);
    QQLabel.textColor = TextColor;
    QQLabel.text = @"QQ登录";
    QQLabel.textAlignment = NSTextAlignmentCenter;
    
    [wechatBtn addTarget:self action:@selector(weChatLogin) forControlEvents:UIControlEventTouchUpInside];
    [QQBtn addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchUpInside];
    [_moblieName addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [_codeField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
  
}
-(void)textValueChanged{
    if (_moblieName.text.length != 0 && _codeField.text.length != 0) {
        _logInBtn.backgroundColor = App_Nav_BarDefalutColor;
    }else{
        _logInBtn.backgroundColor = UIColorFromRGB(0xF4F4F4);
    }
    if (_moblieName.text.length > 11) {
        _moblieName.text = [_moblieName.text substringWithRange:NSMakeRange(0, 11)];
    }
}


- (void)logInGo:(UIButton *)btn
{
    NSLog(@"登录");
    if (_isCode) {
        if ([PattayaTool isNull:_codeField.text]) {
            [YDProgressHUD showMessage:@"验证码不能为空"];
            return;
        }
        _logInBtn.enabled = NO;
        [self loginHttp:@{@"mobile":_moblieName.text,@"messageAlias":@"PUB_SIGNIN",@"verifyCode":_codeField.text,@"deviceType":@"IOS",@"deviceToken":_moblieName.text}];
        
    } else
    {
        _logInBtn.enabled = YES;
        [YDProgressHUD showMessage:@"请先获取验证码"];

    }
    
    
}
- (void)timeNumss{
    __block NSInteger second = _timeNumber;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                _codeBtn.enabled = YES;
                [_codeBtn setTitle:NSLocalizedString(@"获取验证码",nil) forState:UIControlStateNormal];
                [_codeBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                
                second = _timeNumber;
                //(6)
                dispatch_cancel(timer);
            } else {
                
                _codeBtn.enabled = NO;
                [_codeBtn setTitle:[NSString stringWithFormat:@"(%lds)",(long)second] forState:UIControlStateNormal];
                [_codeBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
    
}
- (void)clikeCode
{
    if ([PattayaTool isNull:_moblieName.text]) {
        [YDProgressHUD showMessage:@"手机号码不能为空"];
        return;
    }
    _codeBtn.enabled = NO;
    
    [[PattayaUserServer singleton] sendVerifyCodeRequest:@{@"mobile":_moblieName.text,@"alias":@"PUB_SIGNIN",@"messageType":@"TEXT"} success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            
            [_codeField becomeFirstResponder];
            [self timeNumss];
            
            _isCode = YES;
        } else
        {
            _codeBtn.enabled = YES;
            [YDProgressHUD showMessage:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        _codeBtn.enabled = YES;
        
    }];
}

- (void)loginHttp:(NSDictionary *)dic
{
    [[PattayaUserServer singleton] loginOrRegisterToken:dic Requestsuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        _logInBtn.enabled = YES;
        ResponseModel * req = [[ResponseModel alloc] initWithDictionary:ret error:nil];
        if ([ResponseModel isData:ret]) {
            [PattayaTool loginSaveToken:ret[@"data"]];
            [PattayaTool chenkLogin:@"yes"];
            [self userInfoHttp];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];
            //            [GetAppDelegate getTabbarVC];
        } else if([req.code isEqualToString:@"OPEN_ID_NOT_BINDED"])
        {
            WeChatViewController * vc = [[WeChatViewController alloc] init];
            vc.model = _wechatModel;
            [self.navigationController pushViewController:vc animated:YES];
        } else
        {
            _logInBtn.enabled = YES;
            
            [YDProgressHUD showMessage:req.message];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        _logInBtn.enabled = YES;
        
    }];
}
- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            UserModel * mode = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
            [PattayaTool loginSavename:mode.userName mobile:mode.mobile];
            //            [self saveToken:mode.mobile];
            [self dismissViewControllerAnimated:YES completion:nil];
            [JPUSHService setAlias:mode.mobile completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                
                if (iResCode == 0) {
                    NSLog(@"设置Alias注册成功");
                } else
                {
                    NSLog(@"失败------!!!!");
                }
            } seq:1];
            
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (void)backViewPop:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)weChatLogin
{
    [OtherLogins weChatLogin:self];
}


- (void)QQLogin
{
    [OtherLogins QQLogin];
}
- (void)textLaberAction:(UITapGestureRecognizer *)tap
{
    WebHelpViewController * webVC = [[WebHelpViewController alloc] init];
    webVC.httpString = @"https://www.callstore.cn/policies/user-agreements/";
    webVC.title = NSLocalizedString(@"用户协议",nil);
    [self.navigationController pushViewController:webVC animated:YES];
}
///第三方登录回调
- (void)otherSuccess:(NSInteger)typ NSNotification:(NSDictionary *)info
{
    if (typ == 1)
    {
        
        _wechatModel = [[UserModel alloc] initWithDictionary:info error:nil];
        _wechatModel.loginType = @"WECHAT";
        [self loginHttp:@{@"loginType":_wechatModel.loginType,@"openId":_wechatModel.openId,@"nickName":_wechatModel.nickname,@"unionId":_wechatModel.unionId,@"headImgUrl":_wechatModel.headImgUrl,@"sex":_wechatModel.sex,@"deviceType":@"IOS"}];
        
    }else
    {
        _wechatModel = [[UserModel alloc] init];
        _wechatModel.loginType = @"QQ";
        _wechatModel.openId = GetAppDelegate.tencentOAuth.openId;
        _wechatModel.nickname = info[@"nickname"];
        _wechatModel.headImgUrl = info[@"headImgUrl"];
        [self loginHttp:@{@"loginType":_wechatModel.loginType,@"openId":_wechatModel.openId,@"nickName":_wechatModel.nickname,@"headImgUrl":_wechatModel.headImgUrl,@"deviceType":@"IOS"}];
    }
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
