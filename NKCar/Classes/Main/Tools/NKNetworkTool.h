//
//  NKNetWorkTool.h
//  XCar
//
//  Created by 牛康康 on 15/10/19.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "AFNetworking.h"

@interface NKNetworkTool : AFHTTPSessionManager

+(instancetype) sharedNetworkTool;


+(instancetype) sharedNetworkToolWithoutBaseUrl;

@end
