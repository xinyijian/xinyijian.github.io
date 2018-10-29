//
//  RecommendationCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/9/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "RecommendationCell.h"

@interface RecommendationCell ()

@property (nonatomic, strong) UIImageView *headImage;//商品头像
@property (nonatomic, strong) UILabel *nameLabel;//商品名称
@property (nonatomic, strong) UILabel *priceLabel;//商品价格




@end

@implementation RecommendationCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    [self addSubview:self.headImage];
    [self addSubview: self.nameLabel];
    [self addSubview:self.priceLabel];
    
}

-(void)setItem:(ProductModel *)item {
    
    _nameLabel.text = item.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",item.salePrice];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:item.avatarURL] placeholderImage:[UIImage imageNamed:@"main_card_cell_bg"]];
}

#pragma mark - 懒加载

- (UIImageView *)headImage {
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  self.width, self.width)];
        _headImage.image = [UIImage imageNamed:@"main_card_cell_bg"];
    }
    return _headImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.headImage.YD_bottom, self.width, (self.height - self.width)/2)];
        _nameLabel.textColor = TextColor;
        _nameLabel.font = K_LABEL_SMALL_FONT_10;
        _nameLabel.text = @"日日鲜 大...";
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.nameLabel.YD_bottom, self.width, (self.height - self.width)/2)];
        _priceLabel.textColor = UIColorFromRGB(0xEF3E00);
        _priceLabel.font = K_LABEL_SMALL_FONT_10;
        _priceLabel.text = @"￥5.60";
        [_priceLabel sizeToFit];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

@end
