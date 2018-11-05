//
//  AnimationViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/11/2.
//  Copyright © 2018 明克. All rights reserved.
//

#import "AnimationViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface AnimationViewController ()
@property(nonatomic, strong)AVPlayerViewController *AVPlayer;

@end

@implementation AnimationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication].keyWindow
     addSubview:self.view];
    [[UIApplication sharedApplication].keyWindow
     bringSubviewToFront:self.view];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化AVPlayer
    [self setMoviePlayer];
}

-(void)setMoviePlayer{
    
    NSString *launchImageName = [self getLaunchImage:@"Portrait"];
    UIImage * launchImage = [UIImage imageNamed:launchImageName];
    self.view.backgroundColor = [UIColor colorWithPatternImage:launchImage];

    //初始化AVPlayer
    self.AVPlayer = [[AVPlayerViewController alloc]init];
    //多分屏功能取消
    self.AVPlayer.allowsPictureInPicturePlayback = NO;
    //设置是否显示媒体播放组件
    self.AVPlayer.showsPlaybackControls = false;
    
    //初始化一个播放单位。给AVplayer 使用
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:_movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    //layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:[UIScreen mainScreen].bounds];
    //设置填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    self.AVPlayer.player = player;
    //添加到self.view上面去
    [self.view.layer addSublayer:layer];
    //开始播放
    [self.AVPlayer.player play];
    
    
    
    //这里设置的是重复播放。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
    
    
    //定时器。延迟3秒再出现进入应用按钮
//    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setupLoginView) userInfo:nil repeats:YES];
    
}


//播放完成的代理
- (void)playDidEnd:(NSNotification *)Notification{
////    //播放完成后。设置播放进度为0 。 重新播放
//    [self.AVPlayer.player seekToTime:CMTimeMake(0, 1)];
////    //开始播放
//    [self.AVPlayer.player play];
    [GetAppDelegate getTabbarVC];
}



- (void)setupLoginView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.alpha = 0;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    [self.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.5 animations:^{
        enterMainButton.alpha = 1;
    }];
}



- (void)enterMainAction:(UIButton *)btn {
    [GetAppDelegate getTabbarVC];
}

- (NSString *)getLaunchImage:(NSString *)viewOrientation{
    //获取启动图片
    CGSize viewSize = [UIApplication sharedApplication].delegate.window.bounds.size;
    //横屏请设置成 @"Landscape"|Portrait
    //    NSString *viewOrientation = @"Portrait";
    __block NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    [imagesDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(obj[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:obj[@"UILaunchImageOrientation"]])
        {
            launchImageName = obj[@"UILaunchImageName"];
        }
    }];
    return launchImageName;
}
@end
