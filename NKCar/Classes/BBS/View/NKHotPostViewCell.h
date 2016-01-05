//
//  NKHotPostViewCell.h
//  NKCar
//
//  Created by J on 15/11/4.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKHostPostModel,NKHotPostViewCell;
@protocol NKHotPostViewCellDelegate <NSObject>
@optional
- (void)moreBtnDidClick:(NKHotPostViewCell *)cell;
- (void)talkBtnDidClick:(NKHotPostViewCell *)cell atPoint:(CGPoint )point;
- (void)forwardBtnDidClick:(NKHotPostViewCell *)cell;
- (void)deleBtnDidClick:(NKHotPostViewCell *)cell;
@end

@interface NKHotPostViewCell : UITableViewCell
/** 数据模型*/
@property (nonatomic,strong)NKHostPostModel *hpModel;
/** 数据模型对应索引*/
@property (nonatomic,assign) NSInteger index;
/** 代理属性*/
@property (nonatomic,weak)id<NKHotPostViewCellDelegate> delegate;
@end
