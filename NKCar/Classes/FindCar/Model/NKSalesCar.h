
//
//  NKSalesCar.h
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NKSalesCar : NSObject

@property (nonatomic, assign) NSInteger seriesId;

@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, assign) NSInteger dealerType;

@property (nonatomic, copy) NSString *dealerTel;

@property (nonatomic, assign) NSInteger saleId;

@property (nonatomic, copy) NSString *dealerName;

@property (nonatomic, assign) NSInteger carId;

@property (nonatomic, assign) CGFloat cheapRange;

@property (nonatomic, copy) NSString *seriesImage;

@property (nonatomic, assign) NSInteger dealerId;

@property (nonatomic, assign) NSInteger proId;

@property (nonatomic, assign) NSInteger ext;

@property (nonatomic, assign) NSInteger cityId;

@end
