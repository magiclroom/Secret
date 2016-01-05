//
//  NKTextField.m
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKTextView.h"
#import "NKEditKeywordToolbar.h"

@implementation NKTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUPTextView];
        [self setUPKeyword];
    }
    return self;
}

- (void)setUPTextView
{
    self.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"Arial" size:16];
    self.textColor = [UIColor blackColor];
    self.scrollEnabled = YES;
    
}

- (void)setUPKeyword
{
    //加载键盘工具栏
    UIToolbar *toolBar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NKEditKeywordToolbar class]) owner:nil options:nil] lastObject];
    //设置键盘工具栏
    self.inputAccessoryView = toolBar;
}











@end
