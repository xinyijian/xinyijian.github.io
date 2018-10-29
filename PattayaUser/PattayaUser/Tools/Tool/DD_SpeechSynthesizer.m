//
//  DD_SpeechSynthesizer.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/14.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "DD_SpeechSynthesizer.h"
@interface DD_SpeechSynthesizer ()
{
    // 合成器 控制播放，暂停
    AVSpeechSynthesizer *_synthesizer;
    // 实例化说话的语言，说中文、英文
    AVSpeechSynthesisVoice *_voice;
}
@end
@implementation DD_SpeechSynthesizer
- (id)init{
    self = [super init];
    if (self) {
        
        //获取当前设备语言
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = [appLanguages objectAtIndex:0];
        NSLog(@"语言===%@",languageName);
        if ([languageName containsString:@"zh"]) {
            _voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];

        } else
        {
            _voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
            
        }
    }
    
    return self;
}

- (void)speechUtteranceWithString:(NSString *)text
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
   // 4.指定语音，和朗诵速度
    //中文朗诵速度：0.1还能够接受
   // 英文朗诵速度：0.3还可以
    utterance.voice = _voice;
    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    if ([languageName containsString:@"zh"]) {
        utterance.rate = 0.5;
    } else
    {
        utterance.rate = 0.3;
    }
    [self speakUtterance:utterance];

}

@end
