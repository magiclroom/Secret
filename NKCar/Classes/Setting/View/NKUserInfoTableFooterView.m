//
//  NKUserInfoTableFooterView.m
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKUserInfoTableFooterView.h"

@implementation NKUserInfoTableFooterView

- (void)awakeFromNib
{
    [self setUPFooterView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    [self setUPFooterView];
    }
    return self;
}

- (void)setUPFooterView
{
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setTitle:@"退出账号" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateNormal];
    [self addSubview:quitBtn];
    [quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(45);
    }];
}

- (void)quitBtnClick
{
    if ([_delegate respondsToSelector:@selector(quitBtnDidClick:)]) {
        [_delegate quitBtnDidClick:self];
    }
}

@end
