//
//  NKViewController.h
//  01-通讯录
//
//  Created by J on 15/9/9.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKLoginViewController;

@protocol NKLoginViewControllerDelegate <NSObject>

@optional
- (void)loginBtnDidClick:(NKLoginViewController *)loginVC title:(NSString *)title;

@end

@interface NKLoginViewController : UIViewController

/** 代理属性*/
@property (nonatomic,weak)id<NKLoginViewControllerDelegate> delegate;

@end
