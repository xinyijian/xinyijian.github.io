//
//  DD_SpeechSynthesizer.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/14.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
@interface DD_SpeechSynthesizer : AVSpeechSynthesizer
- (void)speechUtteranceWithString:(NSString *)text;
@end
