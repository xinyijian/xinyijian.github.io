//
//  RouterObject.h
//  PattayaUser
//
//  Created by 明克 on 2018/5/22.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlerViewProtocol.h"
@interface RouterObject : NSObject<AlerViewProtocol>
+ (void)initWithDelegateRouter:(id<AlerViewProtocol>)delegate EventType:(AlerEventType)type AlerCallBlack:(AlerViewCannlnBlock)callBlock;
@end
