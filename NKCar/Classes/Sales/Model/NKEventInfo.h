//
//  NKEventInfo.h
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKEventInfo : NSObject

@property (nonatomic, copy) NSString *eventSmallImg;

@property (nonatomic, assign) NSInteger eventType;

@property (nonatomic, copy) NSString *eventTitle;

@property (nonatomic, copy) NSString *statisticsUrl;

@property (nonatomic, assign) NSInteger eventStatus;

@property (nonatomic, copy) NSString *eventEndTime;

@property (nonatomic, copy) NSString *eventOwner;

@property (nonatomic, copy) NSString *eventBigImg;

@property (nonatomic, assign) NSInteger eventPostId;

@property (nonatomic, assign) NSInteger eventId;

@property (nonatomic, copy) NSString *eventTime;

@property (nonatomic, copy) NSString *eventLink;

@property (nonatomic, copy) NSString *eventPlace;

@property (nonatomic, assign) NSInteger eventInterest;


@end
