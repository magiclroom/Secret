//
//  NKMyCollectionButton.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKMyCollectionButton.h"
#import "UIView+NKExtension.h"

@interface NKMyCollectionButton()

@property (nonatomic,weak) UIView *borderView;

@end

@implementation NKMyCollectionButton

-(UIView *)borderView
{
    if (_borderView == nil) {
        UIView *borderView =  [[UIView alloc] init];
        borderView.backgroundColor = [UIColor clearColor];
        [self addSubview:borderView];
        _borderView = borderView;
    }
    return _borderView;
}



-(void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}

// 按钮的边界
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
   
    return CGRectMake(10, 20, 50, 50);//图片的位置大小
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,65, 65, contentRect.size.height - 50);
}

@end
