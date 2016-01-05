//
//  NKSettingTableHeaderView.h
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKUserInfoTableHeaderView;
@protocol NKUserInfoTableHeaderViewDelegate <NSObject>
@optional
//点击头像编辑
- (void)editBtnDidClick:(NKUserInfoTableHeaderView *)headerView;
@end

@interface NKUserInfoTableHeaderView : UIView
/** 代理属性*/
@property (nonatomic,weak)id<NKUserInfoTableHeaderViewDelegate> delegate;
/** 头像*/
@property (nonatomic,weak)UIImageView *iconView;
@end
