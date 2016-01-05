//
//  NKPlayADView.h
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKFocusImgs.h"

@class NKPlayADView;

@protocol NKPlayADViewDelegate <NSObject>

-(void) playADView:(NKPlayADView *) playADView DidClickImageWebUrl:(NSString *) webUrl;

@end


//图片轮播
@interface NKPlayADView : UIView

//是否自动播放
@property (nonatomic,assign) BOOL isAutoPay;
//轮播间隙
@property (nonatomic,assign) NSTimeInterval timeInterval;
//轮播图片
@property (nonatomic,strong) NSArray *images;

@property(nonatomic,strong) NSArray *focusArray;

@property (nonatomic,weak) id<NKPlayADViewDelegate> delegate;

-(instancetype) initWithFrame:(CGRect)frame isAutoPay:(BOOL) isAutoPay timeInterval:(NSTimeInterval)timeInterval;



@end
