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

@property (nonatomic, strong) UIView *bgView;

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
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = UIColorWhite;
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    [_bgView activateConstraints:^{
        [_bgView.top_attr equalTo:self.contentView.top_attr constant:10];
        [_bgView.left_attr equalTo:self.contentView.left_attr constant:8];
        [_bgView.right_attr equalTo:self.contentView.right_attr constant:-8];
        _bgView.height_attr.constant = 140;
    }];
    
    _storeName = [[UILabel alloc] init];
    _storeName.text = @"九华时蔬";
    _storeName.font = fontStely(@"PingFangSC-Medium", 16);
    _storeName.textColor = TextColor;
    [_storeName sizeToFit];
    [_bgView addSubview:_storeName];
    [_storeName activateConstraints:^{
        [_storeName.top_attr equalTo:_bgView.top_attr constant:16];
        [_storeName.left_attr equalTo:_bgView.left_attr constant:12];
        _storeName.height_attr.constant = 22;
    }];

    //时间
    _timeText = [[UILabel alloc] init];
    _timeText.text = @"2018.08.31 14：30";
    _timeText.font = fontStely(@"PingFangSC-Regular", 14);
    _timeText.textColor = UIColorFromRGB(0x4A4A4A);
    [_bgView addSubview:_timeText];
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
    [_bgView addSubview:_statusLabel];
    [_statusLabel activateConstraints:^{
        _statusLabel.centerY_attr = _storeName.centerY_attr;
        [_statusLabel.right_attr equalTo:_bgView.right_attr constant:-14];
        _statusLabel.height_attr.constant = 14;
    }];
   
    //分割线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = UIColorFromRGB(0xF3F3F3);
    [_bgView addSubview:_lineView];
    [_lineView activateConstraints:^{
        [_lineView.right_attr equalTo:_bgView.right_attr];
        [_lineView.left_attr equalTo:_bgView.left_attr];
        [_lineView.top_attr equalTo:_storeName.bottom_attr constant:14];
        _lineView.height_attr.constant = 1;
    }];
    
    //商品图片。最多五个
    for (int i = 0; i < 5; i++) {
        UIImageView * image = [[UIImageView alloc]init];
        [_bgView addSubview:image];
        [image activateConstraints:^{
            [image.left_attr equalTo:_bgView.left_attr constant:13 + (15+34)*i];
            [image.top_attr equalTo:_lineView.bottom_attr constant:10];
            image.height_attr.constant = 34;
            image.width_attr.constant = 34;
        }];
        [_arrayLaber addObject:image];
    }
    
    //arrow
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [_bgView addSubview:arrow];
    [arrow activateConstraints:^{
        [arrow.right_attr equalTo:_bgView.right_attr constant:-13];
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
    [_bgView addSubview:_countLabel];
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
    [_bgView addSubview:_picesLabel];
    [_picesLabel activateConstraints:^{
        [_picesLabel.bottom_attr equalTo:_bgView.bottom_attr constant:-12];
        [_picesLabel.right_attr equalTo:_bgView.right_attr constant:-13];
        _picesLabel.height_attr.constant = 27;
    }];
    
    //实付
    UILabel * shifu= [[UILabel alloc] init];
    shifu.text = @"实付";
    shifu.font = fontStely(@"PingFangSC-Regular", 12);
    [shifu sizeToFit];
    shifu.textColor = UIColorFromRGB(0x4a4a4a);
    [_bgView addSubview:shifu];
    [shifu activateConstraints:^{
        [shifu.right_attr equalTo:_picesLabel.left_attr constant:-3];
        shifu.height_attr.constant = 17;
        shifu.centerY_attr = _picesLabel.centerY_attr;
    }];
    
//    //评价订单
//    _evaluateOrderBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_evaluateOrderBT setTitle:@"评价订单" forState:UIControlStateNormal];
//    [_evaluateOrderBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
//    _evaluateOrderBT.titleLabel.font = K_LABEL_SMALL_FONT_10;
//    _evaluateOrderBT.backgroundColor = App_Nav_BarDefalutColor;
//    _evaluateOrderBT.layer.cornerRadius = 3;
//    _evaluateOrderBT.layer.masksToBounds = YES;
//    [_evaluateOrderBT addTarget:self action:@selector(evaluateOrder) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_evaluateOrderBT];
//    [_evaluateOrderBT activateConstraints:^{
//        [_evaluateOrderBT.right_attr equalTo:self.contentView.right_attr constant:-20];
//        _evaluateOrderBT.height_attr.constant = 24;
//        _evaluateOrderBT.width_attr.constant = 46;
//        [_evaluateOrderBT.top_attr equalTo:bgView.bottom_attr constant:10];
//
//    }];
   

}

//评价订单
-(void)evaluateOrder{
    
}

- (void)setArrayImage:(NSMutableArray *)arrayImage
{
    _arrayImage = arrayImage;
    if (arrayImage.count > 0) {
        for (int i = 0; i < arrayImage.count; i ++) {
            if (i == _arrayLaber.count) {
                break;
            }
            UIImageView * image = _arrayLaber[i];
            detailListModel *model = arrayImage[i];
            [image sd_setImageWithURL:[NSURL URLWithString:model.gdsImagePath] placeholderImage:[UIImage imageNamed:@"orderlist_cell_bg"]];
            image.hidden = NO;
        }

    } else
    {
        for (UIImageView * image in _arrayLaber) {
            image.hidden = YES;
        }
    }
}

- (void)setModel:(ListOrderModel *)model
{
    _model = model;
    if (model) {
        _storeName.text = model.storeName;
        _statusLabel.text = @"已完成";
       
        _timeText.text = [PattayaTool ConvertStrToTime:model.createTime];
      
        _countLabel.text = [NSString stringWithFormat:@"共%ld件商品",_model.detailList.count];

        _picesLabel.text = [NSString stringWithFormat:@"￥%.2f",_model.orderPrice.doubleValue];
        
         self.arrayImage = model.detailList;
    }
}


-(void)setProccesingModel:(ProccesingModel *)proccesingModel{
    if (proccesingModel) {
        _storeName.text =  [proccesingModel.status isEqualToString:@"CALLING"] ? @"派单中" : @"已接单";
        _statusLabel.text =  [proccesingModel.status isEqualToString:@"CALLING"] ? @"等待接单" : @"配送中";

        _timeText.text = [PattayaTool ConvertStrToTime:proccesingModel.timeCreated];
        
        _countLabel.text = @"共1件商品";
        _picesLabel.text = @"￥0.00";
        
        for (int i = 0; i < self.arrayLaber.count; i++) {
            UIImageView *imageView = self.arrayLaber[i];
            if (i==0) {
                imageView.hidden = NO;
                imageView.image = [UIImage imageNamed:@"image_service_fee"];
            }
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
