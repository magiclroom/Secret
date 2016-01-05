//
//  NKFeatureCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKFeatureCell.h"
#import "NKMainViewController.h"

@interface NKFeatureCell()

@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UIButton *enterNewFeatureBtn;

@end

@implementation NKFeatureCell

-(UIButton *)enterNewFeatureBtn
{
    if (_enterNewFeatureBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"entryNewFeatures"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"entryNewFeatures_selected"] forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        [btn sizeToFit];
        btn.hidden = YES;
        [btn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchDown];
        self.enterNewFeatureBtn = btn;
    }
    return _enterNewFeatureBtn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.enterNewFeatureBtn.center = CGPointMake(self.center.x, self.bounds.size.height * 0.85);
}


-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    self.imageView.frame = self.bounds;

}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count -1) {
        self.enterNewFeatureBtn.hidden = NO;
    }else{
        self.enterNewFeatureBtn.hidden = YES;
    }
}

-(void) enter
{
    NKMainViewController *mainVc = [[NKMainViewController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}

@end
