//
//  NKTabBar.h
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKTabBar;
@protocol NKTabBarDelegate <NSObject>

@optional

-(void) tabBar:(NKTabBar *)tabbar didClick:(NSInteger)index;

@end

//自定义tabbar
@interface NKTabBar : UIView

@property (nonatomic,strong) NSArray *items;

@property (weak,nonatomic) id<NKTabBarDelegate> delegate;


@end
