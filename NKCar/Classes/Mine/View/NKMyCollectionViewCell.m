//
//  NKMyCollectionViewCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKMyCollectionViewCell.h"
#import "NKMyCollectionButton.h"
#import "NKMYModel.h"
#import "MJExtension.h"

@interface NKMyCollectionViewCell()

@property (nonatomic,weak) NKMyCollectionButton *collectionButton;

@end

@implementation NKMyCollectionViewCell

-(NKMyCollectionButton *)collectionButton
{
    if (_collectionButton == nil) {
        NKMyCollectionButton *button = [NKMyCollectionButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
         [button.titleLabel sizeToFit];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _collectionButton =button;
    }
    return _collectionButton;
}


-(void)setModel:(NKMYModel *)model
{
    _model = model;
    
    
        [self.collectionButton setTitle:model.title forState:UIControlStateNormal];
        
        [self.collectionButton setImage: [UIImage  imageNamed:model.imageName] forState:UIControlStateNormal];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.collectionButton.frame = CGRectMake(0, 0, self.bounds.size.width * 0.8, self.bounds.size.height * 0.8);
    self.collectionButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}


@end
