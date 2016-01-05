//
//  NKNews.h
//  XCar
//
//  Created by 牛康康 on 15/10/22.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKNews : NSObject

/**
 *  新闻类别
 */
@property (nonatomic, copy) NSString *newsCategory;

/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *newsTitle;

@property (nonatomic, assign) NSInteger newsId;

@property (nonatomic, copy) NSString *statisticsUrl;

/**
 *  新闻发布时间
 */
@property (nonatomic, assign) NSInteger newsCreateTime;

/**
 *  web端网页详情
 */
@property (nonatomic, copy) NSString *webLink;

/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *newsImage;

/**
 *  广告Index？ 如果是广告类型的话该数值会有值
 */
@property (nonatomic, assign) NSInteger adIndex;

/**
 *  评论数量
 */
@property (nonatomic, assign) NSInteger commentCount;

/**
 *
 */
@property (nonatomic, assign) NSInteger isSpread;

/**
 *  新闻类别1:广告2:新闻
 */
@property (nonatomic, assign) NSInteger newsType;

/**
 *  手机端链接详情
 */
@property (nonatomic, copy) NSString *newsLink;


@end
