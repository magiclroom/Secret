//
//  NKSettingClearTableViewCell.m
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKSettingClearTableViewCell.h"
#import "MBProgressHUD+NK.h"

#import "SDImageCache.h"

//缓存路径
#define NKCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]


static NSString * const NkDefultText = @"清除缓存";

@implementation NKSettingClearTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.textLabel.text = NkDefultText;
        self.userInteractionEnabled = NO;
        //右边显示圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        __weak typeof(self) weakSelf = self;
        
        //计算大小
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            //计算缓存大小
           //NSInteger size = [SDImageCache sharedImageCache].getSize;
            NSInteger size = NKCacheFile.fileSize;
            //当前控制器消失
            if (weakSelf == nil) return;
            
            CGFloat unit = 1000.0;
            NSString *sizeText = nil;
            if (size >= unit * unit * unit) { // >= 1GB
                sizeText = [NSString stringWithFormat:@"%.1fGB", size / unit / unit / unit];
            } else if (size >= unit * unit) { // >= 1MB
                sizeText = [NSString stringWithFormat:@"%.1fMB", size / unit / unit];
            } else if (size >= unit) { // >= 1KB
                sizeText = [NSString stringWithFormat:@"%.1fKB", size / unit];
            } else { // >= 0B
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            NSString *text = [NSString stringWithFormat:@"%@(%@)", NkDefultText, sizeText];
            
            //回到主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.textLabel.text = text;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                accessoryView的优先级是高于UITableViewCellAccessoryDisclosureIndicator（没有指针指针就挂了）
                weakSelf.accessoryView = nil;
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                weakSelf.userInteractionEnabled = YES;
            }];
        }];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //让圈圈继续旋转
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}


- (void)clearCache
{
    [MBProgressHUD showMessage:@"正在清除缓存"];
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        [[NSFileManager defaultManager] removeItemAtPath:NKCacheFile error:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
#warning sleep 
            [NSThread sleepForTimeInterval:0.5];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"清除成功"];
            self.textLabel.text = NkDefultText;
            self.userInteractionEnabled = NO;
        }];
        
    }];
}


@end
