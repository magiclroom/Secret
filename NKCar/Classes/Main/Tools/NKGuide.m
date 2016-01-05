//
//  NKGuide.m
//  彩票
//
//  Created by J on 15/10/7.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKGuide.h"
#import "NKNewFeatureViewController.h"
#import "NKMainViewController.h"


@implementation NKGuide

+ (UIViewController *)chooseRootViewCOntroller
{
    UIViewController *vc = nil;
    
    //获得当前info.plist文件
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    //获得最新版本号
    NSString *newVersion = info[@"CFBundleShortVersionString"];
    
    //从沙盒中读取上一版本号
    NSString *loadVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"newVersion"];
    
//    //比较版本号是否相同
//    if ([newVersion isEqualToString:loadVersion]) {
//        
//        //添加根控制器
//        vc = [[NKMainViewController alloc] init];
//    
//    }else {
//        
//        //设置新特性导航为根控制器
//        vc = [[NKNewFeatureViewController alloc] init];
//        
//        //存储最新版本号到沙盒中
//        [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"newVersion"];
//        
//    }
    //设置新特性导航为根控制器
    vc = [[NKNewFeatureViewController alloc] init];
    
    return vc;
}

@end
