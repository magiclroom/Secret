//
//  NKMyHeaderView.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKMyHeaderView.h"

@interface NKMyHeaderView();

//登录按钮
@property (nonatomic,weak) UIButton *loginButton;

//背景
@property (nonatomic,weak) UIImageView *bgView;

@property (nonatomic,weak) UIImageView *colorView;

@end

@implementation NKMyHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        UIImageView *bgView = [[UIImageView alloc] init];
        [self addSubview:bgView];
        bgView.image = [UIImage imageNamed:@"bg"];
        self.bgView = bgView;
    
        UIButton *loginButton = [[UIButton alloc] init];
        [self addSubview:loginButton];
        [loginButton setTitle:@"登录 / 注册" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton = loginButton;
        self.loginButton.layer.borderWidth = 1;
        self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.loginButton.layer.cornerRadius = 3;
        [self.loginButton addTarget:self action:@selector(jumpLoginVC) forControlEvents:UIControlEventTouchUpInside];
        
        // 彩色带
        UIImageView *colorView = [[UIImageView alloc] init];
        [colorView setImage:[UIImage imageNamed:@"qiandaotishi"]];
        [self addSubview:colorView];
        self.colorView = colorView;
    }
    
    
    return self;
}

//点击登录按钮
- (void)jumpLoginVC
{
    if ([_delegate respondsToSelector:@selector(loginBtnDidClick:)]) {
        [_delegate loginBtnDidClick:self];
    }
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loginButton.frame = CGRectMake(0, 0, 100, 30);
    self.loginButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    
    self.bgView.frame = self.bounds;
     self.colorView.frame =CGRectMake(0, CGRectGetMaxY(self.frame), self.bounds.size.width, 5.0f);

}

@end
