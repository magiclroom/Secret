//
//  NKDiscountInfo.h
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKDiscountInfo : NSObject


@property (nonatomic, copy) NSString *discount;

@property (nonatomic, assign) NSInteger seriesId;

@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger newsId;

@property (nonatomic, assign) NSInteger remain;

@property (nonatomic, copy) NSString *dealerName;

@property (nonatomic, assign) NSInteger carId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger dealerId;

@property (nonatomic, copy) NSString *webLink;

@property (nonatomic, assign) NSInteger ext;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, copy) NSString *imageUrl;


@end
