//
//  StoreNameCarDetailsTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "StoreNameCarDetailsTableViewCell.h"
@interface StoreNameCarDetailsTableViewCell ()
@property (nonatomic, strong) UILabel * storeName;
@property (nonatomic, strong) UILabel * detilsText;
@property (nonatomic, strong) UILabel * categoryText;
@property (nonatomic, strong) UIButton * goMap;

@end
@implementation StoreNameCarDetailsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    _storeName = [[UILabel alloc]init];
    [self.contentView addSubview: _storeName];
    [_storeName activateConstraints:^{
        [_storeName.left_attr equalTo:self.contentView.left_attr constant:15];
        [_storeName.top_attr equalTo:self.contentView.top_attr constant:16];
        _storeName.height_attr.constant = 21;
        [_storeName.right_attr equalTo:self.right_attr constant:-180] ;
    }];
    _storeName.font = fontStely(@"PingFangSC-Medium", 15);
    _storeName.textAlignment = NSTextAlignmentLeft;
//    _storeName.text = @"超级无敌智慧购物车";
    
    _categoryText = [[UILabel alloc]init];
    [self.contentView addSubview:_categoryText];
    _categoryText.backgroundColor = BlueColor;
    _categoryText.textAlignment = NSTextAlignmentCenter;
    _categoryText.textColor = [UIColor whiteColor];
//    _categoryText.text = @"蔬菜";
    _categoryText.font = fontStely(@"PingFangSC-Medium", 10);
    [_categoryText activateConstraints:^{
        [_categoryText.left_attr equalTo:_storeName.right_attr constant:20];
        _categoryText.height_attr.constant = 15;
        _categoryText.centerY_attr = _storeName.centerY_attr;
        _categoryText.width_attr.constant = 34;
    }];
    _categoryText.layer.masksToBounds = YES;
    _categoryText.layer.cornerRadius = 5;
    
    _detilsText = [[UILabel alloc]init];
    [self.contentView addSubview:_detilsText];
    [_detilsText activateConstraints:^{
        [_detilsText.left_attr equalTo:self.contentView.left_attr constant:15];
        [_detilsText.top_attr equalTo:_storeName.bottom_attr constant:2.5];
        _detilsText.height_attr.constant = 18.5;
        
    }];
//    _detilsText.text = @"月售  5632件／服务费2元";
    _detilsText.textColor = TextGrayColor;
    _detilsText.textAlignment = NSTextAlignmentLeft;
    _detilsText.font = fontStely(@"PingFangSC-Regular", 13);
    
    _goMap = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_goMap];
    [_goMap activateConstraints:^{
        [_goMap.right_attr equalTo:self.contentView.right_attr constant:-19];
        [_goMap.top_attr equalTo:self.contentView.top_attr constant:24];
        _goMap.height_attr.constant = 32;
        _goMap.width_attr.constant = 89;
    }];
    _goMap.layer.borderColor = BlueColor.CGColor;
    _goMap.layer.borderWidth = 0.5f;
    _goMap.layer.cornerRadius = 16;
    [_goMap setTitleColor:BlueColor forState:UIControlStateNormal];
    [_goMap setTitle:NSLocalizedString(@"我去找他",nil) forState:UIControlStateNormal];
    _goMap.titleLabel.font = fontStely(@"PingFangSC-Regular", 13);
    [_goMap addTarget:self action:@selector(mapShare:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setModel:(StoreDefileModel *)model
{
    _model = model;
    if (model) {
        _storeName.text = model.name;
        _categoryText.text = model.categoryName;
    }
}

- (void)mapShare:(UIButton *)btn
{
    BLOCK_EXEC(_blockMap);
    /// showMapNavigationViewFormcurrentLatitude
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
