//
//  AppDelegate.m
//  Banning
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "AppDelegate.h"
#import "TXSaveUsrSetting.h"
#import "TXTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
   // 初始化tabbar
    [self tabbarLayout];
    
    [self.window makeKeyAndVisible];
    
    
    // 处理通知
    [self dealLocalNotification:launchOptions];
    
    return YES;
}


#pragma mark -- 处理本地通知
- (void)dealLocalNotification:(NSDictionary *)launchOptions{

    // 接受本地通知参数
    /*在iOS8下武安方弹出通知出现下面的错误:
     Attempting to schedule a local notification with a sound but haven't received permission from the user to badge the application.
     原因是iOS8系统变更了注册方法,需要在applicationDelegate里面注册通知才可以
     */
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
    {

        NSLog(@"Recieved Notification == %@",localNotif);
        NSDictionary* infoDic = localNotif.userInfo;
         NSLog(@"userInfo description == %@",[infoDic description]);

    }

    
    // 获取本地所有通知
    NSArray *notification = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notify in notification) {
        
        NSLog(@"获取本地所有通知%@---->", notify);
    }
/*
//    // 获取系统当前时间
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"HH:mm";
//    NSString *dateString = [formatter stringFromDate:date];
//    
//    // 发送通知
//    BOOL flag = [[TXSaveUsrSetting sharedTXSaveUsrSetting] isOff];
//    NSString *time = [[TXSaveUsrSetting sharedTXSaveUsrSetting] warnTimeString];
//    
//    if (flag && [time isEqualToString:dateString]) {
//        
//        NSLog(@"YES--->开启通知");
//        
//        
//    }else{
//        
//        NSLog(@"NO --- >移除本地通知");
//        if (_notication) {
//            
//            [[UIApplication sharedApplication] cancelLocalNotification:_notication];
//        }
//        
//    }
//    
//    NSLog(@"提醒状态:%hhd, 提醒时间%@, 当前时间:%@", flag, time, dateString);
    
*/
}


#pragma mark -- 初始化tabBar
- (void)tabbarLayout{

//    // 创建tabBarController
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    
//    // 修改tabbar背景颜色
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
//    backView.backgroundColor = [UIColor colorWithRed:0.994 green:0.925 blue:1.000 alpha:1.000];
//    [tabBarController.tabBar insertSubview:backView atIndex:0];
//    tabBarController.tabBar.opaque = YES;
//    
//    // 加载4个storyBoard
//    UIStoryboard *diaryingSB = [UIStoryboard storyboardWithName:@"Diarying" bundle:[NSBundle mainBundle]];
//    
//    UIStoryboard *mapSB = [UIStoryboard storyboardWithName:@"Map" bundle:[NSBundle mainBundle]];
//    
//    UIStoryboard *calendarSB = [UIStoryboard storyboardWithName:@"Calendar" bundle:[NSBundle mainBundle]];
//    
//    UIStoryboard *meSB = [UIStoryboard storyboardWithName:@"Me" bundle:[NSBundle mainBundle]];
//    
//    // 将4个storyBoard添加到tabBarController中
//    
//    
//    tabBarController.viewControllers = @[diaryingSB.instantiateInitialViewController, mapSB.instantiateInitialViewController, calendarSB.instantiateInitialViewController, meSB.instantiateInitialViewController];
    
    // 设置跟控制器
//    self.window.rootViewController = tabBarController;
    
    self.window.rootViewController = [[TXTabBarViewController alloc] init];
}


#pragma mark -- 接受本地通知的时候触发
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

            //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒
//        if (application.applicationState == UIApplicationStateActive) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:notification.alertBody delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction, nil];
//            [alert show];
//        }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

#pragma mark -- 程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
