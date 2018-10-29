//
//  SystemAuthority.h
//  PattayaUser
//
//  Created by 明克 on 2018/3/16.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, systemAuthorityType) {
    systemAuthorityCamera,
    systemAuthorityPhotoLibrary,
    systemAuthorityNotifacation,
    systemAuthorityNetwork,
    systemAuthorityAudio,
    systemAuthorityLocation,
    systemAuthorityAddressBook,
    systemAuthorityCalendar,
    systemAuthorityReminder,
};

@interface SystemAuthority : NSObject
/**
 相机权限开关
 @return YES/NO
 */
- (BOOL)CameraAuthority;
/**
 相册权限开关
 @return YES/NO
 */
- (BOOL)PhotoLibraryAuthority;
/**
 推送权限开关
 @return YES/NO
 */
- (BOOL)notificationAuthority;
/**
 连网权限开关
 @return YES/NO
 */
- (BOOL)netWorkAuthority;
/**
 麦克风权限开关
 @return YES/NO
 */
- (BOOL)audioAuthority;
/**
 定位权限开关
 @return YES/NO
 */
- (BOOL)locationAuthority;
/**
 通讯录权限开关
 @return YES/NO
 */
- (BOOL)addressBookAuthority;
/**
 日历权限开关
 @return YES/NO
 */
- (BOOL)calendarAuthority;
/**
 备忘录权限开关
 @return YES/NO
 */
- (BOOL)reminderAuthority;
@end
