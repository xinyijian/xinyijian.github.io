//
//  HomeTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "HomeTableViewCell.h"
@interface HomeTableViewCell ()
@property (nonatomic, strong) UIImageView * urlImage;
@property (nonatomic, strong) UILabel * titleText;
@property (nonatomic, strong) UILabel * categoryTexy;
@property (nonatomic, strong) UILabel * carName;
@property (nonatomic, strong) UILabel * serverNumber;
@property (nonatomic, strong) UILabel * timeLocation;

@end
@implementation HomeTableViewCell
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
        [self.urlImage.top_attr equalTo:self.contentView.top_attr constant:15];
        self.urlImage.height_attr.constant = 85;
        self.urlImage.width_attr.constant = 107;
    }];
    _urlImage.contentMode = UIViewContentModeScaleAspectFit;
//    self.urlImage.image = [UIImage imageNamed:@"占位图"];
    
    _carName = [[UILabel alloc]init];
    _carName.textAlignment = NSTextAlignmentLeft;
    _carName.textColor = TextColor;
    _carName.font = fontStely(@"PingFangSC-Medium", 15);
//    _carName.text = @"智慧购物车";
//    _carName.backgroundColor = [UIColor w];
    [self.contentView addSubview:_carName];
    
    [_carName activateConstraints:^{
        [self.carName.left_attr equalTo:self.urlImage.right_attr constant:15];
        _carName.top_attr = _urlImage.top_attr;
        _carName.height_attr.constant = 21;
        [_carName.right_attr equalTo:self.contentView.right_attr constant:-70];
    }];
    
    _timeLocation = [[UILabel alloc]init];
    _timeLocation.textAlignment = NSTextAlignmentRight;
    _timeLocation.textColor = TextGrayColor;
    _timeLocation.font = fontStely(@"PingFangSC-Regular", 11);
//    _timeLocation.text = @"800米 | 23分钟";
    [self.contentView addSubview:_timeLocation];
    
    [_timeLocation activateConstraints:^{
        [self.timeLocation.right_attr equalTo:self.contentView.right_attr constant:-15];
        [_timeLocation.top_attr equalTo:self.contentView.top_attr constant:24];
        _timeLocation.height_attr.constant = 15;
    }];
    
    
    _categoryTexy = [[UILabel alloc]init];
    _categoryTexy.textAlignment = NSTextAlignmentLeft;
    _categoryTexy.textColor = TextGrayColor;
    _categoryTexy.font = fontStely(@"PingFangSC-Regular", 11);
//    _categoryTexy.text = @"零食类：可乐，雪碧，特仑苏，薯片，雪碧，雪碧，雪碧，雪碧，";
    [self.contentView addSubview:_categoryTexy];
    [_categoryTexy activateConstraints:^{
        [self.categoryTexy.left_attr equalTo:self.urlImage.right_attr constant:15];
        [_categoryTexy.top_attr equalTo:self.carName.bottom_attr constant:15];
        _categoryTexy.height_attr.constant = 15;
        [_categoryTexy.width_attr equalTo:self.contentView.width_attr constant:-(55+136)];
    }];
    
    
    _serverNumber = [[UILabel alloc]init];
    _serverNumber.textAlignment = NSTextAlignmentLeft;
    _serverNumber.textColor = TextGrayColor;
    _serverNumber.font = fontStely(@"PingFangSC-Regular", 11);
//    _serverNumber.text = @"月售 2681件／服务费0元";
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
- (void)setModel:(StoreDefileModel *)Model
{
    _Model = Model;
    if (Model) {
        _carName.text = Model.name;

        [_urlImage sd_setImageWithURL:[NSURL URLWithString:Model.avatarURL] placeholderImage:[UIImage imageNamed:@"占位图"]];
        _categoryTexy.text = Model.categoryDescription;
        NSString * st1 = NSLocalizedString(@"月服务 ",nil);
        NSString * st2 = NSLocalizedString(@"次",nil);
        NSString * st3 = NSLocalizedString(@"服务费",nil);
        NSString * st4 = NSLocalizedString(@"元",nil);
//        NSString * st5 = NSLocalizedString(@"米",nil);

        _serverNumber.text = [NSString stringWithFormat:@"%@%@%@／%@%@%@",st1,_Model.saleAmountMonth,st2,st3,_Model.serviceFee,st4];
        NSString * distance;
        if (Model.geoDistance.floatValue > 1000) {
            distance = [NSString stringWithFormat:@"%.2fkm",
                        Model.geoDistance.floatValue / 1000];
        } else
        {
            distance = [NSString stringWithFormat:@"%@m",Model.geoDistance];
        }
        _timeLocation.text = distance;

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
