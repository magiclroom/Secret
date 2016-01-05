//
//  NKHostPostModel.h
//  NKCar
//
//  Created by J on 15/11/4.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NKHostPostModel : NSObject


/** 头像*/
@property (nonatomic,copy)NSString *icon;

/** 昵称*/
@property (nonatomic,strong)NSString *name;

/** vip*/
@property (nonatomic,assign,getter=isVip) BOOL vip;

/** 正文*/
@property (nonatomic,strong)NSString *text;

/** 图片*/
@property (nonatomic,copy)NSString *picture;


@property (nonatomic,assign) CGRect iconFrame;

@property (nonatomic,assign) CGRect nameFrame;

@property (nonatomic,assign) CGRect vipFrame;

@property (nonatomic,assign) CGRect moreFrame;

@property (nonatomic,assign) CGRect textFrame;

@property (nonatomic,assign) CGRect pictureFrame;

@property (nonatomic,assign) CGRect interactionViewFrame;

/** cell的高*/
@property (nonatomic,assign) CGFloat cellHeight;


@end
