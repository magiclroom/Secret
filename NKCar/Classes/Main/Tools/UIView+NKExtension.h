//
//  UIView+UIView_Frame.h
//  01-彩票
//
//  Created by J on 15/9/21.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NKExtension)


//分类中的property只能声明

/** X*/
@property (nonatomic,assign) CGFloat NK_x;

/** Y*/
@property (nonatomic,assign) CGFloat NK_y;

/** Width*/
@property (nonatomic,assign) CGFloat NK_width;

/** Hight*/
@property (nonatomic,assign) CGFloat NK_height;

/** CenterX*/
@property (nonatomic,assign) CGFloat NK_centerX;

/** CenterY*/
@property (nonatomic,assign) CGFloat NK_centerY;

/** 是否交叉*/
- (BOOL)intersectWithView:(UIView *)view;

@end
