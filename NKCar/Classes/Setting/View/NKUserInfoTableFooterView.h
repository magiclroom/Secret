//
//  NKUserInfoTableFooterView.h
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKUserInfoTableFooterView;
@protocol NKUserInfoTableFooterViewDelegate <NSObject>
@optional
//点击头像编辑
- (void)quitBtnDidClick:(NKUserInfoTableFooterView *)footerView;
@end

@interface NKUserInfoTableFooterView : UIView
/** 代理属性*/
@property (nonatomic,weak)id<NKUserInfoTableFooterViewDelegate> delegate;

@end
