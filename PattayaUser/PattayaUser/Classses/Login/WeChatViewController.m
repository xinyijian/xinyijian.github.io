//
//  WeChatViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/2.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "WeChatViewController.h"
#import "WebHelpViewController.h"
@interface WeChatViewController ()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel * UserName;
@property (nonatomic, strong) UILabel * titleLaber;
@property (nonatomic, strong) UILabel * titleDetails;


@property (nonatomic, strong) UILabel * tipLabel;//提示信息
@property (nonatomic, strong) UITextField * moblieName;
@property (nonatomic, strong) UITextField * codeField;
@property (nonatomic, strong) UIButton * codeBtn;
@property (nonatomic, strong) UIButton * logInBtn;
@property (nonatomic, assign) NSInteger timeNumber;


@property (nonatomic, assign) BOOL isCode;
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isCode = NO;
    _timeNumber = 60;
    self.title = @"绑定手机号";
//    [self rightBarButtonWithTitle:nil barImage:[UIImage imageNamed:@"nav_cancel"] action:^{
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
//    }];
//    _headImg = [[UIImageView alloc] init];
//    [self.view addSubview:_headImg];
//    [_headImg activateConstraints:^{
//        [_headImg.top_attr equalTo:self.view.top_attr_safe constant:15];
//        _headImg.height_attr.constant = 55;
//        _headImg.width_attr.constant = 55;
//        [_headImg.centerX_attr equalTo:self.view.centerX_attr];
//    }];
//    _headImg.layer.cornerRadius = 27.5;
//    _headImg.layer.masksToBounds = YES;
//    [_headImg sd_setImageWithURL:[NSURL URLWithString:_model.headImgUrl] placeholderImage:[UIImage imageNamed:@"boy"]];
    
//    _UserName = [[UILabel alloc] init];
//    [self.view addSubview: _UserName];
//    [_UserName activateConstraints:^{
//        [_UserName.top_attr equalTo:_headImg.bottom_attr constant:7];
//        _UserName.height_attr.constant = 16.5;
//        [_UserName.left_attr equalTo:self.view.left_attr];
//        [_UserName.right_attr equalTo:self.view.right_attr];
//    }];
//    _UserName.textAlignment = NSTextAlignmentCenter;
//    _UserName.textColor = TextColor;
//    _UserName.font = fontStely(@"PingFangSC-Regular", 12);
//    _UserName.text = NSLocalizedString(@"昵称",nil);
//    _UserName.text = _model.nickname;
    
    
//    _titleLaber = [[UILabel alloc]init];
//    [self.view addSubview: _titleLaber];
//    [_titleLaber activateConstraints:^{
//        [_titleLaber.top_attr equalTo:_UserName.bottom_attr constant:14];
//        [_titleLaber.left_attr equalTo:self.view.left_attr constant:0];
//        [_titleLaber.right_attr equalTo:self.view.right_attr constant:0];
//        _titleLaber.height_attr.constant = 30;
//    }];
//    _titleLaber.text = NSLocalizedString(@"手机验证",nil);
//    _titleLaber.textColor = TextColor;
//    _titleLaber.textAlignment = NSTextAlignmentCenter;
//    _titleLaber.font = fontStely(@"PingFangSC-Medium", 21);
    
    
    
//    _titleDetails= [[UILabel alloc]init];
//    [self.view addSubview: _titleDetails];
//    [_titleDetails activateConstraints:^{
//        [_titleDetails.top_attr equalTo:_titleLaber.bottom_attr constant:11.5];
//        [_titleDetails.left_attr equalTo:self.view.left_attr constant:0];
//        [_titleDetails.right_attr equalTo:self.view.right_attr constant:0];
//        _titleDetails.height_attr.constant = 18.5;
//    }];
//    if ([_model.loginType isEqualToString:@"WECHAT"]) {
//
//        _titleDetails.text = NSLocalizedString(@"您在微信登录后仍然需要绑定手机号码",nil);
//    } else
//    {
//        _titleDetails.text = NSLocalizedString(@"您在QQ登录后仍然需要绑定手机号码",nil);
//
//    }
//    _titleDetails.textColor = TextColor;
//    _titleDetails.textAlignment = NSTextAlignmentCenter;
//    _titleDetails.font = fontStely(@"PingFangSC-Regular", 13);
    
    //提示信息
        _tipLabel = [[UILabel alloc]init];
        [self.view addSubview: _tipLabel];
        [_tipLabel activateConstraints:^{
            [_tipLabel.top_attr equalTo:self.view.top_attr constant:0];
            [_tipLabel.left_attr equalTo:self.view.left_attr constant:0];
            [_tipLabel.right_attr equalTo:self.view.right_attr constant:0];
            _tipLabel.height_attr.constant = 36;
        }];
        _tipLabel.text = @"为使用应用全部功能，需要先绑定您的手机号";
        _tipLabel.textColor = App_Nav_BarDefalutColor;
        _tipLabel.backgroundColor = UIColorFromRGB(0xEBF5FF);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = fontStely(@"PingFangSC-Regular", 14);
    //提示信息上的img
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"login_caution"];
    [self.view addSubview:imageView];
    [imageView activateConstraints:^{
        [imageView.left_attr equalTo:self.view.left_attr constant:15];
        [imageView.top_attr equalTo:self.view.top_attr constant:9];
        imageView.height_attr.constant = 18;
        imageView.width_attr.constant = 18;

    }];
    
    
    _moblieName = [[UITextField alloc]init];
    [self.view addSubview:_moblieName];
    [_moblieName activateConstraints:^{
        [_moblieName.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(15)];
        [_moblieName.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-15)];
        [_moblieName.top_attr equalTo:_tipLabel.bottom_attr constant:12];
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
    [_logInBtn setTitle:NSLocalizedString(@"绑定",nil) forState:UIControlStateNormal];
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
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"绑定即代表您已同意《叮咚打店用户协议》"];
    [aString addAttribute:NSForegroundColorAttributeName value:TextGrayColor range:NSMakeRange(0,9)];
    textlabe.attributedText = aString;
    textlabe.textAlignment = NSTextAlignmentCenter;
    textlabe.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLaberAction:)];
    [textlabe addGestureRecognizer:tap];
    
    
    
    
    [_moblieName addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [_codeField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
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
        
        [self loginHttp:@{@"loginType":_model.loginType,@"openId":_model.openId,@"nickName":_model.nickName
                          ,@"headImgUrl":_model.headImgUrl,@"mobile":_moblieName.text,@"messageAlias":@"PUB_SIGNIN",@"verifyCode":_codeField.text,@"deviceType":@"IOS",@"deviceToken":_moblieName.text}];
        
    } else
    {
        [YDProgressHUD showMessage:@"请先获取验证码"];

    }
    
    
}
- (void)loginHttp:(NSDictionary *)dic
{
    [[PattayaUserServer singleton] loginOrRegisterToken:dic Requestsuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            [PattayaTool loginSaveToken:ret[@"data"]];
            [PattayaTool chenkLogin:@"yes"];
//            [GetAppDelegate getTabbarVC];

            [self userInfoHttp];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];

        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];

        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//- (void)saveToken:(NSString *)token
//{
//    [[PattayaUserServer singleton] deviceTokenRequest:@{@"deviceType":@"IOS",@"deviceToken":token} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
//        if ([ResponseModel isData:ret]) {
//            NSLog(@"上传成功");
//         
//            
//        } else
//        {
//            NSLog(@"获取失败");
//        }
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        
//    }];
//}

- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            UserModel * mode = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
            [PattayaTool loginSavename:mode.userName mobile:mode.mobile];
            
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
                [_codeBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
    
}

//获取验证码
- (void)clikeCode
{
    [self timeNumss];
    if ([PattayaTool isNull:_moblieName.text]) {
        [YDProgressHUD showMessage:@"手机号码不能为空"];
        return;
    }
    
    [[PattayaUserServer singleton] sendVerifyCodeRequest:@{@"mobile":_moblieName.text,@"alias":@"PUB_SIGNIN",@"messageType":@"TEXT"} success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            
            [_codeField becomeFirstResponder];

            _isCode = YES;
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//用户协议
- (void)textLaberAction:(UITapGestureRecognizer *)tap
{
    WebHelpViewController * webVC = [[WebHelpViewController alloc] init];
    webVC.httpString = @"https://www.callstore.cn/policies/user-agreements/";
    webVC.title = NSLocalizedString(@"用户协议",nil);
    [self.navigationController pushViewController:webVC animated:YES];
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
