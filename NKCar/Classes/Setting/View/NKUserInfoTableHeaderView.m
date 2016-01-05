//
//  NKSettingTableHeaderView.m
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKUserInfoTableHeaderView.h"


@implementation NKUserInfoTableHeaderView
- (void)awakeFromNib
{
    [self setUPHeaderView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUPHeaderView];
    }
    return self;
}


- (void)setUPHeaderView
{
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"man"];
    [self addSubview:iconView];
    iconView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [iconView addGestureRecognizer:tap];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.width.height.mas_equalTo(100);
        make.centerX.equalTo(self);
    }];
    
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.6;
    [iconView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_left);
        make.right.equalTo(iconView.mas_right);
        make.bottom.equalTo(iconView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"编辑";
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [grayView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(grayView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];

}

- (void)tapClick
{
    if ([_delegate respondsToSelector:@selector(editBtnDidClick:)]) {
        [_delegate editBtnDidClick:self];
    }
}


@end
