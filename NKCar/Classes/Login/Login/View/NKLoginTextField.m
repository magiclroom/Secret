//
//  NKLoginTextField.m
//  NKCar
//
//  Created by J on 15/11/10.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKLoginTextField.h"

@implementation NKLoginTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //设置光标颜色
    self.tintColor = NKBlueColor;
    
  //监听文字
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];

}

//开始编辑
- (void)editingDidBegin
{
    
    //设置占位文字颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}

//结束编辑
- (void)editingDidEnd
{
    
    //设置占位文字颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}


@end
