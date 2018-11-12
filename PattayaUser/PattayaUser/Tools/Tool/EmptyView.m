//
//  EmptyView.m
//  PattayaUser
//
//  Created by yanglei on 2018/11/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView()


@property (nonatomic, strong) UIImageView *emptyImage;//无数据图片

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) NSString *title;//

@property (nonatomic, strong) NSString *imageName;//


@end

@implementation EmptyView

- (id)initWithFrame:(CGRect)frame  withImage:(NSString *)imageName withTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _imageName = imageName;
        [self setUpUI];
        
    }
    return self;
}

-(void)setUpUI{
    
    self.backgroundColor = App_TotalGrayWhite;
    
    _emptyImage = [[UIImageView alloc]init];
    _emptyImage.image = [UIImage imageNamed:_imageName];
    [self addSubview:_emptyImage];
    [_emptyImage activateConstraints:^{
        
        [_emptyImage.top_attr equalTo:self.top_attr constant:IPhone_7_Scale_Height(50)];
        _emptyImage.centerX_attr = self.centerX_attr;
        _emptyImage.height_attr.constant = IPhone_7_Scale_Width(100);
        _emptyImage.width_attr.constant = IPhone_7_Scale_Width(100);
        
    }];
    
    _titleLabel =  [[UILabel alloc]init];
    _titleLabel.font = K_LABEL_SMALL_FONT_14;
    _titleLabel.textColor = TextGrayColor;
    _titleLabel.text = _title;
    [_titleLabel sizeToFit];
    [self addSubview:_titleLabel];
   
    [_titleLabel activateConstraints:^{
        _titleLabel.centerX_attr = self.centerX_attr;
        _titleLabel.height_attr.constant = 20;
        [_titleLabel.top_attr equalTo:_emptyImage.bottom_attr constant:10];
        
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    BLOCK_EXEC(_block);
}

@end
