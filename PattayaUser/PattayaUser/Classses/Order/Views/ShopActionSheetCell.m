//
//  ShopActionSheetCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ShopActionSheetCell.h"
@interface ShopActionSheetCell()
{
    NSInteger  _count;//数据
}
@end

@implementation ShopActionSheetCell

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

-(void)setupViews{
    
    _productNameLabel = [[UILabel alloc] init];
    _productNameLabel.text = @"日日鲜·小白菜150g";
    _productNameLabel.textColor = TextColor;
    _productNameLabel.font =  K_LABEL_SMALL_FONT_14;
    [_productNameLabel sizeToFit];
    [self.contentView addSubview:_productNameLabel];
    [_productNameLabel activateConstraints:^{
        [_productNameLabel.left_attr equalTo:self.contentView.left_attr constant:13];
        _productNameLabel.height_attr.constant = 20;
        _productNameLabel.centerY_attr = self.contentView.centerY_attr;
    }];
    
    //添加按钮
    _addBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addBT setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBT setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_addBT];
    _addBT.tag = 1;
    [_addBT activateConstraints:^{
        [_addBT.right_attr equalTo:self.contentView.right_attr constant:-15];
        _addBT.height_attr.constant = 22;
        _addBT.width_attr.constant = 22;
        _addBT.centerY_attr = self.contentView.centerY_attr;
    }];
    
    //数量
    _countLab = [[UILabel alloc] init];
    _countLab.font = K_LABEL_SMALL_FONT_14;
    _countLab.textColor = TextColor;
    _countLab.text = @"1";
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview: _countLab];
    [_countLab activateConstraints:^{
        [_countLab.right_attr equalTo:_addBT.left_attr constant:0];
        //_countLab.height_attr.constant = 22;
        _countLab.width_attr.constant = 26;
        _countLab.centerY_attr = self.contentView.centerY_attr;
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
        _reduceBT.centerY_attr = self.contentView.centerY_attr;
    }];
    
    _originalPriceLabel = [[UILabel alloc] init];
    _originalPriceLabel.text =  @"￥16.08";
    _originalPriceLabel.font = K_LABEL_SMALL_FONT_10;
    _originalPriceLabel.textColor =UIColorFromRGB(0x4A4A4A);
    [_originalPriceLabel sizeToFit];
    // NSString *oldPrice = @"￥16.08";
    // NSMutableAttributedString *attri = [_originalPriceLabel addDeletingLineWithText:oldPrice deletingLinecolor:RGB(153, 153, 153)];
    //  [_originalPriceLabel setAttributedText:attri];
    [self.contentView addSubview: _originalPriceLabel];
    [_originalPriceLabel activateConstraints:^{
        [_originalPriceLabel.right_attr equalTo:self.reduceBT.left_attr constant:-16];
        _originalPriceLabel.height_attr.constant = 14;
        _originalPriceLabel.centerY_attr = self.contentView.centerY_attr;
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0x979797);
    [self.contentView addSubview:lineView];
    [lineView activateConstraints:^{
        lineView.centerX_attr = _originalPriceLabel.centerX_attr;
        lineView.height_attr.constant = 1;
        lineView.width_attr = _originalPriceLabel.width_attr;
        lineView.centerY_attr = _originalPriceLabel.centerY_attr;
    }];
    
    
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"¥14.8";
        _priceLabel.font = K_LABEL_SMALL_FONT_16;
        _priceLabel.textColor = TextColor;
        [_priceLabel sizeToFit];
        [self.contentView addSubview: _priceLabel];
        [_priceLabel activateConstraints:^{
            [_priceLabel.right_attr equalTo:_originalPriceLabel.left_attr constant:-5];
            _priceLabel.height_attr.constant = 22;
            _priceLabel.centerY_attr = self.contentView.centerY_attr;
        }];

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
            if ([self.delegate respondsToSelector:@selector(ShopActionSheet:showShopCount:)]) {
                [self.delegate ShopActionSheet:self showShopCount:_count];
            }
            
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
            if ([self.delegate respondsToSelector:@selector(ShopActionSheet:showShopCount:)]) {
                [self.delegate ShopActionSheet:self showShopCount:_count];
            }
        }
            break;
        case 3:
        {//选规格
            //DMLog(@"选规格---------");
        }
            break;
            
        default:
            break;
    }
}
@end
