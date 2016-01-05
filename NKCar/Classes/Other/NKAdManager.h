//
//  NKAdManager.h
//  XCar
//
//  Created by 牛康康 on 15/10/19.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//系统启动时候广告图片的管理类
@interface NKAdManager : NSObject

//下载最新的广告图片
+(void) loadLatestAdImage;

+(BOOL) shouldShowAdImage;

+(UIImage  *) getAdImage;

@end
