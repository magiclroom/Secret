//
//  NKTabBarButton.m
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKTabBarButton.h"

@implementation NKTabBarButton

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.titleLabel.frame.origin.x > self.imageView.frame.origin.x) {
        self.imageView.center = CGPointMake(self.bounds.size.width * 0.5 - 5, self.bounds.size.height * 0.5 - 5);
        self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + self.imageView.frame.size.height + 2, self.imageView.frame.size.width, 10);
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
