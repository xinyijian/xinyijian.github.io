//
//  TakeawayProductCollectionCell.m
//  AppPark
//
//  Created by 池康 on 2018/7/16.
//

#import "TakeawayProductCollectionCell.h"

@interface TakeawayProductCollectionCell()
{
    NSUInteger  _count;//数据
}
@end

@implementation TakeawayProductCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
//    _count = 0;
//    _productImgView = [[UIImageView alloc] init];
//    [self.contentView addSubview:_productImgView];
//    _productImgView.image = [UIImage imageNamed:@"food"];
//    [_productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(_productImgView.mas_width);
//    }];
//
//    //标记
//    //lab_np@3x:新品，lab_like@2x：网友最爱，lab_red@2x：老板推荐，lab_sie@2x：招牌，
//    _classLabel = [[UILabel alloc] init];
//    _classLabel.text = @"老板推荐 ";
//    _classLabel.textColor = [UIColor whiteColor];
//    _classLabel.font = kFont(12);
//    _classLabel.textAlignment = NSTextAlignmentCenter;
//    _classLabel.backgroundColor = RGB(253, 143, 51);
//    [self.contentView addSubview: _classLabel];
//    [ _classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_productImgView);
//        make.top.mas_equalTo(_productImgView);
//        make.height.mas_equalTo(18);
//    }];
//
//    //lab_np@3x:新品，lab_like@2x：网友最爱，lab_red@2x：老板推荐，lab_sie@2x：招牌，
//    NSMutableAttributedString *str = [AppDefaultUtil returnLineSpacingWithStr:@"这里是标题20字以内，最多两行，这里是标题20字以内，最多两行" withLineSpacing:4 withTextAlignmentCenter:NSTextAlignmentLeft];
//    CGSize size = [AppMethods sizeAttributedWithFont:kFont(14) Str:str withMaxWidth:takeawayRight_W-20];
//    CGFloat height = 20;
//    if (size.height > 20) {
//        height = 40;
//    }
//    _productNameLabel = [[UILabel alloc] init];
//    _productNameLabel.attributedText = str;
//    _productNameLabel.textColor = RGBA(51, 51, 51, 1);
//    _productNameLabel.font = kFont(14);
//    _productNameLabel.numberOfLines = 2;
//    [self.contentView addSubview:_productNameLabel];
//    [_productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(0);
//        make.top.mas_equalTo(_productImgView.mas_bottom).offset(7);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(height);
//    }];
//
//    _monthlySaleLabel = [[UILabel alloc] init];
//    _monthlySaleLabel.text = @"月售121";
//    _monthlySaleLabel.font = kFontNameSize(10);
//    _monthlySaleLabel.textColor = RGB(102, 102, 102);
//    [self.contentView addSubview:_monthlySaleLabel];
//    [_monthlySaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_productNameLabel);
//        make.top.mas_equalTo(_productNameLabel.mas_bottom).offset(8);
//        make.height.mas_equalTo(10);
//    }];
//
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = RGB(226, 226, 226);
//    [self.contentView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_monthlySaleLabel.mas_right).offset(6);
//        make.centerY.mas_equalTo(_monthlySaleLabel);
//        make.width.mas_equalTo(1);
//        make.height.mas_equalTo(6);
//    }];
//
//    _fabulousCountLabel = [[UILabel alloc] init];
//    _fabulousCountLabel.text = @"赞12";
//    _fabulousCountLabel.font = kFontNameSize(10);
//    _fabulousCountLabel.textColor = RGB(102, 102, 102);
//    [self.contentView addSubview:_fabulousCountLabel];
//    [_fabulousCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lineView.mas_right).offset(8);
//        make.centerY.mas_equalTo(lineView);
//    }];
//
//    _spicypBgView = [[UIView alloc] init];
//    _spicypBgView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:_spicypBgView];
//    [_spicypBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_fabulousCountLabel.mas_right).offset(5);
//        make.centerY.mas_equalTo(_fabulousCountLabel);
//        make.height.mas_equalTo(10);
//        make.width.mas_equalTo(4+2+4+2+4);
//    }];
//
//    for (NSInteger i = 0; i < 3; i ++) {
//        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 6, 0, 4, 10)];
//        starImgView.image = [UIImage imageNamed:@"icon_chili"];
//
//        [_spicypBgView addSubview:starImgView];
//    }
//
//    //优惠后的价格
//    _priceLabel = [[UILabel alloc] init];
//    _priceLabel.text = @"¥28";
//    _priceLabel.font = kFontNameSize(14);
//    _priceLabel.textColor = RGB(246, 90, 66);
//    [self.contentView addSubview: _priceLabel];
//    [ _priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_productNameLabel);
//        make.top.mas_equalTo(_productImgView.mas_bottom).offset(73);
//        make.height.mas_equalTo(14);
//    }];
//
//    //优惠活动视图
//    UIView *activityView = [[UIView alloc]init];
//    activityView.backgroundColor = RGB(244, 90, 66);
//    [self.contentView addSubview:activityView];
//    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_productImgView);
//        make.width.mas_equalTo(_productImgView);
//        make.bottom.mas_equalTo(_productImgView);
//        make.height.mas_offset(24);
//    }];
//
//    _originalPriceLabel = [[UILabel alloc] init];
//    _originalPriceLabel.font = kFontNameSize(12);
//    _originalPriceLabel.textColor = [UIColor whiteColor];;
//    NSString *oldPrice = @"¥12";
//    NSMutableAttributedString *attri = [_originalPriceLabel addDeletingLineWithText:oldPrice deletingLinecolor:[UIColor whiteColor]];
//    [_originalPriceLabel setAttributedText:attri];
//    [activityView addSubview: _originalPriceLabel];
//    [ _originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(activityView);
//        make.height.mas_equalTo(14);
//        make.right.mas_offset(-10);
//    }];
//
//    UIImageView *discountImgView = [[UIImageView alloc] init];
//    discountImgView.image = [UIImage imageNamed:@"icon_dit_white"];
//    [activityView addSubview:discountImgView];
//    [discountImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.centerY.mas_equalTo(activityView);
//        make.width.height.mas_equalTo(8);
//    }];
//
//    _discountLabel = [[UILabel alloc] init];
//    _discountLabel.text = @"9折";
//    _discountLabel.font = kFontNameSize(11);
//    _discountLabel.textColor = [UIColor whiteColor];
//    [activityView addSubview: _discountLabel];
//    [ _discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(discountImgView.mas_right).offset(2);
//        make.centerY.mas_equalTo(discountImgView);
//    }];
//
//    //添加按钮
//    _addBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_addBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_addBT setImage:kImage_Name(@"but_add_yellow") forState:UIControlStateNormal];
//    [_addBT setImage:kImage_Name(@"but_add_yellow") forState:UIControlStateHighlighted];
//    _addBT.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:_addBT];
//    _addBT.tag = 1;
//    [_addBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.width.height.mas_offset(22);
//        make.top.mas_equalTo(_productImgView.mas_bottom).offset(68);
//    }];
//    //数量
//    _countLab = [[UILabel alloc] init];
//    _countLab.font = kFontNameSize(14);
//    _countLab.textColor = RGBA(51, 51, 51, 1);
//    _countLab.text = @"11";
//    _countLab.textAlignment = NSTextAlignmentCenter;
//    _countLab.adjustsFontSizeToFitWidth = YES;
//    [self.contentView addSubview: _countLab];
//    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_addBT);
//        make.right.mas_equalTo(_addBT.mas_left).offset(0);
//        make.width.mas_offset(26);
//    }];
//
//    //    //减少按钮
//    _reduceBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_reduceBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_reduceBT setImage:kImage_Name(@"but_reduce") forState:UIControlStateNormal];
//    [_reduceBT setImage:kImage_Name(@"but_reduce") forState:UIControlStateHighlighted];
//    _reduceBT.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:_reduceBT];
//    _reduceBT.tag = 2;
//    [_reduceBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_addBT);
//        make.right.mas_equalTo(_countLab.mas_left).offset(0);
//        make.width.height.mas_offset(22);
//    }];
//
    //选规格
//    _specificationBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_specificationBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_specificationBT setBackgroundImage:kImage_Name(@"but_spn_yellow") forState:UIControlStateNormal];
//    [_specificationBT setBackgroundImage:kImage_Name(@"but_spn_yellow") forState:UIControlStateHighlighted];
//    _specificationBT.backgroundColor = [UIColor redColor];
//    [_specificationBT setTitle:@"选规格" forState:UIControlStateNormal];
//    [_specificationBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _specificationBT.titleLabel.font = kFontNameSize(12);
//    [self.contentView addSubview:_specificationBT];
//    _specificationBT.tag = 3;
//    [_specificationBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_productImgView.mas_bottom).offset(68);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(22);
//        make.width.mas_offset(48);
//    }];
//
//    //售罄
//    _sellOutLab = [[UILabel alloc] init];
//    _sellOutLab.font = kFontNameSize(12);
//    _sellOutLab.textColor = kColor_GrayColor;
//    _sellOutLab.text = @"非可售时间";//非可售时间,售罄
//    _sellOutLab.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview: _sellOutLab];
//    [_sellOutLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_priceLabel);
//        make.right.mas_offset(-10);
//    }];
//
//    //非可售时间
//    _warningIcon = [[UIImageView alloc]init];
//    _warningIcon.image = kImage_Name(@"icon_info_gray");
//    [self.contentView addSubview:_warningIcon];
//    [_warningIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_priceLabel);
//        make.width.height.mas_offset(16);
//        make.right.mas_equalTo(_sellOutLab.mas_left).offset(-2);
//    }];
//
//    //    _addBT.hidden           = YES;
//    _countLab.hidden        = YES;
//    _reduceBT.hidden        = YES;
//    _specificationBT.hidden = YES;
//    _sellOutLab.hidden      = YES;
//    _warningIcon.hidden     = YES;
}

- (void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case 1:
        {//增加
            NSLog(@"增加---------");
            _count++;
            if (_count >= 1) {
                _countLab.hidden        = NO;
                _reduceBT.hidden        = NO;
            }
            _countLab.text = [NSString stringWithFormat:@"%ld",_count];
            
            if (self.plusBlock) {
                 self.plusBlock(_count,YES);
            }
        }
            break;
        case 2:
        {//减少
            NSLog(@"减少---------");
            _count--;
            if (_count <= 0) {
                _countLab.hidden        = YES;
                _reduceBT.hidden        = YES;
            }
            _countLab.text = [NSString stringWithFormat:@"%ld",_count];
            
            if (self.plusBlock) {
                self.plusBlock(_count,NO);
            }
        }
            break;
        case 3:
        {//选规格
            NSLog(@"选规格---------");
        }
            break;
            
        default:
            break;
    }
}


- (void)setmaintablecell:(ShoppingCartOrderListInfo *)model
{
    _priceLabel.text   = [NSString stringWithFormat:@"%@",model.name];
    _priceLabel.text  = [NSString stringWithFormat:@"¥ %.2f",[model.min_price floatValue]];
    _countLab.text = [NSString stringWithFormat:@"%@",model.orderCount];

}


@end
