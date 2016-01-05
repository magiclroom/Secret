//
//  NKDiscountViewCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKDiscountViewCell.h"
#import "NKDiscountInfo.h"
#import "UIImageView+WebCache.h"


@interface NKDiscountViewCell()

@property (nonatomic,weak) UIView *bgView;

//汽车图像
@property (nonatomic,weak) UIImageView *carImage;
//汽车标题
@property(nonatomic,weak) UILabel *carTitleLabel;
//汽车折扣
@property(nonatomic,weak) UILabel*carDiscountLabel;
//汽车现价
@property (nonatomic,weak) UILabel *carNowPriceLabel;
//购车计算
@property (nonatomic,weak) UIButton *buyCarButton;
//拨打电话
@property (nonatomic,weak) UIButton *telButton;
//问最低价
@property (nonatomic,weak) UIButton *askPriceButton;
//有无现车
@property (nonatomic,weak) UILabel *tagLabel;
//剩余时间戳
@property(nonatomic,weak) UILabel *retainDayLabel;


@end

@implementation NKDiscountViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        UIImageView *carImage = [[UIImageView alloc] init];
        [self.bgView addSubview:carImage];
        self.carImage = carImage;
        
        UILabel *carTitleLabel = [[UILabel alloc] init];
        [carTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.bgView addSubview:carTitleLabel];
        self.carTitleLabel = carTitleLabel;

        UILabel *carDiscountLabel = [[UILabel alloc] init];
        [carDiscountLabel setTextColor:[UIColor orangeColor]];
        [carDiscountLabel setFont:[UIFont systemFontOfSize:12]];
        [self.bgView addSubview:carDiscountLabel];
        self.carDiscountLabel = carDiscountLabel;

        UILabel *carNowPriceLabel = [[UILabel alloc] init];
         [carNowPriceLabel setFont:[UIFont systemFontOfSize:12]];
        [self.bgView addSubview:carNowPriceLabel];
        self.carNowPriceLabel = carNowPriceLabel;
        
        UIButton *buyCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyCarButton setTitle:@"购车计算" forState:UIControlStateNormal];
        buyCarButton.layer.cornerRadius = 4;
        buyCarButton.layer.borderWidth = 1;
        buyCarButton.layer.borderColor = NKRGBColor(37, 161, 222).CGColor;
        [buyCarButton setTitleColor:NKRGBColor(37, 161, 222) forState:UIControlStateNormal];
        [self.bgView addSubview:buyCarButton];
        self.buyCarButton = buyCarButton;

        UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [telButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        telButton.layer.borderWidth = 1;
        [telButton setTitleColor:NKRGBColor(37, 161, 222) forState:UIControlStateNormal];
        telButton.layer.borderColor = NKRGBColor(37, 161, 222).CGColor;
        telButton.layer.cornerRadius = 4;
        [self.bgView addSubview:telButton];
        self.telButton = telButton;

        UIButton *askPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [askPriceButton setTitle:@"问最低价" forState:UIControlStateNormal];
        askPriceButton.layer.borderColor = NKRGBColor(37, 161, 222).CGColor;
        askPriceButton.layer.cornerRadius = 4;
        [askPriceButton setBackgroundColor:NKRGBColor(37, 161, 222)];
        [self.bgView addSubview:askPriceButton];
        self.askPriceButton = askPriceButton;

        
        UILabel *tagLabel = [[UILabel alloc] init];
        [tagLabel setFont:[UIFont systemFontOfSize:12]];
        [tagLabel setTextColor:[UIColor grayColor]];
        [tagLabel setTextAlignment:NSTextAlignmentRight];
        [self.bgView addSubview:tagLabel];
        self.tagLabel = tagLabel;
        
        UILabel *retainDayLabel = [[UILabel alloc] init];
        [retainDayLabel setFont:[UIFont systemFontOfSize:12]];
        [retainDayLabel setTextColor:[UIColor grayColor]];
        [retainDayLabel setTextAlignment:NSTextAlignmentRight];
        [self.bgView addSubview:retainDayLabel];
        self.retainDayLabel = retainDayLabel;

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
    
    [self.carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.bgView).offset(2);
        make.size.mas_equalTo(CGSizeMake(90, 67.5));
    }];
    
    [self.carTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carImage.mas_right).offset(2);
        make.top.mas_equalTo(self.bgView.mas_top).offset(2);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.carDiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carImage.mas_right).offset(2);
        make.top.mas_equalTo(self.carTitleLabel.mas_bottom).offset(2);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    [self.carNowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carImage.mas_right).offset(2);
        make.top.mas_equalTo(self.carDiscountLabel.mas_bottom).offset(2);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-2);
        make.top.mas_equalTo(self.carDiscountLabel);
        make.bottom.mas_equalTo(self.carDiscountLabel);
        make.width.mas_equalTo(70);
    }];

    [self.retainDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(-2);
        make.top.mas_equalTo(self.carNowPriceLabel);
        make.bottom.mas_equalTo(self.carNowPriceLabel);
        make.width.mas_equalTo(70);
    }];


    [self.buyCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.bgView).offset(-10);
        make.right.mas_equalTo(self.telButton.mas_left).offset(-10);
        make.width.mas_equalTo(self.telButton);
        make.width.mas_equalTo(self.askPriceButton);
    }];
    
    [self.telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.bgView).offset(-10);
        make.right.mas_equalTo(self.askPriceButton.mas_left).offset(- 10);
        make.width.mas_equalTo(self.buyCarButton);
    }];

    [self.askPriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.bgView).offset(-10);
        make.right.mas_equalTo(self.bgView).offset(- 10);
        make.width.mas_equalTo(self.buyCarButton);
    }];

    
    

}


-(void)setDiscountInfo:(NKDiscountInfo *)discountInfo
{
    _discountInfo = discountInfo;
    [self.carImage sd_setImageWithURL:[NSURL URLWithString:discountInfo.imageUrl]];
    self.carTitleLabel.text = discountInfo.carName;
    self.carDiscountLabel.text = [NSString stringWithFormat:@"直降%@",discountInfo.discount];
    self.carNowPriceLabel.text = [NSString stringWithFormat:@"现价%@",discountInfo.currentPrice];
    self.tagLabel.text = discountInfo.tag;
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:discountInfo.remain];
    NSDateComponents *components = [self calFromDate:startDate toDate:endDate];
    self.retainDayLabel.text = [NSString stringWithFormat:@"剩余%ld天",components.day];
    
    
}

-(NSDateComponents *) calFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:startDate toDate:endDate options:0];
    //int sec = [d hour]*3600+[d minute]*60+[d second];
    return components;
}

@end
