//
//  NKNetWorkTool.m
//  XCar
//
//  Created by 牛康康 on 15/10/19.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKNetWorkTool.h"

@implementation NKNetworkTool

+(instancetype)sharedNetworkTool
{
    static NKNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://mi.xcar.com.cn/interface"];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return instance;
}

+(instancetype) sharedNetworkToolWithoutBaseUrl
{
    static NKNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@""];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return instance;


}


@end
