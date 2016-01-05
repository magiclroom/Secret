//
//  NKWaterFlowLayout.h
//  NKCar
//
//  Created by J on 15/11/18.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NKWaterFlowLayout;


@protocol NKWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(NKWaterFlowLayout *)waterflowLayout heightForItemIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;


@optional
- (NSInteger)columnCountInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout;
@end


@interface NKWaterFlowLayout : UICollectionViewLayout
/** 代理*/
@property (nonatomic,weak)id<NKWaterFlowLayoutDelegate> delegate;
@end
