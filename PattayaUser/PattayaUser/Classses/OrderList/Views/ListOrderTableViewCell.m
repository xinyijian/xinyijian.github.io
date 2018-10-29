//
//  ListOrderTableViewCell.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/3.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ListOrderTableViewCell.h"
@interface ListOrderTableViewCell ()

@property (nonatomic, strong) NSMutableArray * arrayLaber;
@property (nonatomic, strong) UIImageView * addruds;
@property (nonatomic, assign) BOOL isImage;
@property (nonatomic, strong) NSMutableArray * storeImageArray;

@end
@implementation ListOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.backgroundColor = App_TotalGrayWhite;
    }
    
    return self;
}
- (void)initUI{
    _storeImageArray = [NSMutableArray array];
    _isImage = YES;
    _arrayLaber = [NSMutableArray array];
    
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = UIColorWhite;
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    [bgView activateConstraints:^{
        [bgView.top_attr equalTo:self.contentView.top_attr constant:10];
        [bgView.left_attr equalTo:self.contentView.left_attr constant:8];
        [bgView.right_attr equalTo:self.contentView.right_attr constant:-8];
        bgView.height_attr.constant = 140;
    }];
    
    _storeName = [[UILabel alloc] init];
    _storeName.text = @"九华时蔬";
    _storeName.font = fontStely(@"PingFangSC-Medium", 16);
    _storeName.textColor = TextColor;
    [_storeName sizeToFit];
    [bgView addSubview:_storeName];
    [_storeName activateConstraints:^{
        [_storeName.top_attr equalTo:bgView.top_attr constant:16];
        [_storeName.left_attr equalTo:bgView.left_attr constant:12];
        _storeName.height_attr.constant = 22;
    }];

    //时间
    _timeText = [[UILabel alloc] init];
    _timeText.text = @"2018.08.31 14：30";
    _timeText.font = fontStely(@"PingFangSC-Regular", 14);
    _timeText.textColor = UIColorFromRGB(0x4A4A4A);
    [bgView addSubview:_timeText];
    [_timeText activateConstraints:^{
        _timeText.centerY_attr = _storeName.centerY_attr;
        [_timeText.left_attr equalTo:self.storeName.right_attr constant:13];
        _timeText.height_attr.constant = 20;
    }];
    
    //订单状态
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.text = @"等待接单";
    _statusLabel.font = UIBoldFont(14);
    _statusLabel.textColor = App_Nav_BarDefalutColor;
    [bgView addSubview:_statusLabel];
    [_statusLabel activateConstraints:^{
        _statusLabel.centerY_attr = _storeName.centerY_attr;
        [_statusLabel.right_attr equalTo:bgView.right_attr constant:-14];
        _statusLabel.height_attr.constant = 14;
    }];
   
    //分割线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = UIColorFromRGB(0xF3F3F3);
    [bgView addSubview:_lineView];
    [_lineView activateConstraints:^{
        [_lineView.right_attr equalTo:bgView.right_attr];
        [_lineView.left_attr equalTo:bgView.left_attr];
        [_lineView.top_attr equalTo:_storeName.bottom_attr constant:14];
        _lineView.height_attr.constant = 1;
    }];
    
    //商品图片。最多五个
    for (int i = 0; i < 5; i++) {
        UIImageView * image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"orderlist_cell_bg"];
       // image.frame = CGRectMake(13 + (15+34)*i , _lineView.YD_bottom + 10, 34, 34);
        [bgView addSubview:image];
        [image activateConstraints:^{
            [image.left_attr equalTo:bgView.left_attr constant:13 + (15+34)*i];
            [image.top_attr equalTo:_lineView.bottom_attr constant:10];
            image.height_attr.constant = 34;
            image.width_attr.constant = 34;
        }];
       // [_arrayLaber addObject:image];
    }
    
    //arrow
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [bgView addSubview:arrow];
    [arrow activateConstraints:^{
        [arrow.right_attr equalTo:bgView.right_attr constant:-13];
        [arrow.top_attr equalTo:_lineView.bottom_attr constant:22];
        arrow.height_attr.constant = IPhone_7_Scale_Width(11);
        arrow.width_attr.constant = IPhone_7_Scale_Width(11);
    }];
    
    //商品数量
    _countLabel = [[UILabel alloc] init];
    _countLabel.text = @"共4件商品";
    _countLabel.font = K_LABEL_SMALL_FONT_12;
    _countLabel.textColor = UIColorFromRGB(0x4A4A4A);
    [_countLabel sizeToFit];
    [bgView addSubview:_countLabel];
    [_countLabel activateConstraints:^{
        _countLabel.centerY_attr = arrow.centerY_attr;
        [_countLabel.right_attr equalTo:arrow.left_attr constant:-12];
        _countLabel.height_attr.constant = 17;
    }];

    //价格
    _picesLabel= [[UILabel alloc] init];
    _picesLabel.text = @"￥14.00";
    _picesLabel.font = fontStely(@"PingFangSC-Regular", 19);
    [_picesLabel sizeToFit];
    _picesLabel.textColor = UIColorBlack;
    [bgView addSubview:_picesLabel];
    [_picesLabel activateConstraints:^{
        [_picesLabel.bottom_attr equalTo:bgView.bottom_attr constant:-12];
        [_picesLabel.right_attr equalTo:bgView.right_attr constant:-13];
        _picesLabel.height_attr.constant = 27;
    }];
    
    //实付
    UILabel * shifu= [[UILabel alloc] init];
    shifu.text = @"实付";
    shifu.font = fontStely(@"PingFangSC-Regular", 12);
    [shifu sizeToFit];
    shifu.textColor = UIColorFromRGB(0x4a4a4a);
    [bgView addSubview:shifu];
    [shifu activateConstraints:^{
        [shifu.right_attr equalTo:_picesLabel.left_attr constant:-3];
        shifu.height_attr.constant = 17;
        shifu.centerY_attr = _picesLabel.centerY_attr;
    }];
    
    //评价订单
    _evaluateOrderBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_evaluateOrderBT setTitle:@"评价订单" forState:UIControlStateNormal];
    [_evaluateOrderBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _evaluateOrderBT.titleLabel.font = K_LABEL_SMALL_FONT_10;
    _evaluateOrderBT.backgroundColor = App_Nav_BarDefalutColor;
    _evaluateOrderBT.layer.cornerRadius = 3;
    _evaluateOrderBT.layer.masksToBounds = YES;
    [_evaluateOrderBT addTarget:self action:@selector(evaluateOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_evaluateOrderBT];
    [_evaluateOrderBT activateConstraints:^{
        [_evaluateOrderBT.right_attr equalTo:self.contentView.right_attr constant:-20];
        _evaluateOrderBT.height_attr.constant = 24;
        _evaluateOrderBT.width_attr.constant = 46;
        [_evaluateOrderBT.top_attr equalTo:bgView.bottom_attr constant:10];

    }];
   

}

//评价订单
-(void)evaluateOrder{
    
}

- (void)setArrayImage:(NSMutableArray *)arrayImage
{

}

- (void)setModel:(ListOrderModel *)model
{
    _model = model;
    if (model) {
        _storeName.text = model.storeName;
        long long time = [model.createTime longLongValue];
        
        NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSString*timeString=[formatter stringFromDate:d];
        _timeText.text =timeString;
        NSString * st1 = NSLocalizedString(@"共",nil);
        NSString * st2 = NSLocalizedString(@"件商品",nil);
        NSString * st3 = NSLocalizedString(@"实付",nil);
        NSString * st4 = NSLocalizedString(@"元",nil);
        _picesLabel.text = [NSString stringWithFormat:@"%@%ld%@，%@%.2f%@",st1,
                            _model.detailList.count,st2,st3,
                            _model.orderTotal.doubleValue,st4];
        for (UIImageView * imageTyp in _arrayLaber) {
            [imageTyp removeFromSuperview];
        }
        _arrayLaber = [NSMutableArray array];
        
        self.arrayImage = model.gseImgUrl;
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
