//
//  EvaluateOrderVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/18.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "EvaluateOrderVC.h"

#define ICONS  @[@"btn_bad",@"btn_good",@"btn_verygood"]
#define ICONS_SEL  @[@"btn_bad_sel",@"btn_good_sel",@"btn_verygood_sel"]


@interface EvaluateOrderVC ()<UITextViewDelegate>

@property (nonatomic,strong) UIButton * currentPdFaceBT;//当前商品质量评价按钮
@property (nonatomic,strong) UIButton * currentSvFaceBT;//当前服务质量评价按钮

@property (nonatomic,strong) UITextView * describeTextView;//描述输入框
@property (nonatomic,strong) UILabel * placehoder;
@property (nonatomic,strong) UIButton * commitBT;//提交



@end

@implementation EvaluateOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价订单";
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    UIView *headBGView = [[UIView alloc]init];
    headBGView.backgroundColor = UIColorWhite;
    [self.view addSubview:headBGView];
    [headBGView activateConstraints:^{
        [headBGView.right_attr equalTo:self.view.right_attr];
        [headBGView.left_attr equalTo:self.view.left_attr ];
        [headBGView.top_attr equalTo:self.view.top_attr];
        headBGView.height_attr.constant = IPhone_7_Scale_Height(214);
    }];
    
    UILabel* feelingLabel = [[UILabel alloc] init];
    feelingLabel.text = @"告诉我们你本次的购物感受";
    feelingLabel.font = K_LABEL_SMALL_FONT_16;
    feelingLabel.textColor = TextColor;
    [feelingLabel sizeToFit];
    [headBGView addSubview: feelingLabel];
    [feelingLabel activateConstraints:^{
        feelingLabel.centerX_attr = headBGView.centerX_attr;
        [feelingLabel.top_attr equalTo:headBGView.top_attr constant:IPhone_7_Scale_Height(23)];
        feelingLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
    
    UILabel* productLabel = [[UILabel alloc] init];
    productLabel.text = @"商品质量";
    productLabel.font = K_LABEL_SMALL_FONT_14;
    productLabel.textColor = TextColor;
    [productLabel sizeToFit];
    [headBGView addSubview: productLabel];
    [productLabel activateConstraints:^{
        [productLabel.left_attr equalTo:headBGView.left_attr constant:IPhone_7_Scale_Width(20)];
        [productLabel.top_attr equalTo:feelingLabel.bottom_attr constant:IPhone_7_Scale_Height(39)];
        productLabel.height_attr.constant = IPhone_7_Scale_Height(20);
    }];
    
    UILabel* serviceLabel = [[UILabel alloc] init];
    serviceLabel.text = @"服务质量";
    serviceLabel.font = K_LABEL_SMALL_FONT_14;
    serviceLabel.textColor = TextColor;
    [serviceLabel sizeToFit];
    [headBGView addSubview: serviceLabel];
    [serviceLabel activateConstraints:^{
        [serviceLabel.left_attr equalTo:headBGView.left_attr constant:IPhone_7_Scale_Width(20)];
        [serviceLabel.top_attr equalTo:productLabel.bottom_attr constant:IPhone_7_Scale_Height(53)];
        serviceLabel.height_attr.constant = IPhone_7_Scale_Height(20);
    }];
    

    //表情 商品质量
    for (int i = 0; i < 3; i++) {
        UIButton *faceBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceBT setImage:[UIImage imageNamed:ICONS[i]] forState:UIControlStateNormal];
        [faceBT setImage:[UIImage imageNamed:ICONS_SEL[i]] forState:UIControlStateSelected];
        [faceBT addTarget:self action:@selector(productFaceClick:) forControlEvents:UIControlEventTouchUpInside];
        faceBT.tag = i;
        [headBGView addSubview:faceBT];
        [faceBT activateConstraints:^{
            [faceBT.left_attr equalTo:productLabel.right_attr constant:(IPhone_7_Scale_Width(35)+i*IPhone_7_Scale_Width(38+20
                                                                                                                       ))];
            faceBT.centerY_attr = productLabel.centerY_attr;
            faceBT.height_attr.constant = IPhone_7_Scale_Width(38);
            faceBT.width_attr.constant = IPhone_7_Scale_Width(38);

        }];

    }
    
    //表情 服务质量
    for (int i = 0; i < 3; i++) {
        UIButton *faceBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceBT setImage:[UIImage imageNamed:ICONS[i]] forState:UIControlStateNormal];
        [faceBT setImage:[UIImage imageNamed:ICONS_SEL[i]] forState:UIControlStateSelected];
        [faceBT addTarget:self action:@selector(serviceFaceClick:) forControlEvents:UIControlEventTouchUpInside];
        faceBT.tag = i+1000;
        [headBGView addSubview:faceBT];
        [faceBT activateConstraints:^{
            [faceBT.left_attr equalTo:serviceLabel.right_attr constant:(IPhone_7_Scale_Width(35)+i*IPhone_7_Scale_Width(38+20
                                                                                                                        ))];
            faceBT.centerY_attr = serviceLabel.centerY_attr;
            faceBT.height_attr.constant = IPhone_7_Scale_Width(38);
            faceBT.width_attr.constant = IPhone_7_Scale_Width(38);
            
        }];
        
    }


    
    UIView *bottomBGView = [[UIView alloc]init];
    bottomBGView.layer.cornerRadius = 5;
    bottomBGView.layer.masksToBounds = YES;
    bottomBGView.backgroundColor = UIColorWhite;
    [self.view addSubview:bottomBGView];
    [bottomBGView activateConstraints:^{
        [bottomBGView.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-8) ];
        [bottomBGView.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(8) ];
        [bottomBGView.top_attr equalTo:headBGView.bottom_attr constant:IPhone_7_Scale_Height(20) ];
        bottomBGView.height_attr.constant = IPhone_7_Scale_Height(174);
    }];
    
    //
    UILabel *issueLabel = [[UILabel alloc] init];
    issueLabel.text = @"评价描述";
    issueLabel.font = K_LABEL_SMALL_FONT_16;
    issueLabel.textColor = TextColor;
    [issueLabel sizeToFit];
    [bottomBGView addSubview: issueLabel];
    [issueLabel activateConstraints:^{
        [issueLabel.right_attr equalTo:bottomBGView.right_attr constant:IPhone_7_Scale_Width(-12) ];
        [issueLabel.left_attr equalTo:bottomBGView.left_attr constant:IPhone_7_Scale_Width(12) ];
        [issueLabel.top_attr equalTo:bottomBGView.top_attr constant:IPhone_7_Scale_Height(16) ];
        issueLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
    
    //分割线
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [bottomBGView addSubview:lineView];
    [lineView activateConstraints:^{
        [lineView.right_attr equalTo:bottomBGView.right_attr];
        [lineView.left_attr equalTo:bottomBGView.left_attr];
        [lineView.top_attr equalTo:issueLabel.bottom_attr constant:IPhone_7_Scale_Height(14)];
        lineView.height_attr.constant = 1;
    }];
    
    
    _describeTextView = [[UITextView alloc] init];
    _describeTextView.delegate = self;
    _describeTextView.font = [UIFont systemFontOfSize:14];
    [bottomBGView addSubview:_describeTextView];
    [_describeTextView activateConstraints:^{
        [_describeTextView.right_attr equalTo:bottomBGView.right_attr constant:IPhone_7_Scale_Width(-12) ];
        [_describeTextView.left_attr equalTo:bottomBGView.left_attr constant:IPhone_7_Scale_Width(12) ];
        [_describeTextView.top_attr equalTo:lineView.bottom_attr constant:IPhone_7_Scale_Height(10) ];
        _describeTextView.height_attr.constant = IPhone_7_Scale_Height(100);
    }];
    
    [_describeTextView addSubview:self.placehoder];
    
    
    //提交
    _commitBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitBT setTitle:@"提交" forState:UIControlStateNormal];
    [_commitBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [_commitBT addTarget:self action:@selector(commitEvaluate) forControlEvents:UIControlEventTouchUpInside];
    _commitBT.backgroundColor = App_Nav_BarDefalutColor;
    _commitBT.layer.cornerRadius = 19;
    _commitBT.layer.masksToBounds = YES;
    [self.view addSubview:_commitBT];
    [_commitBT activateConstraints:^{
        [_commitBT.top_attr equalTo:bottomBGView.bottom_attr constant:IPhone_7_Scale_Height(40)];
        _commitBT.width_attr.constant = IPhone_7_Scale_Width(250);
        _commitBT.height_attr.constant = 38;
        _commitBT.centerX_attr = self.view.centerX_attr;
    }];
    
}


#pragma mark 选择评分
-(void)productFaceClick:(UIButton*)btn{
    if (_currentPdFaceBT) {
        _currentPdFaceBT.selected = NO;
    }
    _currentPdFaceBT = btn;
    btn.selected = YES;
    
}

-(void)serviceFaceClick:(UIButton*)btn{
    if (_currentSvFaceBT) {
        _currentSvFaceBT.selected = NO;
    }
    _currentSvFaceBT = btn;
    btn.selected = YES;
    
}

#pragma mark 提交
-(void)commitEvaluate{
    if (!_currentPdFaceBT) {
        [YDProgressHUD showMessage:@"请选择商品质量评分"];
        return;
    }
    
    if (!_currentSvFaceBT) {
        [YDProgressHUD showMessage:@"请选择服务质量评分"];
        return;
    }
    
}

#pragma mark - UITextViewDelegate 代理

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self performSelector:@selector(textViewDidChange:) withObject:textView afterDelay:0.1f];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]) {
        self.placehoder.hidden = NO;
    }else {
        self.placehoder.hidden = YES;
    }
    
}

#pragma mark 懒加载
- (UILabel *)placehoder {
    if (_placehoder == nil) {
        _placehoder = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 150, 30)];
        _placehoder.enabled = NO;
        _placehoder.font = [UIFont systemFontOfSize:14];
        _placehoder.textColor = UIColorFromRGB(0xD8D8D8);
        _placehoder.textAlignment = NSTextAlignmentLeft;
        _placehoder.text = @"在此描述你的体验";
    }
    return _placehoder;
}

@end
