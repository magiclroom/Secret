//
//  AppDelegate.m
//  NKCar
//
//  Created by J on 15/10/31.
//  Copyright (c) 2015年 jay. All rights reserved.
//
#import "AppDelegate.h"
#import "NKMainViewController.h"
#import "NKNewFeatureViewController.h"
#import "NKGuide.h"
#import "UMSocial.h"
#import <SMS_SDK/SMSSDK.h>
#import "NKTopWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [NKGuide chooseRootViewCOntroller];
    [self.window setBackgroundColor:NKRGBColor(244, 244, 244)];
    [self.window makeKeyAndVisible];
    
    // 添加一个最高级别的顶层window
    [NKTopWindow show];
    
    //友盟分享
    [UMSocialData setAppKey:@"564fc736e0f55a04dd000c42"];
    
    //短信验证
    [SMSSDK registerApp:@"c8795947ccd8" withSecret:@"cc887070a116e105b9c13db43cc5acaa"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
