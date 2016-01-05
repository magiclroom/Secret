//
//  NKTalkKeywordToolbar.h
//  NKCar
//
//  Created by J on 15/11/17.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKTalkKeywordToolbar;
@protocol NKTalkKeywordToolbarDelegate <NSObject>
@optional
- (void)talkWithsendBtnDidClick:(NKTalkKeywordToolbar *)toolbar;
- (void)talkWithexitBtnDidClick:(NKTalkKeywordToolbar *)toolbar;
@end

@interface NKTalkKeywordToolbar : UIToolbar
/** 输入框*/
@property (nonatomic,weak)UITextField *inputField;
/** 代理属性*/
@property (nonatomic,weak)id<NKTalkKeywordToolbarDelegate> delegateToolbar;


@end
