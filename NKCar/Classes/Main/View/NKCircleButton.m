//
//  NKCircleButton.m
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKCircleButton.h"

@implementation NKCircleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.tag = 5;
        [self setBackgroundImage:[UIImage imageNamed:@"touxiang_hui"] forState:UIControlStateNormal];
        self.clipsToBounds = YES;
    }
    return self;
}




@end
