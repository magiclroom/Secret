//
//  NKHotPostViewCell.m
//  NKCar
//
//  Created by J on 15/11/4.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKHotPostViewCell.h"
#import "NKHostPostModel.h"
#import "TYAlertController.h"

@interface NKHotPostViewCell()

/** 头像*/
@property (nonatomic,weak)UIImageView *iconImageView;
/** 昵称*/
@property (nonatomic,weak)UILabel *nameLabel;
/** vip*/
@property (nonatomic,weak)UIImageView *vipImageView;
/** 更多*/
@property (nonatomic,weak)UIButton *moreBtn;
/** 正文*/
@property (nonatomic,weak)UILabel *text_Label;
/** 图片*/
@property (nonatomic,weak)UIImageView *pictureImageView;
/** 交互栏*/
@property (nonatomic,weak)UIView *interactionView;
/** 转发*/
@property (nonatomic,weak) UIButton *forwardBtn;
/** 评论*/
@property (nonatomic,weak)UIButton *talkBtn;
/** 点赞*/
@property (nonatomic,weak)UIButton *niceBtn;
/** 删除*/
@property (nonatomic,weak)UIButton *deleBtn;

@end

@implementation NKHotPostViewCell

//重写，加载cell子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //vip
        UIImageView *vipImage = [[UIImageView alloc] init];
        vipImage.image = [UIImage imageNamed:@"vip"];
        vipImage.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:vipImage];
        self.vipImageView = vipImage;
        
        //更多
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"cellmorebtnclick"] forState:UIControlStateHighlighted];
        self.moreBtn = moreBtn;
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
        
        //正文
        UILabel *text_Label = [[UILabel alloc] init];
        text_Label.font = [UIFont systemFontOfSize:14];
        text_Label.numberOfLines = 0;
        [self.contentView addSubview:text_Label];
        self.text_Label = text_Label;
        
        //图片
        UIImageView *pictureImage = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureImage];
        self.pictureImageView = pictureImage;
        
        //交互栏
        UIView *interactionView = [[UIView alloc] init];
        [self.contentView addSubview:interactionView];
        self.interactionView = interactionView;
        
        //转发按钮
        UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forwardBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        self.forwardBtn = forwardBtn;
        [forwardBtn addTarget:self action:@selector(forwardBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [interactionView addSubview:forwardBtn];
        
        //评论按钮
        UIButton *talkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [talkBtn setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
        self.talkBtn = talkBtn;
        [talkBtn addTarget:self action:@selector(talkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [interactionView addSubview:talkBtn];
        
        //点赞按钮
        UIButton *niceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [niceBtn setImage:[UIImage imageNamed:@"page_icon_unlike"] forState:UIControlStateNormal];
        [niceBtn setImage:[UIImage imageNamed:@"page_icon_like"] forState:UIControlStateSelected];
        self.niceBtn = niceBtn;
        [niceBtn addTarget:self action:@selector(niceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [interactionView addSubview:niceBtn];
        
        //删除
        UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleBtn setImage:[UIImage imageNamed:@"camera_water_mrak_delete"] forState:UIControlStateNormal];
        self.deleBtn = deleBtn;
        [deleBtn addTarget:self action:@selector(deleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [interactionView addSubview:deleBtn];
        
    }
    return self;
    
}

//子控件布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.frame = self.hpModel.iconFrame;
    self.nameLabel.frame = self.hpModel.nameFrame;
    self.vipImageView.frame = self.hpModel.vipFrame;
    self.moreBtn.frame = self.hpModel.moreFrame;
    self.text_Label.frame = self.hpModel.textFrame;
    self.pictureImageView.frame = self.hpModel.pictureFrame;
    self.interactionView.frame = self.hpModel.interactionViewFrame;
    [self setUPBtnLayout];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 7;
    [super setFrame:frame];
}

- (void)setUPBtnLayout
{
    CGFloat margin = (NKSCREEN_W - 120) / 5;
    
    [self.forwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(self.interactionView.mas_left).offset(margin -10);
        make.top.equalTo(self.interactionView.mas_top);
    }];
    
    [self.talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(self.forwardBtn.mas_right).offset(margin+10);
        make.top.equalTo(self.interactionView.mas_top);
    }];
    
    [self.niceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(self.talkBtn.mas_right).offset(margin+10);
        make.top.equalTo(self.interactionView.mas_top);
    }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.equalTo(self.niceBtn.mas_right).offset(margin+8);
        make.top.equalTo(self.interactionView.mas_top);
    }];
}

//重写set方法
- (void)setHpModel:(NKHostPostModel *)hpModel
{
    _hpModel = hpModel;
    
    self.iconImageView.image = [UIImage imageNamed:hpModel.icon];
    self.nameLabel.text = hpModel.name;
    self.text_Label.text = hpModel.text;
    
    if (hpModel.vip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipImageView.hidden = NO;
    }else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipImageView.hidden = YES;
    }
    
    if (hpModel.picture) {
        if ([hpModel.picture hasPrefix:@"/Users/j/Library/Developer"]) {
          
            NSRange range;
            range.location = [hpModel.picture rangeOfString:@"Caches/"].location+7;
            range.length = [hpModel.picture rangeOfString:@".png"].location-range.location;
            NSString *pictureName = [hpModel.picture substringWithRange:range];
            NSString *pictureFullName = [pictureName stringByAppendingString:@".png"];
            NSString *picturePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pictureFullName];
              self.pictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:picturePath]];
//            NKLog(@"-----%@",[hpModel.picture substringWithRange:range]);
//            NSLog(@"%ld,%ld",range.length,range.location);
//            NSLog(@"%@",hpModel.picture);
        }else {
            self.pictureImageView.image = [UIImage imageNamed:hpModel.picture];
        }
        self.pictureImageView.hidden = NO;
    }else {
        self.pictureImageView.hidden = YES;
    }
    
}


//更多
- (void)moreBtnClick
{
    if ([_delegate respondsToSelector:@selector(moreBtnDidClick:)]) {
        [_delegate moreBtnDidClick:self];
    }
}

//转发
- (void)forwardBtnClick
{
    if ([_delegate respondsToSelector:@selector(forwardBtnDidClick:)]) {
        [_delegate forwardBtnDidClick:self];
    }
}

//评论
- (void)talkBtnClick:(UIButton *)talkBtn
{
    //获取点击按钮在屏幕的位置
    CGPoint cureentPoint = [self.talkBtn convertPoint:CGPointZero toView:nil];

    if ([_delegate respondsToSelector:@selector(talkBtnDidClick:atPoint:)]) {
        [_delegate talkBtnDidClick:self atPoint:cureentPoint];
    }
}

//点赞
- (void)niceBtnClick
{
    if (self.niceBtn.selected) {
        self.niceBtn.selected = NO;
    }else {
        self.niceBtn.selected = YES;
    }
}

//删除
- (void)deleBtnClick
{
    if ([_delegate respondsToSelector:@selector(deleBtnDidClick:)]) {
        [_delegate deleBtnDidClick:self];
    }
}

@end
