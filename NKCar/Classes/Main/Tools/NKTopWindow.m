//
//  NKTopWindow.m
//  NKCar
//
//  Created by J on 15/11/25.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKTopWindow.h"

@implementation NKTopWindow

static UIWindow *window_;
+ (void)show
{
    // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor clearColor];
        window_.windowLevel = UIWindowLevelAlert;
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}

+ (void)topWindowClick
{
    // 主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 查找主窗口中的所有scrollView
    [self findScrollViewsInView:window];
}

/**
 *  查找view中的所有scrollView
 */
+ (void)findScrollViewsInView:(UIView *)view
{
    // 利用递归查找所有的子控件
    for (UIView *subview in view.subviews) {
        [self findScrollViewsInView:subview];
    }
    
    // 如果不是scrollView
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    // 判断是否跟window有重叠
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    //    CGRect windowRect = [UIApplication sharedApplication].keyWindow.bounds;
    //    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    //    // 跟window不重叠
    //    if (!CGRectIntersectsRect(windowRect, viewRect)) return;
    
    // 如果是scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    
    // 修改offset
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    
    // [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
