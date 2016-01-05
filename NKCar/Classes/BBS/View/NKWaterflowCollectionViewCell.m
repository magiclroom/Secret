//
//  NKWaterflowCollectionViewCell.m
//  NKCar
//
//  Created by J on 15/11/18.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKWaterflowCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "NKWaterflowPicture.h"

@interface NKWaterflowCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,copy)NSString *picturePath;
@end

@implementation NKWaterflowCollectionViewCell

- (void)awakeFromNib
{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageView addGestureRecognizer:tap];
}


- (void)setPicture:(NKWaterflowPicture *)picture
{
    _picture = picture;
    NSString *picturePath = [@"http://tnfs.tngou.net/image" stringByAppendingPathComponent:picture.img];
    self.picturePath = picturePath;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:picturePath] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.imageView.userInteractionEnabled = NO;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:picturePath] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.imageView.userInteractionEnabled = YES;
    }];
}

- (void)imageViewClick:(UIImageView *)imageView
{
    // if (self.imageView.image == [UIImage imageNamed:@"loading"]) return;
    
    if ([_delegate respondsToSelector:@selector(imageViewClick:withImageView:withImagePath:)]) {
        [_delegate imageViewClick:self withImageView:self.imageView withImagePath:self.picturePath];
    }
}


@end
