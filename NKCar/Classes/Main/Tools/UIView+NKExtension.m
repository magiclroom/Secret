//
//  UIView+UIView_Frame.m
//  01-彩票
//
//  Created by J on 15/9/21.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "UIView+NKExtension.h"

@implementation UIView (NKExtension)


//x
- (CGFloat)NK_x
{
    return self.frame.origin.x;
}

- (void)setNK_x:(CGFloat)NK_x
{
    CGRect testFrame = self.frame;
    
    testFrame.origin.x = NK_x;
    
    self.frame = testFrame;
}

//y
- (CGFloat)NK_y
{
    return self.frame.origin.y;
}

- (void)setNK_y:(CGFloat)NK_y
{
    CGRect testFrame = self.frame;
    
    testFrame.origin.y = NK_y;
    
    self.frame = testFrame;
}

//width
- (CGFloat)NK_width
{
    return self.frame.size.width;
}

- (void)setNK_width:(CGFloat)NK_width
{
    CGRect testFrame = self.frame;
    
    testFrame.size.width = NK_width;
    
    self.frame = testFrame;
}


//y
- (CGFloat)NK_height
{
    return self.frame.size.height;
}

- (void)setNK_height:(CGFloat)NK_height
{
    CGRect testFrame = self.frame;
    
    testFrame.size.height = NK_height;
    
    self.frame = testFrame;
}


//centerX
- (CGFloat)NK_centerX
{
    return self.center.x;
}

- (void)setNK_centerX:(CGFloat)NK_centerX
{
    CGPoint cent = self.center;
    
    cent.x = NK_centerX;
    
    self.center = cent;
}


//centerY
- (CGFloat)NK_centerY
{
    return self.center.y;
}

- (void)setNK_centerY:(CGFloat)NK_centerY
{
    CGPoint cen = self.center;
    
    cen.y = NK_centerY;
    
    self.center = cen;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end
