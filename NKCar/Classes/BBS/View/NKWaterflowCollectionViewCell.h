//
//  NKWaterflowCollectionViewCell.h
//  NKCar
//
//  Created by J on 15/11/18.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKWaterflowPicture,NKWaterflowCollectionViewCell;
@protocol NKWaterflowCollectionViewCellDelegate <NSObject>
@optional
- (void)imageViewClick:(NKWaterflowCollectionViewCell *)cell withImageView:(UIImageView *)imageView withImagePath:(NSString *)picturePath;
@end

@interface NKWaterflowCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)NKWaterflowPicture *picture;
@property (nonatomic,weak)id<NKWaterflowCollectionViewCellDelegate> delegate;
@end
