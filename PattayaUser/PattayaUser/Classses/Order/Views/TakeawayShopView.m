//
//  TakeawayShopView.m
//  PattayaUser
//
//  Created by yanglei on 2018/9/27.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "TakeawayShopView.h"
#import "ShopScrollView.h"
#import "ShoppingBottomView.h"
#import "ShopActionSheetView.h"
#import "PaymentOrderVC.h"

@interface TakeawayShopView()<ShopScrollViewDelegate,CAAnimationDelegate>
{
    
    int count;
    float totalAmount;
}

@property (nonatomic , strong) ShopScrollView *productListView;///<商品列表
@property (nonatomic , strong) ShopActionSheetView *shopActionSheetView;///收缩视图
@property (nonatomic , strong) ShoppingBottomView *bottomView;///底部视图


@property (nonatomic, strong) UIImageView *headImage;//商店头像
@property (nonatomic, strong) UILabel *nameLabel;//商店名称
@property (nonatomic, strong) UILabel *chainLabel;//连锁
@property (nonatomic, strong) UILabel *hotLabel;//热力值
@property (nonatomic, strong) UIImageView *hotImg;//热力值
@property (nonatomic, strong) UILabel *licenseTag;//车牌号
@property (nonatomic, strong) UILabel *serviceCharge;//服务费
@property (nonatomic, strong) UIImageView *locationImg;//定位图标
@property (nonatomic, strong) UILabel *locationLabel;//定位文字
@property (nonatomic, strong) UILabel *cutLine;//分割线
@property (nonatomic, strong) UIImageView *promotionImg1;//推广图标1
@property (nonatomic, strong) UILabel *promotionLabel;//推广文字1
@property (nonatomic, strong) UIImageView *promotionImg2;//推广图标2
@property (nonatomic, strong) UILabel *promotionLabel2;//推广文字2

@property (nonatomic, strong) UIImageView *shakeImg;//摇摆视图
@property (nonatomic, assign) NSInteger *count;//摇摆次数

@end

@implementation TakeawayShopView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame  withGroupID:(NSString *)groupId withModel:(ShopModel*)model
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _shopModel = model;
        [self requestGetProductGroupInfo_new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeselectcount) name:@"changeselectcount" object:nil];

    }
    return self;
}

#pragma mark - 选择商品
-(void)changeselectcount{
    //改变底部视图UI
    [self.bottomView changeBottomUIWith:_shopModel];
   
  
}

#pragma mark -  [店铺详情]
//根据容器ID,获取对应的源ID
-(void)requestGetProductGroupInfo_new {
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop.json" ofType:nil]];
    [self analysisData:dataDict];

}

- (void)analysisData:(NSDictionary *)dic{
    //顶部视图
     [self setHeaderView];
    //创建滚动视图
    [self addSubview:self.productListView];
    //创建shopActionSheetView
    [self addSubview:self.shopActionSheetView];
    //创建bottomview
    [self addSubview:self.bottomView];
 
}

#pragma mark - 顶部视图
-(void)setHeaderView{
    //顶部视图
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, IPhone_7_Scale_Height(10), self.width,ShopHeadH-IPhone_7_Scale_Height(20))];
    headerView.backgroundColor = UIColorWhite;
    headerView.userInteractionEnabled = YES;
    [self addSubview:headerView];
    
    [headerView addSubview:self.headImage];
    [headerView addSubview:self.nameLabel];
    [headerView addSubview:self.chainLabel];
    [headerView addSubview:self.hotLabel];
    [headerView addSubview:self.hotImg];
    [headerView addSubview:self.licenseTag];
    [headerView addSubview:self.serviceCharge];
    [headerView addSubview:self.locationImg];
    [headerView addSubview:self.locationLabel];
    
    [headerView addSubview:self.cutLine];
    
    [self addSubview:self.promotionImg1];
    [self addSubview: self.promotionImg2];
    [self addSubview:self.promotionLabel];
    [self addSubview:self.promotionLabel2];
    [self addSubview:self.shakeImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callStore:)];
    [self.shakeImg addGestureRecognizer:tap];
    
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
            self.shakeImg.frame = CGRectMake( IPhone_7_Scale_Width(258), - IPhone_7_Scale_Width(85)/90*150/2, IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(85)/90*150);
    
        } completion:^(BOOL finished) {
      
            //开始摆动动画
            CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            momAnimation.fromValue = [NSNumber numberWithFloat:-0.3];
            momAnimation.toValue = [NSNumber numberWithFloat:0.3];
            momAnimation.duration = 0.3;
            momAnimation.repeatCount = 2;
            momAnimation.autoreverses = YES;
            self.shakeImg.layer.anchorPoint = CGPointMake(0.5, 0);
            //momAnimation.delegate = self;
            [self.shakeImg.layer addAnimation:momAnimation forKey:@"animateLayer"];
            
//            [UIView animateWithDuration:2.0 delay:1.5 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
//                self.shakeImg.frame = CGRectMake( IPhone_7_Scale_Width(258), -200, IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(145));
//
//            } completion:nil];
            
    
        }];
   
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
//           self.shakeImg.frame = CGRectMake( IPhone_7_Scale_Width(258), 0, IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(145));
//
//        } completion:nil];

}
#pragma mark - 商品
- (ShopScrollView *)productListView
{
    if (!_productListView) {   
        _productListView = [[ShopScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT) withShopModel:_shopModel withGroupID:nil currentVC:[self viewController]];
        _productListView.showsVerticalScrollIndicator = NO;
        _productListView.backgroundColor = [UIColor clearColor];
        _productListView.scrollDelegate = self;
    }
    return _productListView;
}

#pragma mark - 收缩视图
- (ShopActionSheetView *)shopActionSheetView
{
    if (!_shopActionSheetView) {
        _shopActionSheetView = [[ShopActionSheetView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT - BottomH)];
        _shopActionSheetView.hidden = YES;
        
    }
    return _shopActionSheetView;
}


#pragma mark - bottomView
- (ShoppingBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[ShoppingBottomView alloc]initWithFrame:CGRectMake(0, self.height - BottomH - TopBarHeight - IPHONE_SAFEBOTTOMAREA_HEIGHT, self.width, BottomH + IPHONE_SAFEBOTTOMAREA_HEIGHT)];
        _bottomView.shopModel = _shopModel;
        [_bottomView.shopCarBT addTarget:self action:@selector(shopCarClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.settleAccountsBT addTarget:self action:@selector(settleAccountsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

#pragma mark -购物车按钮
-(void)shopCarClick:(UIButton *)btn{
    NSLog(@"购物车");
  
    [self.shopActionSheetView showViewWith:_shopModel];
}

#pragma mark -去结算
-(void)settleAccountsClick:(UIButton *)btn{
    NSLog(@"去结算");
    PaymentOrderVC *vc = [[PaymentOrderVC alloc]init];
    vc.shopModel = _shopModel;
    [[self getController].navigationController pushViewController:vc animated:YES];
    
}


- (void)ListScrollViewDropDown:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.transform = CGAffineTransformMakeTranslation(0, 0);//self.height
       
    } completion:^(BOOL finished) {
       
        _productListView.isStopAnimation = YES;
        _productListView.contentOffset = CGPointZero;
    }];
    
}

#pragma mark - 打个店
-(void)callStore:(UITapGestureRecognizer *)tap{
    
}

#pragma mark 手势 多个手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - 懒加载
- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(18), IPhone_7_Scale_Height(12), IPhone_7_Scale_Width(60), IPhone_7_Scale_Width(60))];
        [_headImage sd_setImageWithURL:[NSURL URLWithString:_shopModel.avatarURL] placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
    }
    return _headImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(14), IPhone_7_Scale_Height(22), 0, 22)];
        _nameLabel.textColor = TextColor;
        _nameLabel.font = K_LABEL_SMALL_FONT_16;
        _nameLabel.text = _shopModel.name;
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)chainLabel {
    if (!_chainLabel) {
        _chainLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.YD_right+IPhone_7_Scale_Width(8),IPhone_7_Scale_Height(20), IPhone_7_Scale_Width(42), IPhone_7_Scale_Height(24))];
        _chainLabel.font = K_LABEL_SMALL_FONT_14;
        _chainLabel.text = @"连锁";
        _chainLabel.textAlignment = NSTextAlignmentCenter;
        _chainLabel.textColor = UIColorWhite;
        _chainLabel.backgroundColor = UIColorFromRGB(0x328CE2);
        _chainLabel.layer.cornerRadius = 3;
        _chainLabel.layer.masksToBounds = true;
    }
    return _chainLabel;
}

- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(14),self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(10),0 , IPhone_7_Scale_Height(17))];
        _hotLabel.textColor = TextGrayColor;
        _hotLabel.font = K_LABEL_SMALL_FONT_12;
        _hotLabel.text = @"热力值";
        [_hotLabel sizeToFit];
        
    }
    return _hotLabel;
}

- (UIImageView *)hotImg {
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.hotLabel.YD_right + 5 , self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(11), IPhone_7_Scale_Width(36), IPhone_7_Scale_Height(11))];
        _hotImg.image = [UIImage imageNamed:@"main_cell_hotstar2"];
        
    }
    return _hotImg;
}

- (UILabel *)licenseTag {
    if (!_licenseTag) {
        _licenseTag = [[UILabel alloc]initWithFrame:CGRectMake(self.hotImg.YD_right + IPhone_7_Scale_Width(10) ,self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(10), 0, IPhone_7_Scale_Height(17))];
        _licenseTag.textColor = TextGrayColor;
        _licenseTag.font = K_LABEL_SMALL_FONT_12;
        _licenseTag.text = _shopModel.deviceNo;
        [_licenseTag sizeToFit];
    }
    return _licenseTag;
}

- (UILabel *)serviceCharge {
    if (!_serviceCharge) {
        _serviceCharge = [[UILabel alloc]initWithFrame:CGRectMake(self.licenseTag.YD_right + IPhone_7_Scale_Width(10) ,self.nameLabel.YD_bottom+ IPhone_7_Scale_Height(10), 0, IPhone_7_Scale_Height(17))];
        _serviceCharge.textColor = TextGrayColor;
        _serviceCharge.font = K_LABEL_SMALL_FONT_12;
        _serviceCharge.text = @"打店服务费9元";
        [_serviceCharge sizeToFit];
    }
    return _serviceCharge;
}

- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(24),self.headImage.YD_bottom + IPhone_7_Scale_Height(7), IPhone_7_Scale_Width(10), IPhone_7_Scale_Width(10)/12*15)];
        _locationImg.image = [UIImage imageNamed:@"location"];
    }
    return _locationImg;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.locationImg.YD_right + IPhone_7_Scale_Width(12) ,self.headImage.YD_bottom+ IPhone_7_Scale_Height(6), 0, IPhone_7_Scale_Height(20))];
        _locationLabel.textColor = TextColor;
        _locationLabel.font = K_LABEL_SMALL_FONT_14;
        _locationLabel.text = [_shopModel.storeAddress isEqualToString:@""] ? @"定位失败" : _shopModel.storeAddress;
        [_locationLabel sizeToFit];
    }
    return _locationLabel;
}


- (UILabel *)cutLine {
    if (!_cutLine) {
        _cutLine = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.locationLabel.YD_bottom+ IPhone_7_Scale_Height(12), self.width, 1)];
        _cutLine.backgroundColor = LineColor;
    }
    return _cutLine;
}

- (UIImageView *)promotionImg1 {
    if (!_promotionImg1) {
        _promotionImg1 = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(25), self.cutLine.YD_bottom + IPhone_7_Scale_Height(24), IPhone_7_Scale_Width(10), IPhone_7_Scale_Width(10))];
        _promotionImg1.image = [UIImage imageNamed:@"main_cell_icon1"];
    }
    return _promotionImg1;
}


- (UIImageView *)promotionImg2 {
    if (!_promotionImg2) {
        _promotionImg2 = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(25), self.promotionImg1.YD_bottom+ IPhone_7_Scale_Height(14), IPhone_7_Scale_Width(10), IPhone_7_Scale_Width(10))];
        _promotionImg2.image = [UIImage imageNamed:@"main_cell_icon2"];
    }
    return _promotionImg2;
}

- (UILabel *)promotionLabel {
    if (!_promotionLabel) {
        _promotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + IPhone_7_Scale_Width(10) ,self.cutLine.YD_bottom + IPhone_7_Scale_Height(21), 0, IPhone_7_Scale_Height(20))];
        _promotionLabel.textColor = TextColor;
        _promotionLabel.font = K_LABEL_SMALL_FONT_14;
        _promotionLabel.text = @"推广期间，在线购物免打店服务费";
        [_promotionLabel sizeToFit];
        _promotionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel;
}

- (UILabel *)promotionLabel2 {
    if (!_promotionLabel2) {
        _promotionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + IPhone_7_Scale_Width(10) ,self.promotionLabel.YD_bottom+ IPhone_7_Scale_Height(10), 0, IPhone_7_Scale_Height(20))];
        _promotionLabel2.textColor = TextColor;
        _promotionLabel2.font = K_LABEL_SMALL_FONT_14;
        _promotionLabel2.text = @"每天19：00后，所有菜品5折优惠";
        [_promotionLabel2 sizeToFit];
        _promotionLabel2.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel2;
}

- (UIImageView *)shakeImg {
    if (!_shakeImg) {
        _shakeImg = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(258), -IPhone_7_Scale_Width(85)/90*150, IPhone_7_Scale_Width(85), IPhone_7_Scale_Width(85)/90*150)];
        _shakeImg.image = [UIImage imageNamed:@"shake"];
    }
    return _shakeImg;
}




@end
