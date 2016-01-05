//
//  NKWeiBoEditViewController.h
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKWeiBoEditViewController,NKTextView;
@protocol NKWeiBoEditViewControllerDelegate <NSObject>
@optional
- (void)sendBtnDidClick:(NKWeiBoEditViewController *)weiboVC addDict:(NSMutableDictionary *)dict;
@end

@interface NKWeiBoEditViewController : UIViewController
//@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,weak)NSString *pictureName;
@property (nonatomic,strong)NKTextView *weiboTextView;
@property (nonatomic,weak)UILabel *text_label;
/** 代理属性*/
@property (nonatomic,weak)id<NKWeiBoEditViewControllerDelegate> delegate;
@end
