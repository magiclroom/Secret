//
//  NKNavigationController.m
//  百思不得姐
//
//  Created by J on 15/11/6.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKNavigationController.h"
#import "NKMyViewController.h"
#import "NKTabBar.h"

@interface NKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //滑动边缘手势的代理
    self.interactivePopGestureRecognizer.delegate = self;
    
}

+ (void)initialize
{
    if (self == [NKNavigationController class]) {
        
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        dict[NSForegroundColorAttributeName] = NKBlueColor;
        [bar setTitleTextAttributes:dict];
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //返回按钮
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [exitBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [exitBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [exitBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [exitBtn sizeToFit];
        //内边距，向左偏移
        exitBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [exitBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
        //隐藏TableBar
        viewController.hidesBottomBarWhenPushed = YES;

    }
    
    [super pushViewController:viewController animated:animated];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
    
}

//返回
- (void)popView
{
   [self popViewControllerAnimated:YES];
}

@end
