//
//  Card.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "XLCard.h"
#import "XLCardItem.h"
#import "RecommendationCell.h"
#import "ShopMainVC.h"

@interface XLCard ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headImage;//商店头像
@property (nonatomic, strong) UILabel *nameLabel;//商店名称
@property (nonatomic, strong) UILabel *chainLabel;//连锁
@property (nonatomic, strong) UILabel *serviceCharge;//服务费
@property (nonatomic, strong) UIImageView *locationImg;//定位图标
@property (nonatomic, strong) UILabel *distance;//距离
@property (nonatomic, strong) UILabel *hotLabel;//热力值
@property (nonatomic, strong) UIImageView *hotImg;//热力值
@property (nonatomic, strong) UILabel *cutLine;//分割线
@property (nonatomic, strong) UIImageView *promotionImg1;//推广图标1
@property (nonatomic, strong) UILabel *promotionLabel;//推广文字1
@property (nonatomic, strong) UIImageView *promotionImg2;//推广图标2
@property (nonatomic, strong) UILabel *promotionLabel2;//推广文字2
@property (nonatomic, strong) UILabel *littleLabel;//黑色小间隔图标
@property (nonatomic, strong) UILabel *recommendation;//精品推荐
@property (nonatomic, strong) UIButton *searchAllBtn;//查看全部
@property (nonatomic, strong) UIImageView *arrowImg;//箭头

@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation XLCard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.chainLabel];
    [self addSubview:self.hotLabel];
    [self addSubview:self.hotImg];
    [self addSubview:self.distance];
    [self addSubview:self.cutLine];
    
    [self addSubview:self.promotionImg1];
    [self addSubview: self.promotionImg2];
    [self addSubview:self.promotionLabel];
    [self addSubview:self.promotionLabel2];
    [self addSubview:self.littleLabel];
    [self addSubview:self.recommendation];
    [self addSubview:self.searchAllBtn];
    [self addSubview:self.arrowImg];
    
    [self addCollectionView];
    
    
}

#pragma mark - 懒加载
- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(28), IPhone_7_Scale_Width(26), IPhone_7_Scale_Width(50), IPhone_7_Scale_Width(50))];
        _headImage.image = [UIImage imageNamed:@"main_cell_headImg_bg"];
    }
    return _headImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(10), IPhone_7_Scale_Width(25), 0, IPhone_7_Scale_Width(25))];
        _nameLabel.textColor = TextColor;
        _nameLabel.font = K_LABEL_SMALL_FONT_18;
        _nameLabel.text = @"九华时蔬  ";
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)chainLabel {
    if (!_chainLabel) {
        _chainLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.YD_right+IPhone_7_Scale_Width(8),self.nameLabel.YD_top + IPhone_7_Scale_Width(3.5), IPhone_7_Scale_Width(32), IPhone_7_Scale_Width(18))];
        _chainLabel.font = K_LABEL_SMALL_FONT_10;
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
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+IPhone_7_Scale_Width(10),self.nameLabel.YD_bottom+ IPhone_7_Scale_Width(7), 0, IPhone_7_Scale_Width(14))];
        _hotLabel.textColor = TextGrayColor;
        _hotLabel.font = K_LABEL_SMALL_FONT_10;
        _hotLabel.text = @"热力值";
        [_hotLabel sizeToFit];
        _hotLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _hotLabel;
}

- (UIImageView *)hotImg {
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.hotLabel.YD_right + IPhone_7_Scale_Width(7), self.hotLabel.YD_top+ IPhone_7_Scale_Width(1.5), IPhone_7_Scale_Width(36), IPhone_7_Scale_Width(11))];
        _hotImg.image = [UIImage imageNamed:@"main_cell_hotstar2"];
    }
    return _hotImg;
}

- (UILabel *)distance {
    if (!_distance) {
        _distance = [[UILabel alloc]initWithFrame:CGRectMake(self.width - IPhone_7_Scale_Width(50 + 14) ,self.nameLabel.YD_bottom+ IPhone_7_Scale_Width(7), IPhone_7_Scale_Width(50), IPhone_7_Scale_Width(14))];
        _distance.textColor = TextGrayColor;
        _distance.font = K_LABEL_SMALL_FONT_10;
        _distance.text = @"距离130m";
        _distance.textAlignment = NSTextAlignmentRight;
       
    }
    return _distance;
}

- (UILabel *)cutLine {
    if (!_cutLine) {
        _cutLine = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.hotLabel.YD_bottom+ IPhone_7_Scale_Width(22.5), self.width, 1)];
        _cutLine.backgroundColor = LineColor;
    }
    return _cutLine;
}

- (UIImageView *)promotionImg1 {
    if (!_promotionImg1) {
        _promotionImg1 = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(17), self.cutLine.YD_bottom+ IPhone_7_Scale_Width(9), IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12))];
        _promotionImg1.image = [UIImage imageNamed:@"main_cell_icon1"];
    }
    return _promotionImg1;
}


- (UIImageView *)promotionImg2 {
    if (!_promotionImg2) {
        _promotionImg2 = [[UIImageView alloc]initWithFrame:CGRectMake( IPhone_7_Scale_Width(17), self.promotionImg1.YD_bottom+ IPhone_7_Scale_Width(5), IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12))];
        _promotionImg2.image = [UIImage imageNamed:@"main_cell_icon2"];
    }
    return _promotionImg2;
}

- (UILabel *)promotionLabel {
    if (!_promotionLabel) {
        _promotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + IPhone_7_Scale_Width(10) ,self.cutLine.YD_bottom+ IPhone_7_Scale_Width(7.5), IPhone_7_Scale_Width(200), IPhone_7_Scale_Width(15))];
        _promotionLabel.textColor = TextColor;
        _promotionLabel.font = K_LABEL_SMALL_FONT_10;
        _promotionLabel.text = @"推广期间，在线购物免打店服务费";
        _promotionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel;
}

- (UILabel *)promotionLabel2 {
    if (!_promotionLabel2) {
        _promotionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + IPhone_7_Scale_Width(10) ,self.promotionLabel.YD_bottom+ IPhone_7_Scale_Width(1.5), IPhone_7_Scale_Width(200), IPhone_7_Scale_Width(15))];
        _promotionLabel2.textColor = TextColor;
        _promotionLabel2.font = K_LABEL_SMALL_FONT_10;
        _promotionLabel2.text = @"每天19：00后，所有菜品5折优惠";
        _promotionLabel2.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel2;
}

- (UILabel *)littleLabel {
    if (!_littleLabel) {
        _littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(12) ,self.promotionImg2.YD_bottom+ IPhone_7_Scale_Width(15.5), IPhone_7_Scale_Width(2), IPhone_7_Scale_Width(8))];
        _littleLabel.backgroundColor = UIColorFromRGB(0x4a4a4a);
    }
    return _littleLabel;
}

- (UILabel *)recommendation {
    if (!_recommendation) {
        _recommendation = [[UILabel alloc]initWithFrame:CGRectMake(self.littleLabel.YD_right + IPhone_7_Scale_Width(10) ,self.promotionLabel2.YD_bottom+ IPhone_7_Scale_Width(9.5), IPhone_7_Scale_Width(60), IPhone_7_Scale_Width(17))];
        _recommendation.textColor =  UIColorFromRGB(0x4a4a4a);
        _recommendation.font = UIBoldFont(12);
        _recommendation.text = @"精品推荐";
        _recommendation.textAlignment = NSTextAlignmentLeft;
    }
    return _recommendation;
}

- (UIButton *)searchAllBtn {
    if (!_searchAllBtn) {
        _searchAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - IPhone_7_Scale_Width(23+50) ,self.promotionLabel2.YD_bottom + IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(50), IPhone_7_Scale_Width(14))];
        [_searchAllBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [_searchAllBtn addTarget:self action:@selector(searchAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _searchAllBtn.titleLabel.font = K_LABEL_SMALL_FONT_10;
        [_searchAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    }
    return _searchAllBtn;
}

-(void)searchAllBtnClick:(UIButton*)btn{
    
    ShopMainVC *vc = [[ShopMainVC alloc]init];
    vc.model = _item;
    [[self getController].navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - IPhone_7_Scale_Width(8+12) ,self.promotionLabel2.YD_bottom + IPhone_7_Scale_Width(15), IPhone_7_Scale_Width(8), IPhone_7_Scale_Width(8))];
        _arrowImg.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImg;
}

-(void)addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.recommendation.YD_bottom, self.width, self.height - self.recommendation.YD_bottom - IPhone_7_Scale_Width(20)) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerClass:[RecommendationCell class] forCellWithReuseIdentifier:@"RecommendationCell"];
}

-(void)setItem:(ShopModel *)item {
    _item = item;
    _nameLabel.text = item.name;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.avatarURL] placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
    if (item.geoDistance) {
         _distance.text = [NSString stringWithFormat: @"距离%@米",item.geoDistance];
    }else{
        _distance.hidden = YES;
    }
   
    [self.collectionView reloadData];
}


#pragma mark -- UICollectionViewDataSource

#pragma mark  设置CollectionCell的内容
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _item.goodsList.count < 6 ? _item.goodsList.count : 6;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identify = @"RecommendationCell";
    RecommendationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.
    item = _item.goodsList[indexPath.row];
    return cell;
}

//#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.width - IPhone_7_Scale_Width(18*2+12*2))/3, (self.collectionView.height - IPhone_7_Scale_Width(24))/2);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12), IPhone_7_Scale_Width(12));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return IPhone_7_Scale_Height(10);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return IPhone_7_Scale_Width(15);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopMainVC *vc = [[ShopMainVC alloc]init];
    vc.model = _item;
    [[self getController].navigationController pushViewController:vc animated:YES];

}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
