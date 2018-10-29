//
//  CarNameTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/6.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "CarNameTableViewCell.h"
#import "StoreListModel.h"
@interface CarNameTableViewCell ()
@property (nonatomic, strong) UILabel * storeName;
@property (nonatomic, strong) UILabel * tpye;
@property (nonatomic, strong) UILabel * number;

@end
@implementation CarNameTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    UIView * backView = [[UIView alloc]init];
    [self.contentView addSubview:backView];
    [backView activateConstraints:^{
        [backView.top_attr equalTo:self.contentView.top_attr constant:2.5];
        [backView.left_attr equalTo:self.contentView.left_attr constant:15];
        [backView.right_attr equalTo:self.contentView.right_attr constant:-15];
        [backView.bottom_attr equalTo:self.contentView.bottom_attr constant:-2.5];
    }];
    backView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    _storeName = [[UILabel alloc]init];
    [backView addSubview:_storeName];
    [_storeName activateConstraints:^{
        [_storeName.left_attr equalTo:backView.left_attr constant:17];
        [_storeName.bottom_attr equalTo:backView.bottom_attr constant:-6];
        [_storeName.top_attr equalTo:backView.top_attr constant:6];
    }];
    _storeName.textAlignment = NSTextAlignmentLeft;
    _storeName.font = fontStely(@"PingFangSC-Regular", 13);
//    _storeName.text = @"四季豆四季豆四季豆四季豆";

    _tpye = [[UILabel alloc]init];
    [backView addSubview:_tpye];
    [_tpye activateConstraints:^{
        [_tpye.left_attr equalTo:_storeName.right_attr constant:10.5];
        _tpye.height_attr.constant = 14;
        _tpye.width_attr.constant = 29;
        _tpye.centerY_attr = _storeName.centerY_attr;
    }];
    _tpye.font = fontStely(@"PingFangSC-Regular", 9);
    _tpye.text = NSLocalizedString(@"少量",nil);
    _tpye.layer.masksToBounds = YES;
    _tpye.layer.cornerRadius = 5;
    _tpye.backgroundColor = UIColorFromRGB(0xdb1917);
    _tpye.textAlignment = NSTextAlignmentCenter;
    _tpye.textColor = [UIColor whiteColor];
    
    _number = [[UILabel alloc] init];
    [backView addSubview:_number];
    [_number activateConstraints:^{
        [_number.right_attr equalTo:backView.right_attr constant:-18];
        _number.height_attr.constant = 18.5;
        _number.centerY_attr = _storeName.centerY_attr;
    }];
    _number.font = fontStely(@"PingFangSC-Regular", 13);
//    _number.text = @"¥12.00/340g";
    _number.textAlignment = NSTextAlignmentRight;
    _number.textColor = UIColorFromRGB(0xdb1917);
}

- (void)setModel:(StoreGoodsListModel *)model
{
    _model = model;
    if (model) {
        
//        CGSize aaas = [PattayaTool sizeWithString:model.name font:fontStely(@"PingFangSC-Regular", 13) sizemake:CGSizeMake(SCREEN_Width - 150, 20)];
//        if (aaas.width > SCREEN_Width - 100) {
        if (SCREEN_Width == 320) {
            if (model.name.length > 10) {
                _storeName.text = [NSString stringWithFormat:@"%@...",[model.name substringWithRange:NSMakeRange(0, 8)]];
            } else
            {
                _storeName.text = model.name;
            }
            } else
            {
                if (model.name.length > 15) {
                    _storeName.text = [NSString stringWithFormat:@"%@...",[model.name substringWithRange:NSMakeRange(0, 13)]];
                } else
                {
                    _storeName.text = model.name;
                }
            }
        if (model.priceType.integerValue == 0) {
            _number.text = [NSString stringWithFormat:@"¥%.2f/%@%@",
                            model.salePrice.doubleValue,model.weight,model.unit];
        } else
        {
            _number.text = [NSString stringWithFormat:@"¥%.2f/%@",
                            model.salePrice.doubleValue,model.unit];
        }
       
        if (_model.lowInventory.boolValue == true) {
            _tpye.hidden = NO;
        } else
        {
            _tpye.hidden = YES;
        }
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
