//
//  ChangeNicknameVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/11/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ChangeNicknameVC.h"

@interface ChangeNicknameVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *nickNameTF;
@property (nonatomic,strong) UIButton * saveBT;//保存
@property (nonatomic,strong) UIButton * clearBT;//保存


@end

@implementation ChangeNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    [super setupUI];
    self.navigationItem.title = @"昵称";
    
    UIView *whiteBg = [[UIView alloc]init];
    whiteBg.backgroundColor = UIColorWhite;
    [self.view addSubview:whiteBg];
    [whiteBg activateConstraints:^{
        whiteBg.height_attr.constant = 56;
        [whiteBg.top_attr equalTo:self.view.top_attr constant:10];
        [whiteBg.left_attr equalTo:self.view.left_attr];
        [whiteBg.right_attr equalTo:self.view.right_attr];

    }];
    
    //昵称
    UILabel *nickName = [[UILabel alloc] init];
    nickName.text = @"昵称";
    nickName.textColor = TextColor;
    nickName.font =  K_LABEL_SMALL_FONT_14;
    [whiteBg addSubview:nickName];
    [nickName activateConstraints:^{
        nickName.height_attr.constant = 20;
        nickName.width_attr.constant = 60;
        [nickName.left_attr equalTo:whiteBg.left_attr constant:12];
        nickName.centerY_attr = whiteBg.centerY_attr;
        
    }];
    
    //清空
    _clearBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBT setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [_clearBT addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteBg addSubview:_clearBT];
    [_clearBT activateConstraints:^{
        _clearBT.height_attr.constant = 22;
        _clearBT.width_attr.constant = 22;
        [_clearBT.right_attr equalTo:whiteBg.right_attr constant:-12];
        _clearBT.centerY_attr = whiteBg.centerY_attr;
    }];
    
    _nickNameTF = [[UITextField alloc] init];
    _nickNameTF.delegate = self;
    _nickNameTF.placeholder = @"请输入昵称";
    _nickNameTF.font = [UIFont systemFontOfSize:14];
    [whiteBg addSubview:_nickNameTF];
    [_nickNameTF activateConstraints:^{
        [_nickNameTF.centerY_attr equalTo:whiteBg.centerY_attr];
        [_nickNameTF.left_attr equalTo:nickName.right_attr constant:0];
        [_nickNameTF.right_attr equalTo:_clearBT.left_attr constant:0];
        _nickNameTF.height_attr.constant = 28;

    }];
    
  

    
    //保存
    _saveBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveBT setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBT addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [_saveBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _saveBT.backgroundColor = UIColorFromRGB(0xF4F4F4);
    _saveBT.layer.cornerRadius = 19;
    _saveBT.layer.masksToBounds = YES;
    [self.view addSubview:_saveBT];
    [_saveBT activateConstraints:^{
        _saveBT.height_attr.constant = 38;
        _saveBT.width_attr.constant = 250;
        [_saveBT.top_attr equalTo:whiteBg.bottom_attr constant:40];
        _saveBT.centerX_attr = self.view.centerX_attr;
    }];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.text.length != 0) {
        _saveBT.backgroundColor = App_Nav_BarDefalutColor;
    }else{
        _saveBT.backgroundColor = UIColorFromRGB(0xF4F4F4);
    }
    if (textField.text.length > 11) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 11)];
    }
    
    return YES;
    
}

-(void)clearClick{
    self.nickNameTF.text = @"";
}

-(void)saveClick{
    @weakify(self);
    [[PattayaUserServer singleton] PUTupdateNikenameRequest:@{@"nickName":_nickNameTF.text} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        @strongify(self);
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];

        } else{
            [YDProgressHUD showMessage:@"message"];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}
@end
