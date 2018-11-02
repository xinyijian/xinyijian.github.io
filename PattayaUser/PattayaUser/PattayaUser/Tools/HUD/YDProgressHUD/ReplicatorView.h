//
//  ReplicatorView.h
//  TransitionDemo
//
//  Created by Apple on 15/7/14.
//  Copyright (c) 2015年 Linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplicatorView : UIImageView

+ (ReplicatorView *)showReplicatorLoading;

- (void)disMissReplicatorLoading;

@end
