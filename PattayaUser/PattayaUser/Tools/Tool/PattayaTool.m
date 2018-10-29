//
//  PattayaTool.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/29.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PattayaTool.h"
#import <MapKit/MapKit.h>
@implementation PattayaTool
+ (BOOL)isNull:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        return obj == nil || [obj isEqual:[NSNull null]] || [obj isEqualToString:@"<null>"] || [self isEmpty:obj];
    } else if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue] == 0;
    }
    else
        return obj == nil || [obj isEqual:[NSNull null]];
}
//判断字符串是否为空
+ (BOOL) isEmpty:(NSString *) str
{
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

///阴影
+ (void)shadowColorAndShadowOpacity:(UIView *)view color:(NSString *)strColor Alpha:(CGFloat)alpha
{
    view.layer.cornerRadius = 3;
    view.layer.shadowColor = [UIColor colorWithHexString:strColor Alpha:alpha].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowRadius = 5.0f;
    view.layer.shadowOpacity = 1.0f;
}


+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color Alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    //判断前缀
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    //从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R G B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (void)phoneNumber:(NSString *)tel
{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",tel];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{}
           completionHandler:^(BOOL success) {
               if (success) {
                   NSLog(@"成功");
               } else
               {
                   NSLog(@"失败");
               }
               NSLog(@"Open %@: %d",str,success);
           }];
    } else {
        BOOL success = [application openURL:URL];
        NSLog(@"Open %@: %d",str,success);
        if (success) {
            NSLog(@"成功");
            
        } else
        {
            NSLog(@"失败");
            
        }
    }
}


+ (void)goNavtionMap:(NSString *)lat log:(NSString *)ln
{
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&poiname=%@&lat=%@&lon=%@&dev=1&style=2",@"pattaya",@"测试", @"31.217028",@"121.421308" ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:urlString];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:URL];
    if (canOpen) {
        
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{}
               completionHandler:^(BOOL success) {
                   if (success) {
                       NSLog(@"导航成功");
                   } else
                   {
                       NSLog(@"导航失败");
                       
                   }
                   NSLog(@"Open %@: %d",urlString,success);
               }];
        } else {
            BOOL success = [application openURL:URL];
            NSLog(@"Open %@: %d",urlString,success);
            if (success) {
                NSLog(@"导航成功");
                
            } else
            {
                NSLog(@"导航失败");
                
            }
        }
    } else
    {
        PTLAlertView * pal = [[PTLAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"尚未安装高德地图",nil) cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [pal show];
    };
    
    
}




//获取当前页面
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
+ (UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

#pragma mark -- 是否登录
+ (BOOL)isUserLogin
{
    NSString *userId =  [self token];
    
    if (![self isNull:userId])
    {
        //已经登录
        return YES;
    }
    return NO;
}
#pragma mark -- 存储登录
+ (BOOL)loginSaveToken:(NSString *)token
{
    NSString * path = [self loadPlistPath:@"token.plist"];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:path contents:nil attributes:nil];
    BOOL success = [@{@"token":token} writeToFile:path atomically:YES];
    return success;
}

+ (BOOL)loginSavename:(NSString *)name mobile:(NSString *)mobile
{
    BOOL isSussce = [self writeTofilePlist:@"userInfo.plist" text:@{@"name":name,@"mobile":mobile}];
    return isSussce;
}
+ (void)INVALID_ACCESS_TOKEN
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:@"" forKey:@"token"];
    BOOL isSussce = [userDefaults synchronize];
    NSLog(@"%d",isSussce);
    [self loginSaveToken:@""];
}

+ (NSString *)loadPlistPath:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistpath = [paths objectAtIndex:0];
    NSString *filename=[plistpath stringByAppendingPathComponent:path];
    NSLog(@"path = %@",filename);
    return filename;
}
//写入内容
+ (BOOL)writeTofilePlist:(NSString *)textName text:(NSDictionary *)dic
{
    NSString * path = [self loadPlistPath:textName];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:path contents:nil attributes:nil];
    BOOL success = [dic writeToFile:path atomically:YES];
   return success;
}
//读取内容
+ (NSDictionary *)contentsOffile:(NSString *)textName
{
    NSString * path = [self loadPlistPath:textName];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"dic is:%@",dic2);
    return dic2;
}

+ (NSString *)loadUpToken
{
    NSDictionary * dic = [self contentsOffile:@"token.plist"];
    return dic[@"token"];
}
+ (NSString *)userName
{
    NSDictionary * dic = [self contentsOffile:@"userInfo.plist"];
    return dic[@"name"];
}
+ (NSString *)userMobile
{
    NSDictionary * dic = [self contentsOffile:@"userInfo.plist"];
    return dic[@"mobile"];
}

+ (BOOL)chenkLogin:(NSString *)code
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:code forKey:@"chenk"];
    BOOL isSussce = [userDefaults synchronize];
    return isSussce;
}

+ (BOOL)isUserLoginStats
{
    NSString *userId =  [[NSUserDefaults standardUserDefaults]objectForKey:@"chenk"];
    
    if (![self isNull:userId])
    {
        //已经登录
        return YES;
    }
    return NO;
}


+ (NSString *)driName
{
    NSDictionary * dic = [self contentsOffile:@"userInfo.plist"];
    return dic[@"name"];
}
+ (NSString *)mobileDri
{
    NSDictionary * dic = [self contentsOffile:@"userInfo.plist"];
    return dic[@"mobile"];
}
+ (NSString *)token{
    NSDictionary * dic = [self contentsOffile:@"token.plist"];
    return dic[@"token"];
}
+ (NSString *)ConvertStrToTime:(NSString *)timeStr
{
    long long time=[timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}
+ (NSString *)ConvertStrToTime:(NSString *)timeStr Fromatter:(NSString *)foramt
{
    long long time=[timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:foramt];
    NSString*timeString=[formatter stringFromDate:d];
    return timeString;
}

+ (NSArray *)checkHasOwnApp{
    NSArray *mapSchemeArr ;
   
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://navi"]]){
        mapSchemeArr =@[@"iosamap://navi"];
    }
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"苹果地图",nil),nil];
    
    for (int i =0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i ==0) {
                [appListArr addObject:NSLocalizedString(@"高德地图",nil)];
            }else {
                
            }
        }
    }
    
    return appListArr;
}
+ (UIAlertController *)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    //    _currentLatitude = currentLatitude;
    //    _currentLongitute = currentLongitute;
    //    _targetLatitude = targetLatitude;
    //    _targetLongitute = targetLongitute;
    //    _name = name;
    
    UIViewController * vc = [PattayaTool findBestViewController:[PattayaTool getCurrentVC]];
    
    NSArray *appListArr = [PattayaTool checkHasOwnApp];
    NSString * temp = NSLocalizedString(@"导航到 ",nil);
    NSString *sheetTitle = [NSString stringWithFormat:@"%@%@",temp,name];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示",nil) message:sheetTitle preferredStyle:UIAlertControllerStyleAlert];

    if (appListArr.count == 1) {
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:appListArr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ok");
            
            CLLocationCoordinate2D from =CLLocationCoordinate2DMake(currentLatitude,currentLongitute);
            MKMapItem * currentLocation =[[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:from addressDictionary:nil]];
            currentLocation.name =NSLocalizedString(@"我的位置",nil);
            
            //终点
            CLLocationCoordinate2D to =CLLocationCoordinate2DMake(targetLatitude,targetLongitute);
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            //            NSLog(@"网页google地图:%f,%f",to.latitude,to.longitude);
            toLocation.name = name;
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
            NSDictionary *options =@{
                                     MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                     MKLaunchOptionsMapTypeKey:
                                         [NSNumber numberWithInteger:MKMapTypeStandard],
                                     MKLaunchOptionsShowsTrafficKey:@YES
                                     };
            //打开苹果自身地图应用
            [MKMapItem openMapsWithItems:items launchOptions:options];
            
        }];
        [alertController addAction:okAction];
    } else if(appListArr.count == 2)
    {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:appListArr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ok");
            
            CLLocationCoordinate2D from =CLLocationCoordinate2DMake(currentLatitude,currentLongitute);
            MKMapItem * currentLocation =[[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:from addressDictionary:nil]];
            currentLocation.name =NSLocalizedString(@"我的位置",nil);
            
            //终点
            CLLocationCoordinate2D to =CLLocationCoordinate2DMake(targetLatitude,targetLongitute);
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            //            NSLog(@"网页google地图:%f,%f",to.latitude,to.longitude);
            toLocation.name = name;
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
            NSDictionary *options =@{
                                     MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                     MKLaunchOptionsMapTypeKey:
                                         [NSNumber numberWithInteger:MKMapTypeStandard],
                                     MKLaunchOptionsShowsTrafficKey:@YES
                                     };
            //打开苹果自身地图应用
            [MKMapItem openMapsWithItems:items launchOptions:options];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:appListArr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel");
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",currentLatitude,currentLongitute,NSLocalizedString(@"我的位置",nil),targetLatitude,targetLongitute,name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *r = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:r];
            
        }];
     
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];

    }
    
    UIAlertAction *errorAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"error");
        [vc dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertController addAction:errorAction];

//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:appListArr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"cancel");
//
//        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",currentLatitude,currentLongitute,NSLocalizedString(@"我的位置",nil),targetLatitude,targetLongitute,name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        NSURL *r = [NSURL URLWithString:urlString];
//        [[UIApplication sharedApplication] openURL:r];
//
//    }];
//    UIAlertAction *errorAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"error");
//        [vc dismissViewControllerAnimated:YES completion:nil];
//
//    }];
    
   
    
    
    return  alertController;
}



///计算文字长度 自适应
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font sizemake:(CGSize) withsize;
{
    CGRect rect = [string boundingRectWithSize:withsize//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

@end
