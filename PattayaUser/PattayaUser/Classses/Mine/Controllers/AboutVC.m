//
//  AboutVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AboutVC.h"
#import "WebHelpViewController.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    [super setupUI];
    self.navigationItem.title = @"关于打店";
    //icon
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.image = [UIImage imageNamed:@"pic_icon"];
    [self.view addSubview:iconImg];
    [iconImg activateConstraints:^{
        iconImg.height_attr.constant = IPhone_7_Scale_Width(86);
        iconImg.width_attr.constant = IPhone_7_Scale_Width(86);
        [iconImg.top_attr equalTo:self.view.top_attr constant:IPhone_7_Scale_Height(40)];
        iconImg.centerX_attr = self.view.centerX_attr;
    }];
    //版本号
    UILabel *version = [[UILabel alloc] init];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//取version版本
    version.text = [NSString stringWithFormat:@"叮咚打店Ding Dong%@",currentVersion];
    version.textColor = TextGrayColor;
    version.font =  K_LABEL_SMALL_FONT_14;
    [version sizeToFit];
    [self.view addSubview:version];
    [version activateConstraints:^{
        version.height_attr.constant = 20;
        [version.top_attr equalTo:iconImg.bottom_attr constant:10];
        version.centerX_attr = self.view.centerX_attr;

    }];
    
        //叮咚打店用户协议
    UILabel *textlabe = [[UILabel alloc] init];
    [self.view addSubview:textlabe];
    [textlabe activateConstraints:^{
        textlabe.height_attr.constant = 14;
        [textlabe.bottom_attr equalTo:self.view.bottom_attr constant:-IPhone_7_Scale_Height(19)-SafeAreaBottomHeight];
        textlabe.centerX_attr = self.view.centerX_attr;

    }];
    textlabe.font = fontStely(@"PingFangSC-Regular", 10);
    textlabe.textColor =App_Nav_BarDefalutColor ;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"查看《叮咚打店用户协议》"];
    [aString addAttribute:NSForegroundColorAttributeName value:TextGrayColor range:NSMakeRange(0,2)];
    textlabe.attributedText = aString;
    textlabe.textAlignment = NSTextAlignmentCenter;
    textlabe.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLaberAction:)];
    [textlabe addGestureRecognizer:tap];
    
    //
    UILabel *aboutLabel = [[UILabel alloc] init];
    aboutLabel.text = @"2018深兰科技（上海）有限公司版权所有\ncopyright@2014-2018 DeepBlue\nAll Right Reserved";
    aboutLabel.textAlignment = NSTextAlignmentCenter;
    aboutLabel.numberOfLines = 0;
    [self.view addSubview:aboutLabel];
    [aboutLabel activateConstraints:^{
        aboutLabel.width_attr.constant = 191;
        [aboutLabel.bottom_attr equalTo:textlabe.top_attr constant:IPhone_7_Scale_Height(-5)];
        aboutLabel.centerX_attr = self.view.centerX_attr;
        
    }];
    aboutLabel.font = fontStely(@"PingFangSC-Regular", 10);
    aboutLabel.textColor = TextGrayColor ;

    
    
}


-(void)textLaberAction:(UITapGestureRecognizer *)tap{
    
    WebHelpViewController * webVC = [[WebHelpViewController alloc] init];
    webVC.httpString = @"https://www.callstore.cn/policies/user-agreements/";
    webVC.title = NSLocalizedString(@"用户协议",nil);
    [self.navigationController pushViewController:webVC animated:YES];
    
}


@end
