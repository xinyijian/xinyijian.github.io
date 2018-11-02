//
//  PaymentActionSheetView.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentActionSheetView.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
@interface PaymentActionSheetView()

@end

@implementation PaymentActionSheetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self initViews];
                
    }
    return self;
}

-(void)initViews{
    
    //白色背景
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, IPhone_7_Scale_Height(235))];
    _bgView.backgroundColor = UIColorWhite;
    [self addSubview:_bgView];

    //剩余时间
    _surplusTimeLabel = [[UILabel alloc] init];
    _surplusTimeLabel.font = K_LABEL_SMALL_FONT_14;
    _surplusTimeLabel.textColor = TextGrayColor;
    _surplusTimeLabel.text = @"支付金额";
    _surplusTimeLabel.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview: _surplusTimeLabel];
    [_surplusTimeLabel activateConstraints:^{
        [_surplusTimeLabel.top_attr equalTo:_bgView.top_attr constant:IPhone_7_Scale_Height(11)];
        _surplusTimeLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        _surplusTimeLabel.centerX_attr = _bgView.centerX_attr;
    }];
    //取消按钮
    _cancelBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBT setTitleColor:App_Nav_BarDefalutColor forState:UIControlStateNormal];
    [_cancelBT addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBT setTitle:@"取消" forState:UIControlStateNormal];
    [_bgView addSubview:_cancelBT];
    [_cancelBT activateConstraints:^{
        [_cancelBT.right_attr equalTo:_bgView.right_attr constant:IPhone_7_Scale_Width(-18)];
        [_cancelBT.top_attr equalTo:_bgView.top_attr constant:IPhone_7_Scale_Height(11)];
        _cancelBT.height_attr.constant =IPhone_7_Scale_Height(22) ;
        _cancelBT.width_attr.constant =IPhone_7_Scale_Width(38);
    }];
    
    //总额
    _totalAmountLabel = [[UILabel alloc] init];
    _totalAmountLabel.font = [UIFont systemFontOfSize:24];
    _totalAmountLabel.textColor = TextColor;
    _totalAmountLabel.text = @"￥14.00";
    _totalAmountLabel.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview: _totalAmountLabel];
    [_totalAmountLabel activateConstraints:^{
        [_totalAmountLabel.top_attr equalTo:_surplusTimeLabel.bottom_attr constant:IPhone_7_Scale_Height(7)];
        _totalAmountLabel.height_attr.constant = IPhone_7_Scale_Height(33);
        _totalAmountLabel.centerX_attr = self.centerX_attr;
    }];
    
    //微信img
    _wechatImg = [[UIImageView alloc] init];
    [_bgView addSubview:_wechatImg];
    _wechatImg.image = [UIImage imageNamed:@"icon_wechatpay"];
    [_wechatImg activateConstraints:^{
        [_wechatImg.left_attr equalTo:_bgView.left_attr constant:IPhone_7_Scale_Width(19)];
        _wechatImg.height_attr.constant = IPhone_7_Scale_Height(30);
        _wechatImg.width_attr.constant = IPhone_7_Scale_Height(30);
        [_wechatImg.top_attr equalTo:_totalAmountLabel.bottom_attr constant:IPhone_7_Scale_Height(10)];
    }];
    
    
    
    //支付宝img
    _aliPayImg = [[UIImageView alloc] init];
    [_bgView addSubview:_aliPayImg];
    _aliPayImg.image = [UIImage imageNamed:@"icon_alipay"];
    [_aliPayImg activateConstraints:^{
        [_aliPayImg.left_attr equalTo:_bgView.left_attr constant:IPhone_7_Scale_Width(19)];
        _aliPayImg.height_attr.constant = IPhone_7_Scale_Height(30);
        _aliPayImg.width_attr.constant = IPhone_7_Scale_Height(30);
        [_aliPayImg.top_attr equalTo:_wechatImg.bottom_attr constant:IPhone_7_Scale_Height(25)];
    }];
    
    //
    _wechatSelectBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatSelectBT setImage:[UIImage imageNamed:@"payment_btn_unselected"] forState:UIControlStateNormal];
    [_wechatSelectBT setImage:[UIImage imageNamed:@"payment_btn_selected"] forState:UIControlStateSelected];
    _wechatSelectBT.selected = YES;
    [_wechatSelectBT addTarget:self action:@selector(selectlClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_wechatSelectBT];
    [_wechatSelectBT activateConstraints:^{
        [_wechatSelectBT.right_attr equalTo:_bgView.right_attr constant:IPhone_7_Scale_Width(-18)];
        _wechatSelectBT.centerY_attr = _wechatImg.centerY_attr;
        _wechatSelectBT.height_attr.constant = IPhone_7_Scale_Height(20) ;
        _wechatSelectBT.width_attr.constant  = IPhone_7_Scale_Height(20) ;
    }];
    
    //
    _alipaySelectBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_alipaySelectBT setImage:[UIImage imageNamed:@"payment_btn_unselected"] forState:UIControlStateNormal];
    [_alipaySelectBT setImage:[UIImage imageNamed:@"payment_btn_selected"] forState:UIControlStateSelected];
    [_alipaySelectBT addTarget:self action:@selector(selectlClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_alipaySelectBT];
    [_alipaySelectBT activateConstraints:^{
        [_alipaySelectBT.right_attr equalTo:_bgView.right_attr constant:IPhone_7_Scale_Width(-18)];
        _alipaySelectBT.centerY_attr = _aliPayImg.centerY_attr;
        _alipaySelectBT.height_attr.constant = IPhone_7_Scale_Height(20) ;
        _alipaySelectBT.width_attr.constant  = IPhone_7_Scale_Height(20) ;
    }];
    
    //微信支付
    _wechatLabel = [[UILabel alloc] init];
    _wechatLabel.font = [UIFont systemFontOfSize:14];
    _wechatLabel.textColor = TextColor;
    _wechatLabel.text = @"微信支付";
    [_bgView addSubview: _wechatLabel];
    [_wechatLabel activateConstraints:^{
        [_wechatLabel.left_attr equalTo:_wechatImg.right_attr constant:IPhone_7_Scale_Width(10)];
        [_wechatLabel.right_attr equalTo:_wechatSelectBT.left_attr constant:0];
        _wechatLabel.height_attr.constant = IPhone_7_Scale_Height(40);
        _wechatLabel.centerY_attr = _wechatImg.centerY_attr;
    }];
    
    //微信支付
    _aliPayLabel = [[UILabel alloc] init];
    _aliPayLabel.font = [UIFont systemFontOfSize:14];
    _aliPayLabel.textColor = TextColor;
    _aliPayLabel.text = @"支付宝支付";
    _aliPayLabel.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview: _aliPayLabel];
    [_aliPayLabel activateConstraints:^{
        [_aliPayLabel.right_attr equalTo:_alipaySelectBT.left_attr constant:0];
        [_aliPayLabel.left_attr equalTo:_aliPayImg.right_attr constant:IPhone_7_Scale_Width(10)];
        _aliPayLabel.height_attr.constant = IPhone_7_Scale_Height(40);
        _aliPayLabel.centerY_attr = _aliPayImg.centerY_attr;
    }];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
   
    _wechatLabel.userInteractionEnabled = YES;
    
    [_wechatLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
     _aliPayLabel.userInteractionEnabled  = YES;
    [_aliPayLabel addGestureRecognizer:tap2];
    
    
    //
    _paymentBT = [UIButton buttonWithType:UIButtonTypeCustom];
    _paymentBT.backgroundColor = App_Nav_BarDefalutColor;
    _paymentBT.layer.cornerRadius = IPhone_7_Scale_Height(38/2);
    _paymentBT.layer.masksToBounds = YES;
    [_paymentBT setTitle:@"确定支付" forState:UIControlStateNormal];
    [_paymentBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [_paymentBT addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_paymentBT];
    [_paymentBT activateConstraints:^{
        [_paymentBT.bottom_attr equalTo:_bgView.bottom_attr constant:IPhone_7_Scale_Height(-16)];
        _paymentBT.centerX_attr = self.centerX_attr;
        _paymentBT.height_attr.constant = IPhone_7_Scale_Height(38) ;
        _paymentBT.width_attr.constant  = IPhone_7_Scale_Width(251);
    }];
    
}

-(void)tap1:(UITapGestureRecognizer *)tap{
    
    [self selectlClick:_wechatSelectBT];
    
}

-(void)tap2:(UITapGestureRecognizer *)tap{
   
    [self selectlClick:_alipaySelectBT];
    
}


//取消
-(void)cancelClick:(UIButton*)btn{
    
    [self hiddenView];
}

//选择支付方式
-(void)selectlClick:(UIButton*)btn{
    btn.selected = YES;
    if (btn == _wechatSelectBT) {
        _alipaySelectBT.selected = NO;
    }else{
        _wechatSelectBT.selected = NO;
    }
    
   
}

//去支付
-(void)paymentClick:(UIButton*)btn{
   
    [[PattayaUserServer singleton] orderPaymentRequest:_payBusinessCode payType:_wechatSelectBT.selected ? 2 : 1 success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        NSLog(@"%@",ret);
      
        if ([ResponseModel isData:ret]){
               [self hiddenView];
            
                if (_wechatSelectBT.selected) {
                    //微信支付
                   NSData *jsonData =  [ret[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
                    [self WechatPayWithData:dic];
                }else{
                   // 支付宝支付
                    [self aliPayWithData:ret[@"data"]];
                }
            
        }else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [YDProgressHUD showMessage:@"网络错误，请重试"];

    }];

}

#pragma mark 微信支付方法
- (void)WechatPayWithData:(NSDictionary *)dic{

    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = dic[@"appid"];//appid;
    // 商家id，在注册的时候给的
    req.partnerId = dic[@"partnerid"];//partnerid;
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = dic[@"prepayid"];//prepayid;
    // 根据财付通文档填写的数据和签名
    req.package  = dic[@"package"];//package;
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = dic[@"noncestr"];//noncestr;
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = dic[@"timestamp"];//timestamp;
    UInt32 timestamp = [stamp intValue];
    req.timeStamp = timestamp;
    // 这个签名也是后台做的
    req.sign = dic[@"sign"];//dic[@"sign"];//sign;
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}

#pragma mark 支付宝支付方法
-(void)aliPayWithData:(NSString *)data{
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    //    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
    //                             orderInfoEncoded, signedString];
    [[AlipaySDK defaultService] payOrder:data fromScheme:@"pattayaUserPay" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
}

//隐藏视图
-(void)hiddenView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, self.height , self.width, IPhone_7_Scale_Height(235));
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
    
}

//展示视图
-(void)showView{
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.frame = CGRectMake(0, self.height - IPhone_7_Scale_Height(235), self.width, IPhone_7_Scale_Height(235));
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   //[self hiddenView];
}


- (NSString *) md5:(NSString *) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




@end
