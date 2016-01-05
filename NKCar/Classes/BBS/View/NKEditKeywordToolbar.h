//
//  NKKeywordToolbar.h
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NKEditKeywordToolbar;
@protocol NKEditKeywordToolbarDelegate <NSObject>
@optional
- (void)editWithPhotoBtnDidClick:(NKEditKeywordToolbar *)toolbar;
- (void)editWithExitBtnDidClick:(NKEditKeywordToolbar *)toolbar;
@end

@interface NKEditKeywordToolbar : UIToolbar

/** 代理属性*/
@property (nonatomic,weak)id<NKEditKeywordToolbarDelegate> delegateToolbar;

@end
