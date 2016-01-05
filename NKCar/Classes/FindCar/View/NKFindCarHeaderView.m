//
//  NKFindCarHeaderView.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKFindCarHeaderView.h"
#import "NKSalesCar.h"
#import "UIImageView+WebCache.h"

@interface NKFindCarHeaderView()


@property (nonatomic,weak) UIImageView *leftCornerImageView;

@property (nonatomic,weak) UIImageView *carView;

@property (nonatomic,weak) UILabel *carTitleLabel;

@property(nonatomic,weak) UILabel *carPreferentialLabel;

@property(nonatomic,weak) UILabel *businessLabel;

@property (nonatomic,weak)  UIButton *askPriceButton;

@property (nonatomic,weak) UIButton *telButton;

@end


@implementation NKFindCarHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftCornerImageView = [[UIImageView alloc] init];
        [self addSubview:leftCornerImageView];
        leftCornerImageView.image = [UIImage imageNamed:@"jrth"];
        self.leftCornerImageView = leftCornerImageView;
        
        UIImageView *carView = [[UIImageView alloc] init];
        [self addSubview:carView];
        self.carView = carView;
        
        
        UILabel *carTitleLabel = [[UILabel alloc] init];
        [carTitleLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:carTitleLabel];
        self.carTitleLabel = carTitleLabel;
        
        
        UILabel *carPreferentialLabel = [[UILabel alloc] init];
        [carPreferentialLabel setTextColor:[UIColor redColor]];
        [carPreferentialLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:carPreferentialLabel];
        self.carPreferentialLabel = carPreferentialLabel;
        
        UILabel *businessLabel = [[UILabel alloc] init];
        [businessLabel setTextColor:[UIColor grayColor]];
        [businessLabel setFont:[UIFont systemFontOfSize:9]];
        [self addSubview:businessLabel];
        self.businessLabel = businessLabel;
        
        UIButton *askPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [askPriceButton setBackgroundColor:NKRGBColor(37, 161, 222)];
        [askPriceButton setTitle:@"问最低价" forState:UIControlStateNormal];
        [askPriceButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [askPriceButton setImage:[UIImage imageNamed:@"zuidijia_white"] forState:UIControlStateNormal];
        askPriceButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        askPriceButton.layer.cornerRadius = 2;
        [self addSubview:askPriceButton];
        self.askPriceButton = askPriceButton;
        
        UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [telButton setBackgroundColor:NKRGBColor(37, 161, 222)];
        [telButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        [telButton setImage:[UIImage imageNamed:@"tel_white"] forState:UIControlStateNormal];
        telButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [telButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        telButton.layer.cornerRadius = 2;
        [self addSubview:telButton];
        self.telButton = telButton;
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 5;
    [self.leftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 46));
    }];
    
    [self.carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(2 * margin);
        make.size.mas_equalTo(CGSizeMake(90 , 67.5));
    }];
    
    [self.carTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carView.mas_right).offset(margin);
        make.top.mas_equalTo(self).offset(margin);
        make.size.mas_equalTo(CGSizeMake(240, 20));
    }];
    
    [self.carPreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carView.mas_right).offset(margin);
        make.top.mas_equalTo(self.carTitleLabel.mas_bottom).offset(margin);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];

    [self.businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carView.mas_right).offset(margin);
        make.top.mas_equalTo(self.carPreferentialLabel.mas_bottom).offset(margin);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];

    
    [self.askPriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(2 * margin);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self).offset(-2 * margin);
        make.right.mas_equalTo(self.telButton.mas_left).offset(-margin);
        make.width.mas_equalTo(self.telButton);
    }];
    
    [self.telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self).offset(-2 * margin);
        make.right.mas_equalTo(self).offset(- 2  * margin);
        make.width.mas_equalTo(self.askPriceButton);
    }];
}


-(void)setSalesCar:(NKSalesCar *)salesCar
{
    _salesCar = salesCar;
    [self.carView sd_setImageWithURL:[NSURL URLWithString:salesCar.seriesImage]];
    self.carTitleLabel.text = [NSString stringWithFormat:@"%@ %@",salesCar.seriesName,salesCar.carName];
    self.carPreferentialLabel.text = [NSString stringWithFormat:@"直降%.1f万",salesCar.cheapRange];
    self.businessLabel.text = salesCar.dealerName;
    
}


@end
