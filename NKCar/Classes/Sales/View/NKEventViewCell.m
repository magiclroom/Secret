//
//  NKEventViewCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKEventViewCell.h"
#include "NKEventInfo.h"
#import "UIImageView+WebCache.h"

@interface NKEventViewCell();

@property(nonatomic,weak) UIView *bgView;

@property(nonatomic,weak) UIImageView *leftCornerImageView;
//大图背景
@property (nonatomic,weak) UIImageView *eventImageView;
//活动标题
@property(nonatomic,weak) UILabel *eventTitleLabel;
//活动截止时间
@property(nonatomic,weak) UILabel *eventTimeLabel;
//活动地点
@property(nonatomic,weak) UILabel *eventPlaceLabel;
//感兴趣的人数
@property(nonatomic,weak) UIButton *eventInterestButton;
//分享给其他人
@property(nonatomic,weak) UIButton *shareButton;

@property(nonatomic,weak) UIView *lineHView;

@end

@implementation NKEventViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        UIImageView *eventImageView = [[UIImageView alloc] init];
        [self.bgView addSubview:eventImageView];
        self.eventImageView = eventImageView;
        
        UIImageView *leftCornerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jinxing"]];
        [self.bgView addSubview:leftCornerImageView];
        self.leftCornerImageView = leftCornerImageView;
        
        UILabel *eventTitleLabel = [[UILabel alloc] init];
        [eventTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.bgView addSubview:eventTitleLabel];
        self.eventTitleLabel = eventTitleLabel;
        
        UILabel *eventTimeLabel = [[UILabel alloc] init];
        [eventTimeLabel setFont:[UIFont systemFontOfSize:12]];
        [eventTimeLabel setTextColor:[UIColor grayColor]];
        [self.bgView addSubview:eventTimeLabel];
        self.eventTimeLabel = eventTimeLabel;
        
        UILabel *eventPlaceLabel = [[UILabel alloc] init];
        [eventPlaceLabel setFont:[UIFont systemFontOfSize:12]];
         [eventPlaceLabel setTextColor:[UIColor grayColor]];
        [self.bgView addSubview:eventPlaceLabel];
        self.eventPlaceLabel = eventPlaceLabel;
        
        UIButton *eventInterestButton = [[UIButton alloc] init];
        eventInterestButton.layer.borderColor = [UIColor grayColor].CGColor;
        eventInterestButton.layer.borderWidth = 0.5;
        [eventInterestButton.titleLabel setFont:[UIFont systemFontOfSize:8]];
        eventInterestButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [eventInterestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [eventInterestButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self.bgView addSubview:eventInterestButton];
        self.eventInterestButton = eventInterestButton;
        
        UIButton *shareButton = [[UIButton alloc] init];
        shareButton.layer.borderColor = [UIColor grayColor].CGColor;
        shareButton.layer.borderWidth = 0.5;
        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [shareButton.titleLabel setFont:[UIFont systemFontOfSize:8]];
         shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [shareButton setTitle:@"分销给好友" forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [self.bgView addSubview:shareButton];
        self.shareButton = shareButton;
        
//        UIView *lineHView = [[UIView alloc] init];
//        lineHView.backgroundColor = [UIColor grayColor];
//        [self.bgView addSubview:lineHView];
//        self.lineHView = lineHView;

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
        make.right.mas_equalTo(self.contentView).offset(-10);
    }];

    [self.leftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.eventImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
        make.height.mas_equalTo(200);
    }];
    
    [self.eventTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.eventImageView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.eventTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.eventTitleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(280, 20));
    }];
    
    [self.eventPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.eventTimeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.eventInterestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(-0.5);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.bgView).offset(0.5);
        make.right.mas_equalTo(self.shareButton.mas_left);
        make.width.mas_equalTo(self.shareButton);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.bgView).offset(0.5);
        make.right.mas_equalTo(self.bgView).offset(0.5);
        make.width.mas_equalTo(self.eventInterestButton);
    }];
    
//    [self.lineHView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgView);
//        make.right.mas_equalTo(self.bgView);
//        make.width.mas_equalTo(self.bgView);
//        make.height.mas_equalTo(1);
//    }];
    
}


-(void)setEventInfo:(NKEventInfo *)eventInfo
{
    [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:eventInfo.eventBigImg]];
    self.eventTitleLabel.text = eventInfo.eventTitle;
    self.eventTimeLabel.text = [NSString stringWithFormat:@"活动截止日期 : %@",eventInfo.eventEndTime];
    self.eventPlaceLabel.text = [NSString stringWithFormat:@"活动地点 ：%@ ",eventInfo.eventPlace];
    [self.eventInterestButton setTitle:[NSString stringWithFormat:@"%ld人感兴趣",eventInfo.eventInterest] forState:UIControlStateNormal];

}

@end
