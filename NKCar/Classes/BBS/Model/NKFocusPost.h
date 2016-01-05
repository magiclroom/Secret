//
//  NKFocusPost.h
//  XCar
//
//  Created by 牛康康 on 15/10/24.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKFocusPost : NSObject

@property (nonatomic, copy) NSString *focusImage;

@property (nonatomic, copy) NSString *focusLink;

@property (nonatomic, assign) NSInteger focusType;

@property (nonatomic, assign) NSInteger focusId;

@property (nonatomic, copy) NSString *focusTitle;

@property (nonatomic, copy) NSString *statisticsUrl;

@end
