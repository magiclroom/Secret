//
//  NKLoginButton.m
//  百思不得姐
//
//  Created by J on 15/11/8.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKLoginButton.h"
#import "UIView+NKExtension.h"

@implementation NKLoginButton


- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.NK_y = 0;
    self.imageView.NK_centerX = self.NK_width * 0.5;
    
    self.titleLabel.NK_x = 0;
    self.titleLabel.NK_y = self.imageView.NK_height;
    self.titleLabel.NK_width = self.NK_width;
    self.titleLabel.NK_height = self.NK_height - self.imageView.NK_height;
}

@end
