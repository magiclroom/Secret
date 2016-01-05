//
//  NKMyHeaderLoginFinshVIew.m
//  NKCar
//
//  Created by J on 15/11/7.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKMyHeaderLoginFinshView.h"

@interface NKMyHeaderLoginFinshView();


//登录按钮
@property (nonatomic,weak) UIButton *loginButton;

/** 登录名*/
@property (nonatomic,weak) UILabel *userNameLabel;

//背景
@property (nonatomic,weak) UIImageView *bgView;

@property (nonatomic,weak) UIImageView *colorView;

@end

@implementation NKMyHeaderLoginFinshView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        UIImageView *bgView = [[UIImageView alloc] init];
        [self addSubview:bgView];
        bgView.image = [UIImage imageNamed:@"bg"];
        self.bgView = bgView;
        
//        // 设置按钮
//        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [settingBtn setTitle:@"" forState:UIControlStateNormal];
//        [settingBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        CGFloat settingBtnY = 20.0f;
//        CGFloat settingBtnW = 40.0f;
//        CGFloat settingBtnH = 40.0f;
//        CGFloat settingBtnX = NKSCREEN_W - settingBtnW - 10;
//        [settingBtn setFrame:CGRectMake(settingBtnX, settingBtnY, settingBtnW, settingBtnH)];
//        [self addSubview:settingBtn];
        
        
        // 头像
        UIImageView *avatarView = [[UIImageView alloc] init];
        UIImage *avatarPlaceHolder = [UIImage imageNamed:@"man"];
        [avatarView setImage:avatarPlaceHolder];
        [avatarView setUserInteractionEnabled:YES];
        CGFloat avatarViewX = 30.0f;
        CGFloat avatarViewY = 70.0f;
        CGFloat avatarViewW = 65.0f;
        CGFloat avatarViewH = 65.0f;
        [avatarView setFrame:CGRectMake(avatarViewX, avatarViewY, avatarViewW, avatarViewH)];
        [self.bgView addSubview:avatarView];
        
        //
        UIButton *containBtn = [[UIButton alloc] init];
        [containBtn setBackgroundColor:[UIColor clearColor]];
        CGFloat containBtnX = CGRectGetMaxX(avatarView.frame) + 12;
        CGFloat containBtnY = avatarViewY;
        CGFloat containBtnW = NKSCREEN_W - avatarViewW;
        CGFloat containBtnH = avatarViewH;
        [containBtn setFrame:CGRectMake(containBtnX, containBtnY, containBtnW, containBtnH)];
        [self.bgView addSubview:containBtn];
        
        // 用户名
        UILabel *userNameLabel = [[UILabel alloc] init];
        self.userNameLabel = userNameLabel;
        [userNameLabel setText:@"Samtse"];
        [userNameLabel setFont:[UIFont systemFontOfSize:19]];
        [userNameLabel setTextColor:[UIColor whiteColor]];
        CGFloat userNameX = 0;
        CGFloat userNameY = 0;
        NSDictionary *userNameAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:19]};
        CGSize userNameSize = [userNameLabel.text sizeWithAttributes:userNameAttrs];
        [userNameLabel setFrame:CGRectMake(userNameX, userNameY, userNameSize.width, userNameSize.height)];
        [containBtn addSubview:userNameLabel];
        
        // 男/女
        UIImageView *genderView = [[UIImageView alloc] init];
        [genderView setImage:[UIImage imageNamed:@"nan"]];
        CGFloat genderX = CGRectGetMaxX(userNameLabel.frame) + 3.0f;
        CGFloat genderY = userNameY + 3;
        CGFloat genderW = 18.0f;
        CGFloat genderH = 18.0f;
        [genderView setFrame:CGRectMake(genderX, genderY, genderW, genderH)];
        [containBtn addSubview:genderView];
        
        // 爱卡币
        UILabel *moneyLabel = [[UILabel alloc] init];
        [moneyLabel setText:@"爱卡币：66"];
        [moneyLabel setFont:[UIFont systemFontOfSize:15]];
        [moneyLabel setTextColor:[UIColor whiteColor]];
        CGFloat moneyX = userNameX;
        CGFloat moneyY = CGRectGetMaxY(genderView.frame) + 3.0f;
        NSDictionary *moneyAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGSize moneySize = [moneyLabel.text sizeWithAttributes:moneyAttrs];
        [moneyLabel setFrame:CGRectMake(moneyX, moneyY, moneySize.width, moneySize.height)];
        [containBtn addSubview:moneyLabel];
        
//        // 提示
//        UIImageView *accessoryView = [[UIImageView alloc] init];
//        [accessoryView setImage:[UIImage imageNamed:@"baijiantou"]];
//        [accessoryView setUserInteractionEnabled:YES];
//        [accessoryView setFrame:CGRectMake(3 * moneySize.width, moneyY, 12.0f, 21.0f)];
//        [containBtn addSubview:accessoryView];
        
        // 等级
        UILabel *levelLabel = [[UILabel alloc] init];
        [levelLabel setText:@"新手上路"];
        [levelLabel setFont:[UIFont systemFontOfSize:17]];
        [levelLabel setTextColor:[UIColor whiteColor]];
        CGFloat levelX = moneyX;
        CGFloat levelY = CGRectGetMaxY(moneyLabel.frame) + 3.0f;
        NSDictionary *levelAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGSize levelSize = [moneyLabel.text sizeWithAttributes:levelAttrs];
        [levelLabel setFrame:CGRectMake(levelX, levelY, levelSize.width, levelSize.height)];
        [containBtn addSubview:levelLabel];
        
        // 等级图片
        UIImageView *levelView = [[UIImageView alloc] init];
        [levelView setImage:[UIImage imageNamed:@"xing"]];
        CGFloat levelViewX = CGRectGetMaxX(levelLabel.frame);
        CGFloat levelViewY = levelY + 2.0f;
        CGFloat levelViewW = 18.0f;
        CGFloat levelViewH = 18.0f;
        [levelView setFrame:CGRectMake(levelViewX, levelViewY, levelViewW, levelViewH)];
        [containBtn addSubview:levelView];

        // 帖子
        UIButton *tieziBtn = [[UIButton alloc] init];
        [tieziBtn setBackgroundColor:NKRGBAColor(160, 160, 160, 0.3)];
        [tieziBtn setFrame:CGRectMake(0.0, CGRectGetMaxY(avatarView.frame) + 20, NKSCREEN_W / 3, 50.0f)];
        [self.bgView addSubview:tieziBtn];
        
        UILabel *tieziNumLabel = [[UILabel alloc] init];
        [tieziNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [tieziNumLabel setFont:[UIFont systemFontOfSize:18]];
        [tieziNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *tieziNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize tieziNumSize = [tieziNumLabel.text sizeWithAttributes:tieziNumAttrs];
        [tieziNumLabel setFrame:CGRectMake(tieziBtn.frame.size.width / 2 - tieziNumSize.width / 2, tieziBtn.frame.size.height / 2 - tieziNumSize.height, tieziNumSize.width, tieziNumSize.height)];
        [tieziBtn addSubview:tieziNumLabel];
        
        
        UILabel *tieziLabel = [[UILabel alloc] init];
        [tieziLabel setText:@"帖子"];
        [tieziLabel setFont:[UIFont systemFontOfSize:18]];
        [tieziLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *tieziAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize tieziSize = [tieziLabel.text sizeWithAttributes:tieziAttrs];
        [tieziLabel setFrame:CGRectMake(tieziBtn.frame.size.width / 2 - tieziSize.width / 2, tieziBtn.frame.size.height * 2 / 3 - tieziSize.height / 2, tieziSize.width, tieziSize.height)];
        [tieziBtn addSubview:tieziLabel];
        
        // 粉丝
        UIButton *followerBtn = [[UIButton alloc] init];
        [followerBtn setBackgroundColor:NKRGBAColor(160, 160, 160, 0.3)];
        [followerBtn setFrame:CGRectMake(tieziBtn.frame.size.width, CGRectGetMaxY(avatarView.frame) + 20, NKSCREEN_W / 3, 50.0f)];
        [self.bgView addSubview:followerBtn];
        
        UILabel *follerNumLabel = [[UILabel alloc] init];
        [follerNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [follerNumLabel setFont:[UIFont systemFontOfSize:18]];
        [follerNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *follerNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize follerNumSize = [follerNumLabel.text sizeWithAttributes:follerNumAttrs];
        [follerNumLabel setFrame:CGRectMake(followerBtn.frame.size.width / 2 - follerNumSize.width / 2, followerBtn.frame.size.height / 2 - follerNumSize.height, follerNumSize.width, follerNumSize.height)];
        [followerBtn addSubview:follerNumLabel];
        
        
        UILabel *follerLabel = [[UILabel alloc] init];
        [follerLabel setText:@"粉丝"];
        [follerLabel setFont:[UIFont systemFontOfSize:18]];
        [follerLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *follerAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize follerSize = [tieziLabel.text sizeWithAttributes:follerAttrs];
        [follerLabel setFrame:CGRectMake(followerBtn.frame.size.width / 2 - follerSize.width / 2, followerBtn.frame.size.height * 2 / 3 - follerSize.height / 2, follerSize.width, follerSize.height)];
        [followerBtn addSubview:follerLabel];
        
        // 关注
        UIButton *gzBtn = [[UIButton alloc] init];
        [gzBtn setBackgroundColor:NKRGBAColor(160, 160, 160, 0.3)];
        [gzBtn setFrame:CGRectMake(CGRectGetMaxX(followerBtn.frame), CGRectGetMaxY(avatarView.frame) + 20, NKSCREEN_W / 3, 50.0f)];
        [self.bgView addSubview:gzBtn];
        
        UILabel *gzNumLabel = [[UILabel alloc] init];
        [gzNumLabel setText:[NSString stringWithFormat:@"%@", @0]];
        [gzNumLabel setFont:[UIFont systemFontOfSize:18]];
        [gzNumLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *gzNumAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize gzNumSize = [follerNumLabel.text sizeWithAttributes:gzNumAttrs];
        [gzNumLabel setFrame:CGRectMake(gzBtn.frame.size.width / 2 - gzNumSize.width / 2, gzBtn.frame.size.height / 2 - gzNumSize.height, gzNumSize.width, gzNumSize.height)];
        [gzBtn addSubview:gzNumLabel];
        
        
        UILabel *gzLabel = [[UILabel alloc] init];
        [gzLabel setText:@"关注"];
        [gzLabel setFont:[UIFont systemFontOfSize:18]];
        [gzLabel setTextColor:[UIColor  whiteColor]];
        NSDictionary *gzAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
        CGSize gzSize = [tieziLabel.text sizeWithAttributes:gzAttrs];
        [gzLabel setFrame:CGRectMake(gzBtn.frame.size.width / 2 - gzSize.width / 2, gzBtn.frame.size.height * 2 / 3 - gzSize.height / 2, gzSize.width, gzSize.height)];
        [gzBtn addSubview:gzLabel];

        // 彩色带
        UIImageView *colorView = [[UIImageView alloc] init];
        [colorView setImage:[UIImage imageNamed:@"qiandaotishi"]];
        [self addSubview:colorView];
        self.colorView = colorView;
        
        
    }
    
    
    return self;
}

//更改用户名
- (void)replaceUserName:(NSString *)title
{
   
    [self.userNameLabel setText:title];
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
