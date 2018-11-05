//
//  PaymentOrderCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PaymentOrderCell.h"

@implementation PaymentOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        self.backgroundColor = App_TotalGrayWhite;
        
    }
    return self;
}

-(void)setupViews{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = UIColorWhite;
    [self.contentView addSubview:bgView];
    [bgView activateConstraints:^{
        [bgView.left_attr equalTo:self.contentView.left_attr constant:IPhone_7_Scale_Width(8)];
        [bgView.right_attr equalTo:self.contentView.right_attr constant:IPhone_7_Scale_Width(-8)];
        [bgView.top_attr equalTo:self.contentView.top_attr];
        [bgView.bottom_attr equalTo:self.contentView.bottom_attr];
    }];
    
    _productImgView = [[UIImageView alloc] init];
    [bgView addSubview:_productImgView];
    _productImgView.image = [UIImage imageNamed:@"orderlist_cell_bg"];
    [_productImgView activateConstraints:^{
        [_productImgView.left_attr equalTo:bgView.left_attr constant:IPhone_7_Scale_Width(13)];
        _productImgView.height_attr.constant = IPhone_7_Scale_Height(40);
        _productImgView.width_attr.constant = IPhone_7_Scale_Height(40);
        _productImgView.centerY_attr = bgView.centerY_attr;
    }];
    
    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.text = @"日日鲜·小白菜150g";
    _productNameLabel.textColor = TextColor;
    _productNameLabel.font =  K_LABEL_SMALL_FONT_14;
    [_productNameLabel sizeToFit];
    [self.contentView addSubview:_productNameLabel];
    [_productNameLabel activateConstraints:^{
        [_productNameLabel.left_attr equalTo:_productImgView.right_attr constant:IPhone_7_Scale_Width(14)];
        _productNameLabel.height_attr.constant = IPhone_7_Scale_Height(20);
        _productNameLabel.top_attr = _productImgView.top_attr;
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"¥14.00";
    _priceLabel.font = K_LABEL_SMALL_FONT_14;
    _priceLabel.textColor = TextColor;
    [_priceLabel sizeToFit];
    [self.contentView addSubview: _priceLabel];
    [_priceLabel activateConstraints:^{
        [_priceLabel.right_attr equalTo:bgView.right_attr constant:IPhone_7_Scale_Width(-13)];
        _priceLabel.height_attr = _productNameLabel.height_attr;
        _priceLabel.centerY_attr = _productNameLabel.centerY_attr;

    }];
    
    //数量
    _countLab = [[UILabel alloc] init];
    _countLab.font = K_LABEL_SMALL_FONT_12;
    _countLab.textColor = TextGrayColor;
    _countLab.text = @"x2";
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview: _countLab];
    [_countLab activateConstraints:^{
        [_countLab.left_attr equalTo:_productImgView.right_attr constant:IPhone_7_Scale_Width(14)];
        _countLab.height_attr.constant = IPhone_7_Scale_Height(20);
        [_countLab.top_attr equalTo:_productNameLabel.bottom_attr constant:0];

    }];
    
    _originalPriceLabel = [[UILabel alloc] init];
    _originalPriceLabel.text =  @"￥16.00";
    _originalPriceLabel.font = K_LABEL_SMALL_FONT_12;
    _originalPriceLabel.textColor =UIColorFromRGB(0x4A4A4A);
    [_originalPriceLabel sizeToFit];
    // NSString *oldPrice = @"￥16.08";
    // NSMutableAttributedString *attri = [_originalPriceLabel addDeletingLineWithText:oldPrice deletingLinecolor:RGB(153, 153, 153)];
    //  [_originalPriceLabel setAttributedText:attri];
    [self.contentView addSubview: _originalPriceLabel];
    [_originalPriceLabel activateConstraints:^{
        [_originalPriceLabel.right_attr equalTo:bgView.right_attr constant:IPhone_7_Scale_Width(-13)];
        _originalPriceLabel.height_attr = _countLab.height_attr;
        _originalPriceLabel.centerY_attr = _countLab.centerY_attr;
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0x979797);
    [_originalPriceLabel addSubview:lineView];
    [lineView activateConstraints:^{
        lineView.centerX_attr = _originalPriceLabel.centerX_attr;
        lineView.height_attr.constant = 1;
        lineView.width_attr = _originalPriceLabel.width_attr;
        lineView.centerY_attr = _originalPriceLabel.centerY_attr;
    }];
    
    
}

- (void)setItem:(detailListModel *)item{
    _item = item;
    _productNameLabel.text =  item.productName;
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:item.productPrice];
//    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:[item.productPrice rangeOfString:@"things"]];
//    [attrString addAttribute:NSStrikethroughColorAttributeName value:UIColorFromRGB(0x979797) range:[item.productPrice rangeOfString:@"things"]];
//
//    _originalPriceLabel.attributedText = attrString;
//    [_originalPriceLabel sizeToFit];
    [_productImgView sd_setImageWithURL:[NSURL URLWithString:item.gdsImagePath] placeholderImage:[UIImage imageNamed:@"orderlist_cell_bg"]];
    _priceLabel.text = item.retailPriceShow;
    _countLab.text =[NSString stringWithFormat:@"x%@ %@",item.number,item.productUnit];

    NSLog(@"item = %@",item);
}

-(void)hiddenSomeViews{
    self.countLab.hidden = YES;
    self.originalPriceLabel.hidden = YES;
}


-(void)setProductModel:(NewShopListModel *)productModel{
    _productNameLabel.text = productModel.gdsName;
    _priceLabel.text = [NSString stringWithFormat:@"%@.00", productModel.salePrice];
    _countLab.text = [NSString stringWithFormat:@"x%@",productModel.selectCount];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
