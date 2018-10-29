//
//  UpdateAlertView.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/23.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "UpdateAlertView.h"
#import <POP.h>
@interface UpdateAlertView()
{
    //    UIView *viewBg;
    UIView *blackView;
    UIView *alertView;
    UILabel *versionLb;
    UILabel *detailLb;
    UIView *line1;
    UIButton *leftBtn;
    UIView *line2;
    UIButton *rightBtn;
}

@end
@implementation UpdateAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height + 64);
        self.backgroundColor = [UIColor clearColor];
        [self layoutMyView];
    }
    return self;
}
- (void)layoutMyView
{
    //    viewBg = [self createViewWithFrame:LDJRect(0, 0, WIDTH_VC, HEIGHT_VC) andBackgroundColor:[UIColor clearColor]];
    [self createBlackView];
    [self createAlertView];
}
- (UIView*)createViewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)bgColor
{
    UIView*view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = bgColor;
    return view ;
}
- (UIButton*)createButtonWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTarget:(id)target andAction:(SEL)action andTitle:(NSString *)title
{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 0;
    return button;
}
- (UILabel *)creatLabelWithFrame:(CGRect)frame AndFont:(int)font AndBackgroundColor:(UIColor *)backgroundColor AndText:(NSString *)text AndTextAlignment:(NSTextAlignment)textAlignment AndTextColor:(UIColor *)textColor
{
    UILabel*label = [[UILabel alloc]initWithFrame:frame];
    label.numberOfLines = 0;
    label.textAlignment = textAlignment;
    label.backgroundColor = backgroundColor;
    label.font = [UIFont systemFontOfSize:font];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textColor = textColor;
    label.text = text;
    label.clipsToBounds = YES;
    return label;
}
#pragma mark------- Label的自适应 ----------
- (CGRect)contentAdaptionLabel:(NSString *)string withSize:(CGSize)frameSize withTextFont:(CGFloat)fontSize
{
    CGRect rect;
    //    if (IS_IOS6) {
    //        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:frameSize lineBreakMode:NSLineBreakByCharWrapping];
    //        rect.size = size;
    //    }
    //    else
    //    {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]};
    rect = [string boundingRectWithSize:frameSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    //    }
    return rect;
}
- (void)createBlackView {
    
    blackView                 = [self createViewWithFrame:self.frame andBackgroundColor:[UIColor blackColor]];
    blackView.alpha           = 0;
    [self addSubview:blackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        blackView.alpha = 0.25f;
    }];
}
- (void)createAlertView
{
    alertView = [self createViewWithFrame:CGRectMake(0, 0, 240, 120) andBackgroundColor:[UIColor whiteColor]];
    alertView.layer.cornerRadius = 10.0f;
    alertView.layer.masksToBounds = YES;
    alertView.alpha = 0;
    [self addSubview:alertView];
    
    UILabel *titleLb = [self creatLabelWithFrame:CGRectMake(10, 10, alertView.frame.size.width-20, 20) AndFont:16 AndBackgroundColor:[UIColor clearColor] AndText:@"您有新版本可以更新啦！" AndTextAlignment:NSTextAlignmentCenter AndTextColor:[UIColor blackColor]];
    titleLb.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [alertView addSubview:titleLb];
    
    versionLb = [self creatLabelWithFrame:CGRectMake(10, CGRectGetMaxY(titleLb.frame)+5, alertView.frame.size.width-20, 20) AndFont:13 AndBackgroundColor:[UIColor clearColor] AndText:@"版本号5.0.0.2" AndTextAlignment:NSTextAlignmentCenter AndTextColor:[UIColor blackColor]];
    [alertView addSubview:versionLb];
    
    detailLb = [self creatLabelWithFrame:CGRectMake(10, CGRectGetMaxY(versionLb.frame)+5, alertView.frame.size.width-20, 50) AndFont:15 AndBackgroundColor:[UIColor clearColor] AndText:nil AndTextAlignment:NSTextAlignmentCenter AndTextColor:[UIColor blackColor]];
    detailLb.numberOfLines = 0;
    [alertView addSubview:detailLb];
    
    line1 = [self createViewWithFrame:CGRectMake(0, CGRectGetMaxY(detailLb.frame)+5, alertView.frame.size.width, 1) andBackgroundColor:TextGrayColor];
    [alertView addSubview:line1];
    
    leftBtn = [self createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40) andImageName:nil andTarget:self andAction:@selector(updateLoad) andTitle:@"下载更新"];
    leftBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [leftBtn setTitleColor:UIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
    [alertView addSubview:leftBtn];
    
    line2 = [self createViewWithFrame:CGRectMake(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), 1, 40) andBackgroundColor:TextGrayColor];
    [alertView addSubview:line2];
    
    rightBtn = [self createButtonWithFrame:CGRectMake(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40) andImageName:nil andTarget:self andAction:@selector(nextUpdate) andTitle:@"下次再说"];
    [rightBtn setTitleColor:UIColorFromRGB(0x007AFF) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [alertView addSubview:rightBtn];
    
    // 执行动画
    POPBasicAnimation  *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue             = @(1.f);
    alpha.duration            = 0.3f;
    [alertView pop_addAnimation:alpha forKey:nil];
    
    POPSpringAnimation *scale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scale.fromValue           = [NSValue valueWithCGSize:CGSizeMake(1.75f, 1.75f)];
    scale.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.dynamicsTension     = 1000;
    scale.dynamicsMass        = 1.3;
    scale.dynamicsFriction    = 10.3;
    scale.springSpeed         = 20;
    scale.springBounciness    = 15.64;
    scale.delegate            = self;
    [alertView.layer pop_addAnimation:scale forKey:nil];
}

- (void)setVersionNum:(NSString *)versionNum
{
    versionLb.text = versionNum;
}
- (void)setDetailInfo:(NSString *)detailInfo
{
    CGRect rect = [self contentAdaptionLabel:detailInfo withSize:CGSizeMake(alertView.frame.size.width-20, 500) withTextFont:15];
    CGRect frame = detailLb.frame;
    frame.size.height = rect.size.height+5;
    detailLb.frame = frame;
    detailLb.text = detailInfo;
    
    
    [self updateUIFrame];
    
    //    leftBtn.frame = LDJRect(0, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40);
    //    line2.frame = LDJRect(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), 1, 40);
    //    rightBtn.frame = LDJRect(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40);
    
    //    NSLog(@"%@",NSStringFromCGPoint(self.center));
    CGRect bounds = alertView.frame;
    bounds.size.height = 105+rect.size.height+5;
    alertView.frame = bounds;
    alertView.center = self.center;
}

- (void)updateUIFrame
{
    line1.frame = CGRectMake(0, CGRectGetMaxY(detailLb.frame)+5, alertView.frame.size.width, 1);
    //需要强制更新
    if ([self.updateModel.forceUpdate intValue] == 1) {
        leftBtn.frame = CGRectMake(0, CGRectGetMaxY(line1.frame), alertView.frame.size.width, 40);
        line2.hidden = YES;
        rightBtn.hidden = YES;
    }else {
        leftBtn.frame = CGRectMake(0, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40);
        line2.hidden = NO;
        rightBtn.hidden = NO;
        line2.frame = CGRectMake(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), 1, 40);
        rightBtn.frame = CGRectMake(alertView.frame.size.width/2, CGRectGetMaxY(line1.frame), alertView.frame.size.width/2, 40);
    }
}

- (void)hideView
{
    [UIView animateWithDuration:0.2f animations:^{
        
        blackView.alpha       = 0.f;
        alertView.alpha     = 0.f;
        alertView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)nextUpdate
{
    [self hideView];
}

- (void)updateLoad
{
    if ([self.updateModel.forceUpdate intValue] == 0) {
        [self hideView];
    }
    //@"itms-apps://itunes.apple.com/cn/app/lan-dao-jia-xi-yi/id923806169?mt=8"
    NSURL *url = [NSURL URLWithString:self.updateModel.updateUrl];
    
    [[UIApplication sharedApplication]openURL:url];
}

@end
