//
//  NSString+NKExtension_h.m
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NSString+NKExtension.h"

@implementation NSString (NKExtension)

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    //判断路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (exists == NO) return 0;
    if (isDirectory) {//文件夹
        
        NSInteger size = 0;
        //获得文件夹所有内容
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            //获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            //文件属性
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
        }
        return size;
    }else {//文件
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }

    
}

@end
