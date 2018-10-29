//
//  takeawayProductListCell.m
//  AppPark
//
//  Created by 池康 on 2018/7/16.
//

#import "TakeawayProductListCell.h"

@interface TakeawayProductListCell()
{
    NSInteger  _count;//数据
}
@end

@implementation TakeawayProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _count = 0;
    _productImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_productImgView];
    _productImgView.image = [UIImage imageNamed:@"shoplist_cell_bg"];
    [_productImgView activateConstraints:^{
        [_productImgView.left_attr equalTo:self.contentView.left_attr constant:12];
        _productImgView.height_attr.constant = 96;
        _productImgView.width_attr.constant = 96;
        [_productImgView.top_attr equalTo:self.contentView.top_attr constant:10];
    }];

    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.text = @"日日鲜·小白菜150g";
    _productNameLabel.textColor = TextColor;
    _productNameLabel.font =  K_LABEL_SMALL_FONT_14;
    [_productNameLabel sizeToFit];
    [self.contentView addSubview:_productNameLabel];
    [_productNameLabel activateConstraints:^{
        [_productNameLabel.left_attr equalTo:self.productImgView.right_attr constant:12];
        _productNameLabel.height_attr.constant = 20;
        [_productNameLabel.top_attr equalTo:self.contentView.top_attr constant:10];
    }];
    
    //标记
    //lab_np@3x:新品，lab_like@2x：网友最爱，lab_red@2x：老板推荐，lab_sie@2x：招牌，
    _classImgView = [[UIImageView alloc] init];
    _classImgView.image = [UIImage imageNamed:@"tag"];
    [self.contentView addSubview: _classImgView];
    [_classImgView activateConstraints:^{
        [_classImgView.left_attr equalTo:self.productImgView.right_attr constant:12];
        _classImgView.height_attr.constant = 24;
        _classImgView.width_attr.constant = 46;
        [_classImgView.top_attr equalTo:self.productNameLabel.bottom_attr constant:5];
    }];
    
    _haveSaleLabel = [[UILabel alloc] init];
    _haveSaleLabel.text = @"已售14";
    _haveSaleLabel.textColor = TextGrayColor;
    _haveSaleLabel.font =  K_LABEL_SMALL_FONT_12;
    [_haveSaleLabel sizeToFit];
    [self.contentView addSubview:_haveSaleLabel];
    [_haveSaleLabel activateConstraints:^{
        [_haveSaleLabel.left_attr equalTo:self.productImgView.right_attr constant:12];
        _haveSaleLabel.height_attr.constant = 17;
        [_haveSaleLabel.top_attr equalTo:self.classImgView.bottom_attr constant:5];
    }];


    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"¥14.8";
    _priceLabel.font = K_LABEL_SMALL_FONT_16;
    _priceLabel.textColor = TextColor;
    [_priceLabel sizeToFit];
    [self.contentView addSubview: _priceLabel];
    [_priceLabel activateConstraints:^{
        [_priceLabel.left_attr equalTo:self.productImgView.right_attr constant:12];
        _priceLabel.height_attr.constant = 22;
        [_priceLabel.top_attr equalTo:self.haveSaleLabel.bottom_attr constant:4];
    }];

    _originalPriceLabel = [[UILabel alloc] init];
    _originalPriceLabel.text =  @"￥16.08";
    _originalPriceLabel.font = K_LABEL_SMALL_FONT_10;
    _originalPriceLabel.textColor =TextGrayColor;
    [_originalPriceLabel sizeToFit];
   // NSString *oldPrice = @"￥16.08";
   // NSMutableAttributedString *attri = [_originalPriceLabel addDeletingLineWithText:oldPrice deletingLinecolor:RGB(153, 153, 153)];
  //  [_originalPriceLabel setAttributedText:attri];
    [self.contentView addSubview: _originalPriceLabel];
    [_originalPriceLabel activateConstraints:^{
        [_originalPriceLabel.left_attr equalTo:self.priceLabel.right_attr constant:1];
        _originalPriceLabel.height_attr.constant = 14;
        _originalPriceLabel.width_attr.constant = 40;
        _originalPriceLabel.centerY_attr = _priceLabel.centerY_attr;
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xC8C8C8);
    [self.contentView addSubview:lineView];
    [lineView activateConstraints:^{
        lineView.centerX_attr = _originalPriceLabel.centerX_attr;
        lineView.height_attr.constant = 1;
        lineView.width_attr.constant = 35;
        lineView.centerY_attr = _originalPriceLabel.centerY_attr;
    }];
    


//    //添加按钮
    _addBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addBT setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBT setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_addBT];
    _addBT.tag = 1;
    [_addBT activateConstraints:^{
        [_addBT.right_attr equalTo:self.contentView.right_attr constant:-12];
        _addBT.height_attr.constant = 22;
        _addBT.width_attr.constant = 22;
        _addBT.centerY_attr = _priceLabel.centerY_attr;
    }];

    //数量
    _countLab = [[UILabel alloc] init];
    _countLab.font = K_LABEL_SMALL_FONT_14;
    _countLab.textColor = TextColor;
    _countLab.text = @"11";
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview: _countLab];
    [_countLab activateConstraints:^{
        [_countLab.right_attr equalTo:_addBT.left_attr constant:0];
        //_countLab.height_attr.constant = 22;
        _countLab.width_attr.constant = 26;
        _countLab.centerY_attr = _priceLabel.centerY_attr;
    }];


    //减少按钮
    _reduceBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reduceBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_reduceBT setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    [_reduceBT setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_reduceBT];
    _reduceBT.tag = 2;
    [_reduceBT activateConstraints:^{
        [_reduceBT.right_attr equalTo:_countLab.left_attr constant:0];
        _reduceBT.height_attr.constant = 22;
        _reduceBT.width_attr.constant = 22;
        _reduceBT.centerY_attr = _priceLabel.centerY_attr;
    }];

//
//    //选规格
//    _specificationBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_specificationBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
////    [_specificationBT setBackgroundImage:kImage_Name(@"but_spn_yellow") forState:UIControlStateNormal];
////    [_specificationBT setBackgroundImage:kImage_Name(@"but_spn_yellow") forState:UIControlStateHighlighted];
//    _specificationBT.backgroundColor = [UIColor redColor];
//    [_specificationBT setTitle:@"选规格" forState:UIControlStateNormal];
//    [_specificationBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//   // _specificationBT.titleLabel.font = kFontNameSize(12);
//    [self.contentView addSubview:_specificationBT];
//    _specificationBT.tag = 3;
////    [_specificationBT mas_makeConstraints:^(MASConstraintMaker *make) {
////         make.top.mas_equalTo(_classImgView.mas_bottom).offset(10);
////        make.right.mas_offset(-10);
////        make.height.mas_offset(22);
////        make.width.mas_offset(48);
////    }];
//
//    //售罄
//    _sellOutLab = [[UILabel alloc] init];
////    _sellOutLab.font = kFontNameSize(12);
////    _sellOutLab.textColor = kColor_GrayColor;
//    _sellOutLab.text = @"非可售时间";//非可售时间,售罄
//    _sellOutLab.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview: _sellOutLab];
////    [_sellOutLab mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.mas_equalTo(_priceLabel);
////        make.right.mas_offset(-10);
////    }];
//
//    //非可售时间
//    _warningIcon = [[UIImageView alloc]init];
//   // _warningIcon.image = kImage_Name(@"icon_info_gray");
//    [self.contentView addSubview:_warningIcon];
////    [_warningIcon mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.mas_equalTo(_priceLabel);
////        make.width.height.mas_offset(16);
////        make.right.mas_equalTo(_sellOutLab.mas_left).offset(-2);
////    }];
//
//    _addBT.hidden           = YES;
    _countLab.hidden        = YES;
    _reduceBT.hidden        = YES;
    //_specificationBT.hidden = YES;
    //_sellOutLab.hidden      = YES;
    //_warningIcon.hidden     = YES;
}

- (void)btnClick:(UIButton *)button
{
   

    switch (button.tag) {
        case 1:
            {//增加
               // DMLog(@"增加---------");
                _count++;
                if (_count >= 1) {
                    _countLab.hidden        = NO;
                    _reduceBT.hidden        = NO;
                }
                _countLab.text = [NSString stringWithFormat:@"%ld",_count];
                _productModel.selectCount = [NSString stringWithFormat:@"%ld",_count];
            }
            break;
            case 2:
            {//减少
               // DMLog(@"减少---------");
                _count--;
                if (_count <= 0) {
                    _countLab.hidden        = YES;
                    _reduceBT.hidden        = YES;
                }
                _countLab.text = [NSString stringWithFormat:@"%ld",_count];
                _productModel.selectCount = [NSString stringWithFormat:@"%ld",_count];
                
            }
                break;
        
            
        default:
            break;
    }
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeselectcount" object:nil];
}


-(void)setProductModel:(ProductModel *)productModel{
    
    _productModel = productModel;
    _productNameLabel.text = productModel.name;
    _priceLabel.text = productModel.salePrice;
    _countLab.text = productModel.selectCount;
    _count = [productModel.selectCount intValue];
    _countLab.hidden = _count >0 ? NO : YES;
    _reduceBT.hidden = _count >0 ? NO : YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
