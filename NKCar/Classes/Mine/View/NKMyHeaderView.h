//
//  NKMyHeaderView.h
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKMyHeaderView;

@protocol NKMyHeaderViewDelegate <NSObject>

@optional
//点击登录按钮
- (void)loginBtnDidClick:(NKMyHeaderView*)headerV;

@end

@interface NKMyHeaderView : UIView

/** 代理属性*/
@property (nonatomic,weak)id<NKMyHeaderViewDelegate> delegate;

@end
