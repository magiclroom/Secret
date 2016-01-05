//
//  NKCity.m
//  02-注册表
//
//  Created by J on 15/9/6.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKCity.h"

@implementation NKCity

+(instancetype)cityWithDict:(NSDictionary *)dict
{
    NKCity *city = [[self alloc] init];
    
    [city setValuesForKeysWithDictionary:dict];
    
    return city;
}

@end
