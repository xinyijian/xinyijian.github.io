//
//  ReplicatorView.m
//  TransitionDemo
//
//  Created by Apple on 15/7/14.
//  Copyright (c) 2015年 Linitial. All rights reserved.
//

#import "ReplicatorView.h"

@interface ReplicatorView ()

@property (nonatomic, strong) CAReplicatorLayer *repLayer;
@property (nonatomic, strong) CAShapeLayer *insLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation ReplicatorView

- (void)dealloc {
    YDLog(@"%s",__func__);
}

- (void)setupLayers
{
    _repLayer = [CAReplicatorLayer layer];
    
    _repLayer.frame = CGRectMake(5, 5, self.YD_width - 10, self.YD_width - 10);
    _repLayer.instanceCount = 20;
    _repLayer.preservesDepth = NO;
    _repLayer.instanceDelay = 1 / 18.0;
    _repLayer.instanceColor = [UIColor whiteColor].CGColor;
    _repLayer.instanceTransform = CATransform3DMakeRotation((M_PI*2.0)/18, 0.0, 0.0, 1.0);
    
    _insLayer = [CAShapeLayer layer];
    _insLayer.frame = CGRectMake(self.YD_width / 2.0, 0.0, 4.6, 4.6);
    _insLayer.cornerRadius = 4.6 / 2.0;
    _insLayer.backgroundColor = App_ThemeColor.CGColor;
    
    [_repLayer addSublayer:_insLayer];
    
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _animation.fromValue = @0.3;
    _animation.toValue = @1.5;
    _animation.repeatCount = HUGE;
    _animation.duration = 1.;
    _animation.removedOnCompletion = NO;
    [_insLayer addAnimation:_animation forKey:nil];
    
    [self.layer addSublayer:_repLayer];
}

#pragma mark - 类方法 显示和移除view
+ (ReplicatorView *)showReplicatorLoading {
    
    UIImage *image = [UIImage imageNamed:@"loading"];
    image = [UIImage scaleImageWith:image targetWidth:IPhone_7_Scale_Width(70)];
    
    ReplicatorView *loadingView = [[ReplicatorView alloc] initWithImage:image];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [loadingView setupLayers];
    
    return loadingView;
}

- (void)disMissReplicatorLoading
{
    if (self != nil) {
        self.insLayer = nil;
        self.repLayer = nil;
        [self removeFromSuperview];
    }
}

@end












