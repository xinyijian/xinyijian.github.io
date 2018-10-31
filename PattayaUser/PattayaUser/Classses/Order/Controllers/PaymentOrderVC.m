//
//  PaymentOrderVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentOrderVC.h"
#import "PaymentOrderCell.h"
#import "PaymentBottomView.h"
#import "PaymentActionSheetView.h"
#import "PaymentSuccessView.h"

@interface PaymentOrderVC ()<YBPopupMenuDelegate>
//导航栏pop按钮
@property (nonatomic, strong) UIButton *rightPopBT;
//头部视图
@property (nonatomic, strong) UIButton *reachStoreBT;//到店取
@property (nonatomic, strong) UIButton *callStoreBT;//打个店
@property (nonatomic, strong) UILabel *canUseLabel;//是否可以使用
@property (nonatomic, strong) UILabel *label1;//label1
@property (nonatomic, strong) UILabel *label2;//label2
@property (nonatomic, strong) UILabel *textlabe;//打电话  预计到达时间
@property (nonatomic, strong) UITapGestureRecognizer * tap;


@property (nonatomic, strong) UIView *footerBgViewMode1;//footer视图模式1
@property (nonatomic, strong) UIView *footerBgViewMode2;//footer视图模式2


@property (nonatomic, strong) PaymentBottomView *bottomView;//底部视图
@property (nonatomic, strong) PaymentActionSheetView *paymentActionSheetView;//收缩视图

@property (nonatomic, strong) PaymentSuccessView *paymentSuccessView;//支付成功显示的视图
@property (nonatomic, strong) UIButton *contactBT;//联系卖家
@property (nonatomic, strong) UIButton *completeBT;//完成





@end

@implementation PaymentOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
    [self netRequestData];
    [self setupUI];

}

-(void)netRequestData{
    for (ProductModel *model in _shopModel.goodsList) {
        if ([model.selectCount intValue]>0) {
            [self.dataArray addObject:model];
        }
    }
}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView setSeparatorColor:UIColorWhite];
    self.tableView.frame = CGRectMake(0, 8, SCREEN_Width, SCREEN_Height - 8*2 - TopBarHeight - BottomH - SafeAreaBottomHeight);

    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.paymentActionSheetView];
    [self.view addSubview:self.paymentSuccessView];
    
}

#pragma mark - tableView datasource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return IgnoreHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return IPhone_7_Scale_Height(250);
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footView = [[UIView alloc]init];
//
//    //模式1--------------------------
//    [self createFooterBgviewMode1];
//    [footView addSubview:_footerBgViewMode1];
//
//    //模式1--------------------------
//    [self createFooterBgviewMode2];
//    [footView addSubview:_footerBgViewMode2];
//
//    return footView;
//}


//footerBgView模式1
-(void)createFooterBgviewMode1{
    
    _footerBgViewMode1 = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), 1, SCREEN_Width - IPhone_7_Scale_Width(8*2), IPhone_7_Scale_Height(71))];
    _footerBgViewMode1.backgroundColor = UIColorWhite;
    //[footView addSubview:_footerBgViewMode1];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_footerBgViewMode1.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _footerBgViewMode1.bounds;
    maskLayer.path = maskPath.CGPath;
    _footerBgViewMode1.layer.mask = maskLayer;
    
    
    UILabel *redPacketLabel = [[UILabel alloc] init];
    redPacketLabel.text = @"红包";
    redPacketLabel.font = K_LABEL_SMALL_FONT_16;
    redPacketLabel.textColor = TextColor;
    [redPacketLabel sizeToFit];
    [_footerBgViewMode1 addSubview: redPacketLabel];
    [redPacketLabel activateConstraints:^{
        [redPacketLabel.left_attr equalTo:_footerBgViewMode1.left_attr constant:IPhone_7_Scale_Width(12)];
        [redPacketLabel.top_attr equalTo:_footerBgViewMode1.top_attr constant:IPhone_7_Scale_Height(12)];
        redPacketLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [_footerBgViewMode1 addSubview:arrow];
    [arrow activateConstraints:^{
        [arrow.right_attr equalTo:_footerBgViewMode1.right_attr constant:-12];
        arrow.centerY_attr = redPacketLabel.centerY_attr;
        arrow.height_attr.constant = IPhone_7_Scale_Width(11);
        arrow.width_attr.constant = IPhone_7_Scale_Width(11);
    }];
    
    UIImageView *firstRedPacketImg = [[UIImageView alloc]init];
    firstRedPacketImg.image = [UIImage imageNamed:@"tag_discount"];
    [_footerBgViewMode1 addSubview:firstRedPacketImg];
    [firstRedPacketImg activateConstraints:^{
        [firstRedPacketImg.left_attr equalTo:_footerBgViewMode1.left_attr constant:IPhone_7_Scale_Width(12)];
        firstRedPacketImg.height_attr.constant = IPhone_7_Scale_Height(21);
        firstRedPacketImg.width_attr.constant = IPhone_7_Scale_Width(52);
        [firstRedPacketImg.top_attr equalTo:redPacketLabel.bottom_attr constant:IPhone_7_Scale_Height(6)];
        
    }];
    
    UILabel *firstRedPacketLabel = [[UILabel alloc] init];
    firstRedPacketLabel.text = @"-￥6.00";
    firstRedPacketLabel.font = K_LABEL_SMALL_FONT_14;
    firstRedPacketLabel.textColor = UIColorFromRGB(0xEF3E00);
    [firstRedPacketLabel sizeToFit];
    [_footerBgViewMode1 addSubview: firstRedPacketLabel];
    [firstRedPacketLabel activateConstraints:^{
        [firstRedPacketLabel.right_attr equalTo:_footerBgViewMode1.right_attr constant:-13];
        [firstRedPacketLabel.top_attr equalTo:arrow.bottom_attr constant:IPhone_7_Scale_Height(12)];
        firstRedPacketLabel.height_attr.constant = IPhone_7_Scale_Height(19);
    }];
    
}

//footerBgView模式2
-(void)createFooterBgviewMode2{
    
    _footerBgViewMode2 = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), 1, SCREEN_Width - IPhone_7_Scale_Width(8*2), IPhone_7_Scale_Height(71))];
    _footerBgViewMode2.backgroundColor = UIColorWhite;
    _footerBgViewMode2.hidden = YES;
    //[footView addSubview:_footerBgViewMode1];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_footerBgViewMode2.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _footerBgViewMode2.bounds;
    maskLayer.path = maskPath.CGPath;
    _footerBgViewMode2.layer.mask = maskLayer;
    
    UILabel *redPacketLabel = [[UILabel alloc] init];
    redPacketLabel.text = @"红包";
    redPacketLabel.font = K_LABEL_SMALL_FONT_16;
    redPacketLabel.textColor = TextColor;
    [redPacketLabel sizeToFit];
    [_footerBgViewMode2 addSubview: redPacketLabel];
    [redPacketLabel activateConstraints:^{
        [redPacketLabel.left_attr equalTo:_footerBgViewMode2.left_attr constant:IPhone_7_Scale_Width(12)];
        redPacketLabel.centerY_attr = _footerBgViewMode2.centerY_attr;
        redPacketLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
    
    UILabel *noRedPacketLabel = [[UILabel alloc] init];
    noRedPacketLabel.text = @"无可用红包";
    noRedPacketLabel.font = K_LABEL_SMALL_FONT_14;
    noRedPacketLabel.textColor = TextGrayColor;
    [noRedPacketLabel sizeToFit];
    [_footerBgViewMode2 addSubview: noRedPacketLabel];
    [noRedPacketLabel activateConstraints:^{
        [noRedPacketLabel.right_attr equalTo:_footerBgViewMode2.right_attr constant:IPhone_7_Scale_Width(-21)];
        noRedPacketLabel.centerY_attr = _footerBgViewMode2.centerY_attr;
        noRedPacketLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), IPhone_7_Scale_Height(10), SCREEN_Width - IPhone_7_Scale_Width(8*2), IPhone_7_Scale_Height(50 + 128))];
    bgView.backgroundColor = UIColorWhite;
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [headView addSubview:bgView];
    //到店取
    _reachStoreBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reachStoreBT setBackgroundImage:[UIImage imageNamed:@"reachstore_btn_bg"] forState:UIControlStateNormal];
    [_reachStoreBT setBackgroundImage:[UIImage imageNamed:@"reachstore_btn_bg_selected"] forState:UIControlStateSelected];
    [_reachStoreBT setTitleColor:TextColor forState:UIControlStateNormal];
    [_reachStoreBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_reachStoreBT setImage:[UIImage imageNamed:@"icon_reachstore"] forState:UIControlStateNormal];
    [_reachStoreBT setImage:[UIImage imageNamed:@"icon_reachstore"] forState:UIControlStateHighlighted];
    [_reachStoreBT setTitle:@"到店取" forState:UIControlStateNormal];
    _reachStoreBT.selected = YES;
//    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
//    button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
//    //button标题的偏移量，这个偏移量是相对于图片的
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [bgView addSubview:_reachStoreBT];
    _reachStoreBT.tag = 1;
    [_reachStoreBT activateConstraints:^{
        [_reachStoreBT.left_attr equalTo:bgView.left_attr constant:0];
        [_reachStoreBT.top_attr equalTo:bgView.top_attr constant:0];
        _reachStoreBT.height_attr.constant = bgView.width/2/180*50;
        _reachStoreBT.width_attr.constant = bgView.width/2;
    }];
    
    //打个店
    _callStoreBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_callStoreBT setBackgroundImage:[UIImage imageNamed:@"callstore_btn_bg"] forState:UIControlStateNormal];
    [_callStoreBT setBackgroundImage:[UIImage imageNamed:@"callstore_btn_bg_selected"] forState:UIControlStateSelected];
    [_callStoreBT setTitleColor:TextColor forState:UIControlStateNormal];
    [_callStoreBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_callStoreBT setImage:[UIImage imageNamed:@"icon_callstore"] forState:UIControlStateNormal];
    [_callStoreBT setImage:[UIImage imageNamed:@"icon_callstore"] forState:UIControlStateHighlighted];
    [_callStoreBT setTitle:@"打个店" forState:UIControlStateNormal];
    //_callStoreBT.enabled = NO;
    [bgView addSubview:_callStoreBT];
    _callStoreBT.tag = 2;
    [_callStoreBT activateConstraints:^{
        [_callStoreBT.left_attr equalTo:_reachStoreBT.right_attr constant:0];
        [_callStoreBT.top_attr equalTo:bgView.top_attr constant:0];
        _callStoreBT.height_attr.constant = bgView.width/2/180*50;
        _callStoreBT.width_attr.constant = bgView.width/2;
    }];
    
    if (_shopModel.canBeCalling ) {
        
        _canUseLabel = [[UILabel alloc] init];
        _canUseLabel.text = @"*当前时段无法使用";
        _canUseLabel.font = UIBoldFont(10);
        _canUseLabel.textColor = UIColorFromRGB(0x56AAFA);
        [_canUseLabel sizeToFit];
        [bgView addSubview: _canUseLabel];
        [_canUseLabel activateConstraints:^{
            [_canUseLabel.bottom_attr equalTo:_callStoreBT.bottom_attr constant:0];
            _canUseLabel.centerX_attr = _callStoreBT.centerX_attr;
            _canUseLabel.height_attr.constant = 14;
        }];
    }
    
    _label1 = [[UILabel alloc] init];
    _label1.text = @"商家当前位置：长宁区1488弄99号113房";
    _label1.font = UIBoldFont(14);
    _label1.textColor = TextColor;
    [bgView addSubview: _label1];
    [_label1 activateConstraints:^{
        [_label1.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(12)];
        [_label1.right_attr equalTo:bgView.right_attr constant:0];
        [_label1.top_attr equalTo:_reachStoreBT.bottom_attr constant:IPhone_7_Scale_Height(17)];
        _label1.height_attr.constant = IPhone_7_Scale_Height(20);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [bgView addSubview:arrow];
    [arrow activateConstraints:^{
        [arrow.right_attr equalTo:bgView.right_attr constant:-12];
        [arrow.top_attr equalTo:_label1.bottom_attr constant:0];
        arrow.height_attr.constant = IPhone_7_Scale_Width(11);
        arrow.width_attr.constant = IPhone_7_Scale_Width(11);
    }];
    
    
    _label2 = [[UILabel alloc] init];
    _label2.text = @"步行约10分钟 距离530米";
    _label2.font = K_LABEL_SMALL_FONT_14;
    _label2.textColor = TextColor;
    [bgView addSubview: _label2];
    [_label2 activateConstraints:^{
        [_label2.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(12)];
        [_label2.right_attr equalTo:bgView.right_attr constant:0];
        [_label2.top_attr equalTo:_label1.bottom_attr constant:IPhone_7_Scale_Height(10)];
        _label2.height_attr.constant = IPhone_7_Scale_Height(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [bgView addSubview:lineView];
    [lineView activateConstraints:^{
        [lineView.left_attr equalTo:bgView.left_attr constant:0];
        [lineView.right_attr equalTo:bgView.right_attr constant:0];
        lineView.height_attr.constant = 1;
        [lineView.top_attr equalTo:_label2.bottom_attr constant:IPhone_7_Scale_Height(12)];
    }];
    
    
    //添加跳转事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToShopAddress:)];
    UIView *tapView = [[UIView alloc]init];
    [bgView addSubview:tapView];
    [tapView activateConstraints:^{
        [tapView.left_attr equalTo:bgView.left_attr constant:0];
        [tapView.right_attr equalTo:bgView.right_attr constant:0];
        [tapView.top_attr equalTo:_callStoreBT.bottom_attr constant:0];
        [tapView.bottom_attr equalTo:lineView.top_attr constant:0];

    }];

     [tapView addGestureRecognizer:tap];


    
    _textlabe = [[UILabel alloc] init];
    [bgView addSubview:_textlabe];
    [_textlabe activateConstraints:^{
        [_textlabe.left_attr equalTo:bgView.left_attr];
        [_textlabe.right_attr equalTo:bgView.right_attr];
        _textlabe.height_attr.constant = IPhone_7_Scale_Height(22);
        [_textlabe.top_attr equalTo:lineView.bottom_attr constant:IPhone_7_Scale_Height(13)];
    }];
    _textlabe.font = fontStely(@"PingFangSC-Regular", 16);
    _textlabe.textColor = App_Nav_BarDefalutColor;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"自取预留电话：13888888888"];
    [aString addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0,7)];
    _textlabe.attributedText = aString;
    _textlabe.textAlignment = NSTextAlignmentCenter;
    _textlabe.userInteractionEnabled = YES;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLaberAction:)];
    [_textlabe addGestureRecognizer:_tap];
    
    
    UIView *bgView2 = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), IPhone_7_Scale_Height(198), SCREEN_Width - IPhone_7_Scale_Width(8*2), IPhone_7_Scale_Height(51))];
    bgView2.backgroundColor = UIColorWhite;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView2.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView2.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView2.layer.mask = maskLayer;
    [headView addSubview:bgView2];
    
    UILabel *titleLab =  [[UILabel alloc]init];
    titleLab.font = K_LABEL_SMALL_FONT_16;
    titleLab.textColor = TextColor;
    titleLab.text = @"购物清单";
    [titleLab sizeToFit];
    [bgView2 addSubview:titleLab];
    [titleLab activateConstraints:^{
        [titleLab.left_attr equalTo:bgView2.left_attr constant:IPhone_7_Scale_Width(12)];
        [titleLab.top_attr equalTo:bgView2.top_attr];
        [titleLab.bottom_attr equalTo:bgView2.bottom_attr];

    }];
    
    UILabel *countLab =  [[UILabel alloc]init];
    countLab.font = K_LABEL_SMALL_FONT_14;
    countLab.textColor = TextGrayColor;
    countLab.text = [NSString stringWithFormat:@"（%lu项商品）",self.dataArray.count];
    [countLab sizeToFit];
    [bgView2 addSubview:countLab];
    [countLab activateConstraints:^{
        [countLab.left_attr equalTo:titleLab.right_attr constant:5];
        [countLab.top_attr equalTo:bgView2.top_attr];
        [countLab.bottom_attr equalTo:bgView2.bottom_attr];
        
    }];

    return headView;
}

//到店取。打个店
-(void)btnClick:(UIButton *)btn{
    
    if (btn == _reachStoreBT) {
        btn.selected = YES;
        _callStoreBT.selected = NO;
        
        //修改文案
        _label1.text = @"商家当前位置：长宁区1488弄99号113房";
        _label2.text = @"步行约10分钟 距离530米";
        _textlabe.textColor = App_Nav_BarDefalutColor;
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"自取预留电话：13888888888"];
        [aString addAttribute:NSForegroundColorAttributeName value:TextColor range:NSMakeRange(0,7)];
        _textlabe.attributedText = aString;
        _tap.enabled = YES;
        
        //切换footerview
        _footerBgViewMode1.hidden = NO;
        _footerBgViewMode2.hidden = YES;
    }else{
        
//        _reachStoreBT.selected = NO;
//
//         //修改文案
//        _label1.text = @"目的地：长宁区1488弄99号113房";
//        _label2.text = @"杨先生 15098767890";
//        _textlabe.textColor = TextColor;
//        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"大约 16: 00 到达"];
//        [aString addAttribute:NSForegroundColorAttributeName value:App_Nav_BarDefalutColor range:NSMakeRange(3,6)];
//        _textlabe.attributedText = aString;
//        _tap.enabled = NO;
//
//        //切换footerview
//        _footerBgViewMode1.hidden = YES;
//        _footerBgViewMode2.hidden = NO;

    }
    
}

//打电话
- (void)textLaberAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"打电话");
    NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"13888888888"];UIWebView * callWebview = [[UIWebView alloc] init];[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];[self.view addSubview:callWebview];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return IPhone_7_Scale_Height(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *listCell = @"PaymentOrderCell";
    PaymentOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (!cell) {
        cell = [[PaymentOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        
    }
    cell.productModel = self.dataArray[indexPath.row];
    return cell;
    
}


#pragma mark - bottomView
- (PaymentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[PaymentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_Height - BottomH - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT, SCREEN_Width, BottomH + SafeAreaBottomHeight)];
        [_bottomView.paymentBT addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

#pragma mark - 去支付
-(void)paymentClick:(UIButton*)btn{
    
    [_paymentActionSheetView showView];
    
}


#pragma mark - 收缩视图
- (PaymentActionSheetView *)paymentActionSheetView
{
    if (!_paymentActionSheetView) {
        _paymentActionSheetView = [[PaymentActionSheetView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT)];
        _paymentActionSheetView.payBusinessCode = _payBusinessCode;
        _paymentActionSheetView.hidden = YES;
        [_paymentActionSheetView.paymentBT addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paymentActionSheetView;
}
//支付
//-(void)goToPay{
//    self.paymentSuccessView.hidden = NO;
//}

#pragma mark - 支付成功视图
- (PaymentSuccessView *)paymentSuccessView
{
    if (!_paymentSuccessView) {
        _paymentSuccessView = [[PaymentSuccessView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TopBarHeight)];
        _paymentSuccessView.hidden = YES;
        [_paymentSuccessView.completeBT addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _paymentSuccessView;
}

#pragma mark - 导航跳转
-(void)goToShopAddress:(UITapGestureRecognizer *)tap{
    [PattayaTool goNavtionMap:_shopModel.lat log:_shopModel.lon];
}

//支付完成
-(void)completeClick{
    self.paymentSuccessView.hidden = YES;
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    if (index == 0) {
        //购物车
        NSLog(@"购物车");
    }else{
        //消息中心
        NSLog(@"消息中心");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
