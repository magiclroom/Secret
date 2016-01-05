//
//  NKADView.m
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKADView.h"
#import "NKAdManager.h"
#import "NKMainViewController.h"


@interface NKADView ()
/** 时间*/
@property (nonatomic,weak)UILabel *timeLabel;
/** 定时器*/
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,weak)UIView *adView;
@property (nonatomic,weak)UIView *bottomView;
@property (nonatomic,weak)UIView *quikView ;
@end

@implementation NKADView

static NSInteger number = 3;

- (void)awakeFromNib
{
    [self setUPADView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUPADView];
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(minusTime) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)minusTime
{
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",number];
    number --;
    if (number == 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setUPADView
{

        UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H - 120)];
        self.adView = adView;
        [self addSubview:adView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, NKSCREEN_H - 120, NKSCREEN_W, 120)];
        self.bottomView = bottomView;
        bottomView.backgroundColor = [UIColor whiteColor];
        UIImageView *bottomImageView = [[UIImageView alloc] init];
        [self addSubview:bottomView];
        bottomImageView.image = [UIImage imageNamed:@"Begin_Logo"];
        bottomImageView.frame = CGRectMake(0, 0, 300, 40);
        bottomImageView.center = CGPointMake(bottomView.frame.size.width * 0.5, bottomView.frame.size.height * 0.5);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[NKAdManager getAdImage]];
        imageView.frame = adView.frame;
        [adView addSubview:imageView];

        
        UIView *quikView = [[UIView alloc] init];
        self.quikView = quikView;
        quikView.backgroundColor = [UIColor colorWithRed:100 / 255.0 green:200 / 255.0 blue:237 / 255.0 alpha:0.7];
        quikView.layer.cornerRadius = 3;
        [self addSubview:quikView];
        [quikView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(72);
            make.height.mas_equalTo(30);
            make.top.equalTo(self.mas_top).offset(30);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        UIButton *quikBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [quikBtn setTitle:@"点击跳过" forState:UIControlStateNormal];
        quikBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        quikBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [quikBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [quikBtn addTarget:self action:@selector(removeADView) forControlEvents:UIControlEventTouchUpInside];
        [quikView addSubview:quikBtn];
            [quikBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.top.equalTo(quikView.mas_top);
            make.left.equalTo(quikView.mas_left);
        }];
        
        UILabel *quikLabel = [[UILabel alloc] init];
        self.timeLabel = quikLabel;
        [quikLabel setText:@"3"];
        quikLabel.font = [UIFont systemFontOfSize:14];
        [quikView addSubview:quikLabel];
        [quikLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(30);
            make.top.equalTo(quikView.mas_top);
            make.right.equalTo(quikView.mas_right);
        }];

        [bottomView addSubview:bottomImageView];
        adView.alpha = 0.99;
        //显示3秒后从父控件中移除
        [UIView animateWithDuration:4.0 animations:^{
            adView.alpha = 1.0;
            bottomView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.75 animations:^{
                quikView.alpha = 0.0;
                adView.alpha = 0.0;
                bottomView.alpha = 0.0;
                [self setUPAnimal];
                } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
}

- (void)removeADView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.quikView.alpha = 0.0;
        self.adView.alpha = 0.0;
        self.bottomView.alpha = 0.0;
        [self setUPAnimal];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}

- (void)setUPAnimal
{
    CATransition *animon = [CATransition animation];
    animon.type = @"rippleEffect";
    animon.duration = 2;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animon forKey:nil];

}

@end
