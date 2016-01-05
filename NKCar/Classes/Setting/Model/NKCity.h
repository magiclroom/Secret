//
//  NKCity.h
//  02-注册表
//
//  Created by J on 15/9/6.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKCity : NSObject

/** 省*/
@property (nonatomic,strong)NSString *name;

/** 市*/
@property (nonatomic,strong)NSArray *cities;

+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
