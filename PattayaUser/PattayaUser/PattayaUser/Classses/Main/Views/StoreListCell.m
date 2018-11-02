//
//  StoreListCell.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/15.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "StoreListCell.h"

@implementation StoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.chainLabel];
        [self.contentView addSubview:self.hotLabel];
        [self.contentView addSubview:self.hotImg];
        [self.contentView addSubview:self.distance];
        [self.contentView addSubview:self.cutLine];

        [self.contentView addSubview:self.promotionImg1];
        [self.contentView addSubview: self.promotionImg2];
        [self.contentView addSubview:self.promotionLabel];
        [self.contentView addSubview:self.promotionLabel2];
     
        
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 14, 45, 45)];
        _headImage.image = [UIImage imageNamed:@"main_cell_headImg_bg"];
    }
    return _headImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+12, 13, 0, 22)];
        _nameLabel.textColor = TextColor;
        _nameLabel.font = K_LABEL_SMALL_FONT_16;
        _nameLabel.text = @"九华时蔬";
        [_nameLabel sizeToFit];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)chainLabel {
    if (!_chainLabel) {
        _chainLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.YD_right+16,16, 32, 18)];
        _chainLabel.font = K_LABEL_SMALL_FONT_10;
        _chainLabel.text = @"连锁";
        _chainLabel.textAlignment = NSTextAlignmentCenter;
        _chainLabel.textColor = UIColorWhite;
        _chainLabel.backgroundColor = UIColorFromRGB(0x328CE2);
        _chainLabel.layer.cornerRadius = 2;
        _chainLabel.layer.masksToBounds = true;
    }
    return _chainLabel;
}

- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.YD_right+13,self.nameLabel.YD_bottom + 8, 0, 17)];
        _hotLabel.textColor = TextGrayColor;
        _hotLabel.font = K_LABEL_SMALL_FONT_12;
        _hotLabel.text = @"热力值";
        [_hotLabel sizeToFit];
        _hotLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _hotLabel;
}

- (UIImageView *)hotImg {
    if (!_hotImg) {
        _hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.hotLabel.YD_right + 10, self.nameLabel.YD_bottom+ 11, 36, 11)];
        _hotImg.image = [UIImage imageNamed:@"main_cell_hotstar2"];
    }
    return _hotImg;
}

- (UILabel *)distance {
    if (!_distance) {
        _distance = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width - IPhone_7_Scale_Width(50 + 20) ,self.nameLabel.YD_bottom+ 8, 150, 17)];
        _distance.textColor = TextGrayColor;
        _distance.font = K_LABEL_SMALL_FONT_10;
        _distance.text = @"距离130m";
        _distance.textAlignment = NSTextAlignmentRight;
        
    }
    return _distance;
}

- (UILabel *)cutLine {
    if (!_cutLine) {
        _cutLine = [[UILabel alloc]initWithFrame:CGRectMake(0 ,self.hotLabel.YD_bottom+ 11, SCREEN_Width, 1)];
        _cutLine.backgroundColor = LineColor;
    }
    return _cutLine;
}

- (UIImageView *)promotionImg1 {
    if (!_promotionImg1) {
        _promotionImg1 = [[UIImageView alloc]initWithFrame:CGRectMake( 20, self.cutLine.YD_bottom+ 14, 10, 10)];
        _promotionImg1.image = [UIImage imageNamed:@"main_cell_icon1"];
    }
    return _promotionImg1;
}

- (UIImageView *)promotionImg2 {
    if (!_promotionImg2) {
        _promotionImg2 = [[UIImageView alloc]initWithFrame:CGRectMake( 20, self.promotionImg1.YD_bottom+ 15, 10, 10)];
        _promotionImg2.image = [UIImage imageNamed:@"main_cell_icon2"];
    }
    return _promotionImg2;
}

- (UILabel *)promotionLabel {
    if (!_promotionLabel) {
        _promotionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + 10 ,self.cutLine.YD_bottom+ 11, 200, 17)];
        _promotionLabel.textColor = TextColor;
        _promotionLabel.font = K_LABEL_SMALL_FONT_12;
        _promotionLabel.text = @"推广期间，在线购物免打店服务费";
        _promotionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel;
}

- (UILabel *)promotionLabel2 {
    if (!_promotionLabel2) {
        _promotionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.promotionImg1.YD_right + IPhone_7_Scale_Width(10) ,self.promotionLabel.YD_bottom+ 8, 200, 17)];
        _promotionLabel2.textColor = TextColor;
        _promotionLabel2.font = K_LABEL_SMALL_FONT_12;
        _promotionLabel2.text = @"每天19：00后，所有菜品5折优惠";
        _promotionLabel2.textAlignment = NSTextAlignmentLeft;
    }
    return _promotionLabel2;
}



- (void)setFrame:(CGRect)frame{

    frame.origin.y += 10;
    frame.size.height -= 10;

    [super setFrame:frame];
}

-(void)setShopModel:(ShopModel *)shopModel{
    [_headImage sd_setImageWithURL:[NSURL URLWithString:shopModel.avatarURL] placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
    _nameLabel.text = shopModel.name;
    _distance.text= [NSString stringWithFormat:@"距离%@米",shopModel.geoDistance];
}

-(void)setupViews{
    
}
@end
