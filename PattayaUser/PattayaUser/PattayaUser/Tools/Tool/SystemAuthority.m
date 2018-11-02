//
//  SystemAuthority.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/16.
//  Copyright © 2018年 明克. All rights reserved.
//
#define SYSTEMVERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#import "SystemAuthority.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>
@import CoreTelephony;
@interface SystemAuthority ()
@end
@implementation SystemAuthority

- (BOOL)CameraAuthority
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self showAlertWithType:systemAuthorityCamera];
        return NO;
    }
    return YES;
}

- (BOOL)PhotoLibraryAuthority
{
//    if (SYSTEMVERSION >= 8.0) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if(authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted) {
            // 未授权
            [self showAlertWithType:systemAuthorityPhotoLibrary];
            return NO;
        }
//    }
    
    return YES;
}
- (BOOL)notificationAuthority
{
//    if (SYSTEMVERSION>=8.0f)
//    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types)
        {
            [self showAlertWithType:systemAuthorityNotifacation];
            return NO;
        }
//    }
  
    return YES;
}
- (BOOL)netWorkAuthority
{
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    if (state == kCTCellularDataRestricted) {
        [self showAlertWithType:systemAuthorityNetwork];
        return NO;
    }
    return YES;
}
- (BOOL)audioAuthority
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self showAlertWithType:systemAuthorityAudio];
        return NO;
    }
    return YES;
}
- (BOOL)locationAuthority
{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        if (CLstatus == kCLAuthorizationStatusDenied || CLstatus == kCLAuthorizationStatusDenied) {
            [self showAlertWithType:systemAuthorityLocation];
            return NO;
        }
    }
    return YES;
}
- (BOOL)addressBookAuthority
{
    if (SYSTEMVERSION >= 9.0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
        {
            [self showAlertWithType:systemAuthorityAddressBook];
            return NO;
        }
    }
    else
    {
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        if (ABstatus == kABAuthorizationStatusDenied || ABstatus == kABAuthorizationStatusRestricted)
        {
            [self showAlertWithType:systemAuthorityAddressBook];
            return NO;
        }
    }
    return YES;
}
- (BOOL)calendarAuthority
{
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted)
    {
        [self showAlertWithType:systemAuthorityCalendar];
        return NO;
    }
    return YES;
}
- (BOOL)reminderAuthority
{
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted)
    {
        [self showAlertWithType:systemAuthorityReminder];
        return NO;
    }
    return YES;
}
- (void)showAlertWithType:(systemAuthorityType)type
{
    NSString *title;
    NSString *msg;
    switch (type) {
        case systemAuthorityCamera:
            title = NSLocalizedString(@"未获得授权使用相机",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-相机 中打开。",nil);
            break;
        case systemAuthorityPhotoLibrary:
            title = NSLocalizedString(@"未获得授权使用相册",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-照片 中打开。",nil);
            break;
        case systemAuthorityNotifacation:
            title = NSLocalizedString(@"未获得授权使用推送",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-推送 中打开。",nil);
            break;
        case systemAuthorityNetwork:
            title = NSLocalizedString(@"未获得授权使用网络",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-网络 中打开。",nil);
            break;
        case systemAuthorityAudio:
            title = NSLocalizedString(@"未获得授权使用麦克风",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-麦克风 中打开。",nil);
            break;
        case systemAuthorityLocation:
            title = NSLocalizedString(@"未获得授权使用定位",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-定位 中打开。",nil);
            break;
        case systemAuthorityAddressBook:
            title = NSLocalizedString(@"未获得授权使用通讯录",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-通讯录 中打开。",nil);
            break;
        case systemAuthorityCalendar:
            title = NSLocalizedString(@"未获得授权使用日历",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-日历 中打开。",nil);
            break;
        case systemAuthorityReminder:
            title = NSLocalizedString(@"未获得授权使用备忘录",nil);
            msg = NSLocalizedString(@"请在设备的 设置-隐私-备忘录 中打开。",nil);
            break;
        default:
            break;
    }
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即前往", nil];
//    alertView.delegate = self;
//    [alertView show];
//    alertView.tag = type;
    
    PTLAlertView * alerview = [[PTLAlertView alloc] initWithTitle:NSLocalizedString(@"设置",nil) message:[NSString stringWithFormat:@"%@\n%@",title,msg] cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"前往设置",nil), nil];
    [alerview show];
    alerview.selctBtnBlock = ^(NSInteger tag, NSString * st) {
        if (tag == 0) {
            NSURL *url;
            if(SYSTEMVERSION >= 8.0)
            {
                //iOS8 以后
                url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                    [[UIApplication sharedApplication] openURL:url];
            }
        }
    };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
