//
//  NKNewsCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/22.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKNewsCell.h"
#import "NKNews.h"
#import "UIImageView+WebCache.h"

@interface NKNewsCell()

//新闻图片
@property (nonatomic,weak) UIImageView *newsImage;
//新闻标题
@property (nonatomic,weak) UILabel *newsTitle;
//新闻发布时间
@property (nonatomic,weak) UILabel *newsPubTime;
//新闻评论数
@property (nonatomic,weak) UIButton *newsComment;
//新闻的类型
@property(nonatomic,weak) UILabel *newsType;

@end

@implementation NKNewsCell

+(instancetype)newsCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"newsCell";
    NKNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NKNewsCell alloc] init];
    }
    return cell;
}

-(instancetype)init
{
    if (self = [super init]) {
        UIImageView *newsImage = [[UIImageView alloc] init];
        [self.contentView addSubview:newsImage];
        self.newsImage = newsImage;
        
        UILabel *newsTitle = [[UILabel alloc] init];
        [self.contentView addSubview:newsTitle];
        [newsTitle setFont:[UIFont systemFontOfSize:14]];
        self.newsTitle = newsTitle;
        
        UILabel *newsPubTime = [[UILabel alloc] init];
        [self.contentView addSubview:newsPubTime];
        [newsPubTime setFont:[UIFont systemFontOfSize:9]];
        self.newsPubTime = newsPubTime;
        
        UIButton *newsComment = [[UIButton alloc] init];
        [self.contentView addSubview:newsComment];
        [newsComment.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [newsComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newsComment setImage:[UIImage imageNamed:@"baitian_pinglun_old"] forState:UIControlStateNormal];
        [newsComment.titleLabel setTextAlignment:NSTextAlignmentRight];
        self.newsComment = newsComment;
        
        UILabel *newsType = [[UILabel alloc] init];
        [self.contentView addSubview:newsType];
        [newsType setFont:[UIFont systemFontOfSize:9]];
        [newsType setTextAlignment:NSTextAlignmentCenter];
        self.newsType = newsType;
    
    }
    return self;
}

/**
 *  重新布局子空间 autolayout
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(margin);
        make.bottom.mas_equalTo(self.contentView).offset(-margin);
        make.width.mas_equalTo(80);
    }];
    
    [self.newsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newsImage);
        make.left.mas_equalTo(self.newsImage.mas_right).offset(margin);
        make.right.mas_equalTo(self.contentView).offset(-margin);
        make.height.mas_equalTo(30);
    }];
    
    [self.newsPubTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.newsImage.mas_bottom);
        make.left.mas_equalTo(self.newsImage.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.newsComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.newsImage.mas_bottom);
        make.left.mas_equalTo(self.newsPubTime.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.newsType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-margin);
        make.bottom.mas_equalTo(self.newsImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
}

/**
 *  绑定cell的模型
 *
 *  @param news 新闻模型
 */
-(void)setNews:(NKNews *)news
{
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:news.newsImage]];
    self.newsTitle.text = news.newsTitle;
    //时间戳转时间
    NSDate *timesp = [NSDate dateWithTimeIntervalSince1970:news.newsCreateTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.newsPubTime.text = [formatter stringFromDate:timesp];
   
    [self.newsComment setTitle:[NSString stringWithFormat:@"%ld",news.commentCount] forState:UIControlStateNormal];
    self.newsType.text = news.newsCategory;
}

@end

