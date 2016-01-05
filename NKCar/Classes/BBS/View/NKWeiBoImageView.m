//
//  NKWeiBoImageView.m
//  NKCar
//
//  Created by J on 15/11/15.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKWeiBoImageView.h"

@interface NKWeiBoImageView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NKWeiBoImageView


- (void)setWeiboImage:(UIImage *)weiboImage
{
    _imageView.image = weiboImage;
}

- (UIImage *)weiboImage
{
    return _imageView.image;
}

- (IBAction)closeBtnClick {
    
    [self removeFromSuperview];
}

@end
