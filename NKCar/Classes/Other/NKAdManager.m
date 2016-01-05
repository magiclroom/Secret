//
//  NKAdManager.m
//  XCar
//
//  Created by 牛康康 on 15/10/19.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKAdManager.h"
#import "NKNetworkTool.h"
#import "NKResponseModel.h"
#import "MJExtension.h"

@implementation NKAdManager

#define currentCachesAdImage  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/adCurrent.png"]

#define newCachesAdImage [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/adNew.png"]

/**
 *  @author NK, 15-10-19 22:10:14
 *
 *  是否能显示广告图片
 *
 *  @return 是否能显示
 */
+(BOOL)shouldShowAdImage
{
    return [[NSFileManager defaultManager] fileExistsAtPath:currentCachesAdImage isDirectory:nil] || [[NSFileManager defaultManager] fileExistsAtPath:newCachesAdImage isDirectory:nil];
    return YES;
}


/**
 *  @author NK, 15-10-19 21:10:09
 *
 *  将服务器返回的图片保存到本地缓存文件夹中
 *
 *  @param url 图片URL
 */
+(void) downloadImageWith:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^ void (NSData * __nullable data, NSURLResponse * __nonnull response, NSError * __nullable error) {
        if (data) {
            [data writeToFile:newCachesAdImage atomically:YES];
        }
    }];

    [task resume];
}

/**
 *  @author NK, 15-10-19 21:10:18
 *
 *  像服务器请求最新的广告图片信息
 */
+(void)loadLatestAdImage
{
    NKNetworkTool *tool = [NKNetworkTool sharedNetworkToolWithoutBaseUrl];
    [[tool GET:NKGetLunchPic parameters:nil success:^ void(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        [NKResponseModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        NKResponseModel *model = [NKResponseModel objectWithKeyValues:responseObject];
        if (model.imgUrl != nil) {
            //获取到图片后保存到本地缓存文件夹
            [self downloadImageWith:[NSURL URLWithString:model.imgUrl]];
        }
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
}

/**
 *  @author NK, 15-10-19 22:10:46
 *
 *  从缓存目录获取广告图片，替换旧的广告图片
 *
 *  @return 新的广告图片
 */
+(UIImage  *) getAdImage
{
    //如果当前存在新下载的图片
    if ([[NSFileManager defaultManager] fileExistsAtPath:newCachesAdImage isDirectory:nil]) {
        //将旧的缓存图片移除
        [[NSFileManager defaultManager] removeItemAtPath:currentCachesAdImage error:nil];
        //将新的缓存图片设置为旧的缓存图片
        [[NSFileManager defaultManager] moveItemAtPath:newCachesAdImage toPath:currentCachesAdImage error:nil];
    }
    //将现有的图片返回
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:currentCachesAdImage]];
}

@end
