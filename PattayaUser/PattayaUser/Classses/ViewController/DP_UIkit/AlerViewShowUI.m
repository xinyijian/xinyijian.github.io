//
//  AlerViewShowUI.m
//  PattayaUser
//
//  Created by 明克 on 2018/5/22.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AlerViewShowUI.h"

@implementation AlerViewShowUI
- (void)AlerNotificationCenterEventType:(AlerEventType)type AlerCallBlack:(AlerViewCannlnBlock)callBlock
{
    PTLAlertView * aler = [self AlerType:type];
    [aler show];
    aler.selctBtnBlock = ^(NSInteger index, NSString * _Nullable titl) {
        if (index == 0) {
            callBlock(index,titl);
        }
    };
    
}

- (PTLAlertView *)AlerType:(AlerEventType)Event{
    
    PTLAlertView * aler = nil;
    
    if (Event == AlerInProgressOrder){
        aler = [self alerInProgressOrder];
    }else if (Event == AlerLogout)
    {
        aler = [self alerLogout];
    } else if (Event == AlerLinkThird){
        aler = [self AlerLinkThird];
    } else if (Event == AlerCallOrderDir)
    {
        aler = [self AlerCallOrderDir];

    } else if (Event == AlerUnderwayOrder)
    {
        aler = [self AlerUnderwayOrder];

    }
    
    return aler;
}

- (PTLAlertView *)alerInProgressOrder{
    PTLAlertView * aler = [[PTLAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"有进行中的订单是否查看",nil) cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    aler.titleBackgroundColor = BlueColor;
    aler.titleTextColor = [UIColor whiteColor];
    aler.cancelBtnTextColor = BlueColor;
    aler.otherBtnTextColor = BlueColor;
    return aler;
}

- (PTLAlertView *)alerLogout{
    PTLAlertView * aler = [[PTLAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"确定退出吗?",nil) cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    aler.titleBackgroundColor = BlueColor;
    aler.cancelBtnTextColor = TextColor;
    aler.otherBtnTextColor = TextColor;
    return aler;
}

- (PTLAlertView *)AlerLinkThird{
    PTLAlertView * aler = [[PTLAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"确定解除绑定吗?",nil) cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    return aler;
    
}
- (PTLAlertView *)AlerCallOrderDir{
    PTLAlertView * aler = [[PTLAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil) message:NSLocalizedString(@"有正在召唤订单是否查看?点击'进行中'查看",nil) cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    aler.titleBackgroundColor = BlueColor;
    aler.titleTextColor = [UIColor whiteColor];
    aler.cancelBtnTextColor = BlueColor;
    aler.otherBtnTextColor = BlueColor;
    return aler;
    
}
- (PTLAlertView *)AlerUnderwayOrder{
    PTLAlertView * patlalert = [[PTLAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil) message:NSLocalizedString(@"有正在执行的召唤订单是否查看?",nil) cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    patlalert.titleBackgroundColor = BlueColor;
    patlalert.titleTextColor = [UIColor whiteColor];
    patlalert.cancelBtnTextColor = BlueColor;
    patlalert.otherBtnTextColor = BlueColor;
    
    return patlalert;
    
}


@end
