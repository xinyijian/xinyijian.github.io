//
//  OrderTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "OrderTableViewCell.h"
@interface OrderTableViewCell ()
@property (nonatomic, strong) UIImageView * urlImage;
@property (nonatomic, strong) UILabel * titleText;
@property (nonatomic, strong) UILabel * categoryTexy;
@property (nonatomic, strong) UILabel * foodName;
@property (nonatomic, strong) UILabel * serverNumber;
@end
@implementation OrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    self.urlImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_urlImage];
//    self.urlImage.backgroundColor = [UIColor grayColor];
    [self.urlImage activateConstraints:^{
        [self.urlImage.left_attr equalTo:self.contentView.left_attr constant:14.5];
        [self.urlImage.top_attr equalTo:self.contentView.top_attr constant:12];
        self.urlImage.height_attr.constant = 76;
        self.urlImage.width_attr.constant = 94;
    }];
    
    
    _foodName = [[UILabel alloc]init];
    _foodName.textAlignment = NSTextAlignmentLeft;
    _foodName.textColor = TextColor;
    _foodName.font = fontStely(@"PingFangSC-Medium", 15);
//    _foodName.text = @"乐事薯片";
    //    _carName.backgroundColor = [UIColor w];
    [self.contentView addSubview:_foodName];
    
    [_foodName activateConstraints:^{
        [self.foodName.left_attr equalTo:self.urlImage.right_attr constant:15];
        _foodName.top_attr = _urlImage.top_attr;
        _foodName.height_attr.constant = 21;
        
    }];
 
    _categoryTexy = [[UILabel alloc]init];
    _categoryTexy.textAlignment = NSTextAlignmentLeft;
    _categoryTexy.textColor = TextGrayColor;
    _categoryTexy.font = fontStely(@"PingFangSC-Regular", 11);
//    _categoryTexy.text = @"数量：2瓶";
    [self.contentView addSubview:_categoryTexy];
    [_categoryTexy activateConstraints:^{
        [self.categoryTexy.left_attr equalTo:self.urlImage.right_attr constant:15];
        [_categoryTexy.top_attr equalTo:self.foodName.bottom_attr constant:15];
        _categoryTexy.height_attr.constant = 15;
        [_categoryTexy.width_attr equalTo:self.contentView.width_attr constant:-(55+136)];
    }];
    
    
    _serverNumber = [[UILabel alloc]init];
    _serverNumber.textAlignment = NSTextAlignmentLeft;
    _serverNumber.textColor = TextGrayColor;
    _serverNumber.font = fontStely(@"PingFangSC-Regular", 11);
//    _serverNumber.text = @"¥34.50";
    [self.contentView addSubview:_serverNumber];
    [_serverNumber activateConstraints:^{
        [self.serverNumber.left_attr equalTo:self.urlImage.right_attr constant:15];
        [_serverNumber.top_attr equalTo:self.categoryTexy.bottom_attr constant:13];
        _serverNumber.height_attr.constant = 15;
        [_serverNumber.width_attr equalTo:self.contentView.width_attr constant:-(55+136)];
    }];
    
    UIView * lineCell = [[UIView alloc] init];
    lineCell.backgroundColor = UIColorFromRGB(0xF4F4F6);
    [self.contentView addSubview:lineCell];
    
    [lineCell activateConstraints:^{
        [lineCell.top_attr equalTo:_urlImage.bottom_attr constant:13.5];
        lineCell.height_attr.constant = 1.5f;
        [lineCell.left_attr equalTo:self.contentView.left_attr constant:15];
        [lineCell.right_attr equalTo:self.contentView.right_attr constant:-15];
        
    }];
    
    
}

- (void)setModel:(detailListModel *)model
{
    _model = model;
    if (model) {
        _foodName.text = model.productName;
        NSString * stNum = NSLocalizedString(@"数量：",nil);
        _categoryTexy.text = [NSString stringWithFormat: @"%@%@%@",stNum,
                              model.number,model.productUnit];
        _serverNumber.text = [NSString stringWithFormat:@"¥%.2f",
                              _model.productPrice.floatValue];
        [self.urlImage sd_setImageWithURL:[NSURL URLWithString:_model.gdsImagePath] placeholderImage:[UIImage imageNamed:@"订单详情-占位图"]];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
