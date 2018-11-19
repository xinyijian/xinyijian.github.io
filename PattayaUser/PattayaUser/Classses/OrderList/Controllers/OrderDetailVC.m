//
//  PaymentOrderVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderDetailVC.h"
#import "PaymentOrderCell.h"
#import "PaymentBottomView.h"
#import "PaymentActionSheetView.h"
#import "PaymentDetailCell.h"
#import "RefundVC.h"
#import "EvaluateOrderVC.h"

#define TITLES @[@"联系客服",@"删除订单"]
#define ICONS  @[@"icon_phonecall",@"icon_deleteorder"]

#define TITLES2 @[@"联系客服"]
#define ICONS2  @[@"icon_phonecall"]


@interface OrderDetailVC ()<YBPopupMenuDelegate>
//导航栏按钮
@property (nonatomic, strong) UIButton *rightPopBT;
//头部视图
@property (nonatomic, strong) UILabel *label1;//label1
@property (nonatomic, strong) UILabel *label2;//label2
@property (nonatomic, strong) UILabel *label3;//label3
@property (nonatomic, strong) UILabel *label4;//label4

@property (nonatomic, strong) UILabel *orderStatusLabel;//订单状态
@property (nonatomic, strong) UIButton * evaluateOrderBT;//评价订单
@property (nonatomic, strong) UIButton * againOrderBT;//再来一单

//中间视图 优惠 价格
@property (nonatomic, strong) UILabel *discountLabel;//减免优惠
@property (nonatomic, strong) UILabel *redPacketLabel;//首单红包
@property (nonatomic, strong) UILabel * picesLabel;//价格
@property (nonatomic, strong) UILabel * totalDiscountLabel;//以优惠


@property (nonatomic, strong) UIView *footerBgViewMode1;//footer视图模式1
@property (nonatomic, strong) UIView *footerBgViewMode2;//footer视图模式2
@property (nonatomic, strong) UIView * lineView;//footer视图模式1 的分割线

@property (nonatomic, strong) PaymentBottomView *bottomView;//底部视图
@property (nonatomic, strong) PaymentActionSheetView *paymentActionSheetView;//收缩视图
@property (nonatomic, strong) NSArray * arrdata;
@property (nonatomic, strong) NSArray * arrTiltle;

@property (nonatomic, assign) NSInteger timeNumber;//倒计时时间


@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    NSString * paymentDESC = [PattayaTool isNull:_orderModel.paymentTypeIdDESC] ? @"" : _orderModel.paymentTypeIdDESC;
    
    if (_enterType == 1) {
        _arrdata = @[[PattayaTool ConvertStrToTime:_proccesingModel.timeCreated]];
        _arrTiltle = @[@"下单时间"];
    }else {
        _arrdata = @[_orderModel.id,[PattayaTool ConvertStrToTime:_orderModel.createTime],paymentDESC,
                     _orderModel.storeName];
        _arrTiltle = @[@"订单编号",@"下单时间",@"支付方式",@"收款商家"];
    }
   
    
    [self setupUI];
    
    [self netRequestData];
    
}

-(void)setupUI{
    [super setupUI];
    
    //导航栏
   
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:self.rightPopBT];
    self.navigationItem.rightBarButtonItem=rightitem;
    
   
    [self.tableView setSeparatorColor:UIColorWhite];
 
}

-(void)netRequestData{
    if (_enterType == 1 ) {
        @weakify(self);
        [[PattayaUserServer singleton] getcallorderRequest:_proccesingModel.id Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
            NSLog(@"%@",ret);
            @strongify(self);
            if ([ResponseModel isData:ret]) {
                
                if ( [ret[@"data"][@"status"] isEqualToString:@"CALLING"]) {
                    self.timeNumber = ret[@"data"][@"timeLeft"] ? [ret[@"data"][@"timeLeft"] integerValue] : 300;
                    [self timeNumss];
                    
                }else{
                    [self checkCreateOrderRequest];
                }

            } else
            {
                [YDProgressHUD showMessage:ret[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
       
    }

    
}

#pragma mark - tableView datasource && delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.enterType == 1 ? 1 : _orderModel.detailList.count;
    }else if (section == 1){
        return _arrTiltle.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return IPhone_7_Scale_Height(60);
    }
    return IPhone_7_Scale_Height(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if (section == 0){
       return self.enterType == 1 ? IPhone_7_Scale_Height(187 + 80) : IPhone_7_Scale_Height(187);
    }
    return IPhone_7_Scale_Height(50 + 20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return _enterType == 1 ?  IPhone_7_Scale_Height(136) : IPhone_7_Scale_Height(68);
    }
   
    return  0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    //模式1--------------------------
    [self createFooterBgviewMode1];
    [footView addSubview:_footerBgViewMode1];
//
//    //模式2--------------------------
//    [self createFooterBgviewMode2];
//    [footView addSubview:_footerBgViewMode2];
    if (section == 0) {
        return footView;
    }
    return nil;
}


//footerBgView模式1
-(void)createFooterBgviewMode1{
    
    _footerBgViewMode1 = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), 1, SCREEN_Width - IPhone_7_Scale_Width(8*2),  _enterType == 1 ?  IPhone_7_Scale_Height(136) : IPhone_7_Scale_Height(68))];
    _footerBgViewMode1.backgroundColor = UIColorWhite;
    //[footView addSubview:_footerBgViewMode1];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_footerBgViewMode1.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _footerBgViewMode1.bounds;
    maskLayer.path = maskPath.CGPath;
    _footerBgViewMode1.layer.mask = maskLayer;
    
   
    if (self.enterType == 1) {
        
        UIImageView *discountImg = [[UIImageView alloc]init];
        discountImg.image = [UIImage imageNamed:@"tag_jianmian"];
        [_footerBgViewMode1 addSubview:discountImg];
        [discountImg activateConstraints:^{
            [discountImg.left_attr equalTo:_footerBgViewMode1.left_attr constant:IPhone_7_Scale_Width(12)];
            discountImg.height_attr.constant = IPhone_7_Scale_Height(21);
            discountImg.width_attr.constant = IPhone_7_Scale_Height(52);
            [discountImg.top_attr equalTo:_footerBgViewMode1.top_attr constant:IPhone_7_Scale_Height(23.5)];
            
        }];
        
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.text = @"-￥9.00";
        _discountLabel.font = K_LABEL_SMALL_FONT_14;
        _discountLabel.textColor = UIColorFromRGB(0xF55E23);
        [_discountLabel sizeToFit];
        [_footerBgViewMode1 addSubview: _discountLabel];
        [_discountLabel activateConstraints:^{
            [_discountLabel.right_attr equalTo:_footerBgViewMode1.right_attr constant:IPhone_7_Scale_Width(-13)];
            [_discountLabel.top_attr equalTo:_footerBgViewMode1.top_attr constant:IPhone_7_Scale_Height(23)];
            _discountLabel.height_attr.constant = IPhone_7_Scale_Height(22);
        }];
        
        //分割线
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
        [_footerBgViewMode1 addSubview:_lineView];
        [_lineView activateConstraints:^{
            [_lineView.right_attr equalTo:_footerBgViewMode1.right_attr];
            [_lineView.left_attr equalTo:_footerBgViewMode1.left_attr];
            [_lineView.top_attr equalTo:_discountLabel.bottom_attr constant:IPhone_7_Scale_Height(23)];
            _lineView.height_attr.constant = 1;
        }];
        
        
    }

    //价格
    _picesLabel= [[UILabel alloc] init];
    _picesLabel.text = _enterType == 1 ? @"￥0.00" : [NSString stringWithFormat:@"￥%@",_orderModel.orderTotal];
    _picesLabel.font = fontStely(@"PingFangSC-Regular", 19);
    [_picesLabel sizeToFit];
    _picesLabel.textColor = UIColorBlack;
    [_footerBgViewMode1 addSubview:_picesLabel];
    [_picesLabel activateConstraints:^{
       
        [_picesLabel.top_attr equalTo:_enterType==1 ?_lineView.bottom_attr : _footerBgViewMode1.top_attr constant:IPhone_7_Scale_Height(10)];
        [_picesLabel.right_attr equalTo:_footerBgViewMode1.right_attr constant:IPhone_7_Scale_Width(-13)];
        _picesLabel.height_attr.constant = IPhone_7_Scale_Height(27);
    }];
    
    //实付
    UILabel * shifu= [[UILabel alloc] init];
    shifu.text = @"实付";
    shifu.font = fontStely(@"PingFangSC-Regular", 12);
    [shifu sizeToFit];
    shifu.textColor = UIColorFromRGB(0x4a4a4a);
    [_footerBgViewMode1 addSubview:shifu];
    [shifu activateConstraints:^{
        [shifu.right_attr equalTo:_picesLabel.left_attr constant:-3];
        shifu.height_attr.constant = IPhone_7_Scale_Height(17);
        shifu.centerY_attr = _picesLabel.centerY_attr;
    }];
    
    //以优惠
    _totalDiscountLabel= [[UILabel alloc] init];
    _totalDiscountLabel.text = @"已优惠￥9.00";
    _totalDiscountLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [_totalDiscountLabel sizeToFit];
    _totalDiscountLabel.textColor = TextGrayColor;
    [_footerBgViewMode1 addSubview:_totalDiscountLabel];
    if (self.enterType != 1) {
        
    }
    _totalDiscountLabel.hidden = YES;
    
    [_totalDiscountLabel activateConstraints:^{
        [_totalDiscountLabel.top_attr equalTo:_picesLabel.bottom_attr];
        [_totalDiscountLabel.right_attr equalTo:_footerBgViewMode1.right_attr constant:IPhone_7_Scale_Width(-13)];
        _totalDiscountLabel.height_attr.constant = IPhone_7_Scale_Height(17);
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
    if (section == 0) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width ,self.enterType == 1 ? IPhone_7_Scale_Height(141):IPhone_7_Scale_Height(81))];
        bgView.backgroundColor = UIColorWhite;
        [headView addSubview:bgView];
        //
        _label1 = [[UILabel alloc] init];
        NSString *str;
        if (_enterType == 0) {
            str = @"您已完成支付，请及时取走商品";
        }else if (_enterType == 1){
            str = [_proccesingModel.status isEqualToString:@"CALLING"] ? @"您已支付完成，正在通知门店接单" : @"门店已经接单，正在前往指定地点";
        }else if (_enterType == 2){
            str = @"商家已收到退款申请";
        }else if (_enterType == 3){
            str = @"退款已完成";
        }
        _label1.text = str;
        _label1.font = K_LABEL_SMALL_FONT_16;
        _label1.textColor = TextColor;
        [_label1 sizeToFit];
        [bgView addSubview: _label1];
        [_label1 activateConstraints:^{
            [_label1.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(21)];
            [_label1.top_attr equalTo:bgView.top_attr constant:IPhone_7_Scale_Height(20)];
            _label1.height_attr.constant = IPhone_7_Scale_Height(22);
        }];
        
        
        //
        _label2 = [[UILabel alloc] init];
        NSString *str2;
        if (_enterType == 0) {
            str2 = @"  ";
        }else if (_enterType == 1){
            str2 = [_proccesingModel.status isEqualToString:@"CALLING"] ? @"若300s内未接单，订单将自动取消并退回款项及优惠券" : @"门店预计16:00到达，若超时未到达，您可以与卖家沟通";
        }else if (_enterType == 2){
            str2 = @"订单金额将原路退回您的资金账户，请注意查收";
        }else if (_enterType == 3){
            str2 = @"订单金额已原路退回您的资金账户";
        }
        _label2.text = str2;
        _label2.font = K_LABEL_SMALL_FONT_14;
        
        _label2.textColor = UIColorFromRGB(0x4A4A4A);
        [_label2 sizeToFit];
        [bgView addSubview: _label2];
        [_label2 activateConstraints:^{
            [_label2.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(21)];
            [_label2.top_attr equalTo:_label1.bottom_attr constant:IPhone_7_Scale_Height(7)];
            _label2.height_attr.constant = IPhone_7_Scale_Height(20);
        }];
        
        if (self.enterType == 1) {
            
            _label3 = [[UILabel alloc] init];
            _label3.text = [NSString stringWithFormat:@"目的地：%@",_proccesingModel.userCallFormattedAddress];
            _label3.font = UIBoldFont(14);
            _label3.textColor = UIColorFromRGB(0x4A4A4A);
            [_label3 sizeToFit];
            [bgView addSubview: _label3];
            [_label3 activateConstraints:^{
                [_label3.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(21)];
                [_label3.top_attr equalTo:_label2.bottom_attr constant:IPhone_7_Scale_Height(16)];
                _label3.height_attr.constant = IPhone_7_Scale_Height(20);
            }];
            
            _label4 = [[UILabel alloc] init];
            _label4.text = [NSString stringWithFormat:@"%@ %@",_proccesingModel.userName,_proccesingModel.userMobile];
            _label4.font = K_LABEL_SMALL_FONT_14;
            _label4.textColor = UIColorFromRGB(0x4A4A4A);
            [_label4 sizeToFit];
            [bgView addSubview: _label4];
            [_label4 activateConstraints:^{
                [_label4.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(21)];
                [_label4.top_attr equalTo:_label3.bottom_attr constant:IPhone_7_Scale_Height(5)];
                _label4.height_attr.constant = IPhone_7_Scale_Height(20);
            }];
            
        }
        
        _orderStatusLabel = [[UILabel alloc] init];
        NSString *str3;
        if (_enterType == 0) {
            str3 = @"已完成";
        }else if (_enterType == 1){
            str3 = [_proccesingModel.status isEqualToString:@"CALLING"] ? @"等待接单" : @"已接单";
        }else if (_enterType == 2){
            str3 = @"退款中";
        }else if (_enterType == 3){
            str3 = @"已退款";
        }
        _orderStatusLabel.text = str3;
        _orderStatusLabel.textColor =App_Nav_BarDefalutColor;
        [_orderStatusLabel sizeToFit];
        _orderStatusLabel.font = fontStely(@"PingFangSC-Regular", 14);
        _orderStatusLabel.textColor = App_Nav_BarDefalutColor;
        [bgView addSubview:_orderStatusLabel];
        [_orderStatusLabel activateConstraints:^{
            [_orderStatusLabel.right_attr equalTo:bgView.right_attr constant:IPhone_7_Scale_Width(-20)];
            _orderStatusLabel.height_attr.constant = IPhone_7_Scale_Height(20);
            _orderStatusLabel.centerY_attr = _label1.centerY_attr;
        }];
        
        
        if (_enterType == 1) {
            //评价订单
            _evaluateOrderBT = [UIButton buttonWithType:UIButtonTypeCustom];
            [_evaluateOrderBT
             setTitle:[_proccesingModel.status isEqualToString:@"CALLING"] ? @"取消订单" : @"联系司机"  forState:UIControlStateNormal];
            [_evaluateOrderBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
            _evaluateOrderBT.titleLabel.font = K_LABEL_SMALL_FONT_10;
            _evaluateOrderBT.backgroundColor = App_Nav_BarDefalutColor;
            _evaluateOrderBT.layer.cornerRadius = 3;
            _evaluateOrderBT.layer.masksToBounds = YES;
            [_evaluateOrderBT addTarget:self action:@selector(evaluateOrder) forControlEvents:UIControlEventTouchUpInside];
            [headView addSubview:_evaluateOrderBT];
            [_evaluateOrderBT activateConstraints:^{
                [_evaluateOrderBT.right_attr equalTo:headView.right_attr constant:IPhone_7_Scale_Width(-20)];
                _evaluateOrderBT.height_attr.constant = IPhone_7_Scale_Width(24);
                _evaluateOrderBT.width_attr.constant = IPhone_7_Scale_Width(46);
                [_evaluateOrderBT.top_attr equalTo:bgView.bottom_attr constant:IPhone_7_Scale_Height(10)];
                
            }];
            
        }
       
        
//        //再来一单
//        _againOrderBT = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_againOrderBT setTitle:@"再来一单" forState:UIControlStateNormal];
//        [_againOrderBT setTitleColor:App_Nav_BarDefalutColor forState:UIControlStateNormal];
//        _againOrderBT.titleLabel.font = K_LABEL_SMALL_FONT_10;
//        _againOrderBT.backgroundColor = App_TotalGrayWhite;
//        _againOrderBT.layer.cornerRadius = 3;
//        _againOrderBT.layer.masksToBounds = YES;
//        _againOrderBT.layer.borderWidth = 1.5;
//        _againOrderBT.layer.borderColor = App_Nav_BarDefalutColor.CGColor;
//        [_againOrderBT addTarget:self action:@selector(againOrder) forControlEvents:UIControlEventTouchUpInside];
//        [headView addSubview:_againOrderBT];
//        [_againOrderBT activateConstraints:^{
//            [_againOrderBT.right_attr equalTo:_evaluateOrderBT.left_attr constant:IPhone_7_Scale_Width(-10)];
//            _againOrderBT.height_attr.constant = IPhone_7_Scale_Width(24);
//            _againOrderBT.width_attr.constant = IPhone_7_Scale_Width(46);
//            [_againOrderBT.top_attr equalTo:bgView.bottom_attr constant:IPhone_7_Scale_Height(10)];
//
//        }];
        
        UIView *bgView2 = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), self.enterType == 1 ? (iPhoneX ? IPhone_7_Scale_Height(287-53)-1 : IPhone_7_Scale_Height(267-44)-1 ): IPhone_7_Scale_Height(136)-1, SCREEN_Width - IPhone_7_Scale_Width(8*2), IPhone_7_Scale_Height(51))];
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
        titleLab.text = @"购物明细";
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
//        countLab.text = @"（2项商品）";
        countLab.text = [NSString stringWithFormat:@"（%ld项商品）",_orderModel.detailList.count];
        [countLab sizeToFit];
        [bgView2 addSubview:countLab];
        if (self.enterType == 1) {
            countLab.hidden = YES;
        }
        [countLab activateConstraints:^{
            [countLab.left_attr equalTo:titleLab.right_attr constant:5];
            [countLab.top_attr equalTo:bgView2.top_attr];
            [countLab.bottom_attr equalTo:bgView2.bottom_attr];
            
        }];
        
        
    }else{
        
//        headView.backgroundColor = App_TotalGrayWhite;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(8), IPhone_7_Scale_Height(20), SCREEN_Width - IPhone_7_Scale_Height(16) , IPhone_7_Scale_Height(45))];
        bgView.backgroundColor = UIColorWhite;
        [headView addSubview:bgView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        
        UILabel *paymentDetailLabel = [[UILabel alloc] init];
        paymentDetailLabel.text = @"付款详情";
        paymentDetailLabel.font = K_LABEL_SMALL_FONT_16;
        paymentDetailLabel.textColor = TextColor;
        [paymentDetailLabel sizeToFit];
        [bgView addSubview: paymentDetailLabel];
        [paymentDetailLabel activateConstraints:^{
            [paymentDetailLabel.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(12)];
            paymentDetailLabel.centerY_attr = bgView.centerY_attr;
            paymentDetailLabel.height_attr.constant = IPhone_7_Scale_Height(22);
        }];
        
    }

    return headView;
}
#pragma mark - 叫店模式下 取消订单 或 联系司机（原评价订单）
-(void)evaluateOrder{
//    EvaluateOrderVC *vc = [[EvaluateOrderVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    if ([_proccesingModel.status isEqualToString:@"CALLING"] ) {
        //取消订单
        WEAK_SELF;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[PattayaUserServer singleton] PUTcallorderRequest:_proccesingModel.id Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                if ([ResponseModel isData:ret]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
        //联系司机
        NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",_proccesingModel.driverMobile];
        UIWebView * callWebview = [[UIWebView alloc] init];[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
        [self.view addSubview:callWebview];
        
    }
   
    
   
    
}
//再来一单
-(void)againOrder{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        
        PaymentOrderCell *paymentCell = [tableView dequeueReusableCellWithIdentifier:@"PaymentOrderCell"];
        if (!paymentCell) {
            paymentCell = [[PaymentOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PaymentOrderCell"];
            paymentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            paymentCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
            
           
           
        }
        if (self.enterType == 1) {
            [paymentCell hiddenSomeViews];
            paymentCell.productImgView.image = [UIImage imageNamed:@"image_service_fee"];
            paymentCell.productNameLabel.text =@"叫店服务费";
            paymentCell.priceLabel.text = @"￥9.00";
            
        }else{
             paymentCell.item = _orderModel.detailList[indexPath.row];
             paymentCell.originalPriceLabel.hidden = YES;
        }
       
        
        cell = paymentCell;
    }else{
        
        PaymentDetailCell *paymentCell = [tableView dequeueReusableCellWithIdentifier:@"PaymentDetailCell"];
        if (!paymentCell) {
            paymentCell = [[PaymentDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PaymentDetailCell"];
            paymentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        paymentCell.title = _arrTiltle[indexPath.row];
        paymentCell.DetailTitle = _arrdata[indexPath.row];
        cell = paymentCell;
        
    }

    return cell;
    
}


#pragma mark - bottomView
- (PaymentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[PaymentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_Height - IPhone_7_Scale_Height(48) - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT, SCREEN_Width, IPhone_7_Scale_Height(48))];
        [_bottomView.paymentBT addTarget:self action:@selector(paymentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

//去支付
-(void)paymentClick:(UIButton*)btn{
    
    [_paymentActionSheetView showView];
    
}


#pragma mark - 收缩视图
- (PaymentActionSheetView *)paymentActionSheetView
{
    if (!_paymentActionSheetView) {
        _paymentActionSheetView = [[PaymentActionSheetView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT)];
        _paymentActionSheetView.hidden = YES;
    }
    return _paymentActionSheetView;
}

#pragma mark - 导航栏按钮
-(UIButton*)rightPopBT{
    if (!_rightPopBT) {
        
        _rightPopBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightPopBT addTarget:self action:@selector(rightPopMenu) forControlEvents:UIControlEventTouchUpInside];
        [_rightPopBT setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [_rightPopBT setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateHighlighted];
    }
    return _rightPopBT;
}


-(void)rightPopMenu{
    
    [YBPopupMenu showRelyOnView:self.rightPopBT titles:_enterType == 1 ? TITLES2 : TITLES icons:ICONS menuWidth:130 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.arrowHeight = 0;
        popupMenu.offset = 10;
        popupMenu.minSpace = 0;
        popupMenu.cornerRadius = 0;
        popupMenu.fontSize = 14;
        popupMenu.textColor = TextGrayColor;
        popupMenu.itemHeight = 44;
        popupMenu.delegate = self;
        popupMenu.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }];
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    
   
    if (index == 0) {
        
        NSLog(@"联系客服");
        
        NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"021-52900810-8038"];
        UIWebView * callWebview = [[UIWebView alloc] init];[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
        [self.view addSubview:callWebview];
   
       
        
    }else if (index == 1){
        
//        NSLog(@"申请退款");
//        RefundVC *vc = [[RefundVC alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        NSLog(@"删除订单");
        WEAK_SELF;
        [[PattayaUserServer singleton] orderCancelRequest:_orderModel.id storeId:_orderModel.storeId success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
    }else if (index == 2){
       
        
    }
}

- (void)checkCreateOrderRequest
{
    
   @weakify(self);
    [[PattayaUserServer singleton] checkCreateOrderRequest:@{@"endLatitude":_proccesingModel.userCallLatitude,@"endLongitude":_proccesingModel.userCallLongitude,@"startLatitude":@"30",@"startLongitude":@"120"} Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        @strongify(self);
        if ([ResponseModel isData:ret]) {//_proccesingModel.driverAcceptedLatitude//_proccesingModel.driverAcceptedLongitude
            NSString * st1= NSLocalizedString(@"距离：",nil);
            NSString * st2= NSLocalizedString(@"大约需要",nil);
            NSString * st3= NSLocalizedString(@"分钟",nil);
            self.label2.text = [NSString stringWithFormat:@"%@%@      %@%@%@",st1,ret[@"data"][@"Distance"],st2,ret[@"data"][@"Duration"],st3];
            
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)timeNumss{
    __block NSInteger second = self.timeNumber;
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
                //自动取消订单
                [[PattayaUserServer singleton] PUTcallorderRequest:_proccesingModel.id Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                    if ([ResponseModel isData:ret]) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    
                }];
                
                second = _timeNumber;
                //(6)
                dispatch_cancel(timer);
            } else {
                
                self.label2.text =[NSString stringWithFormat:@"若%lds内未接单，订单将自动取消并退回款项及优惠券",(long)second] ;
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
