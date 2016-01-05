//
//  NKLastestViewController.h
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKPlayADView.h"

@interface NKLastestViewController : UIViewController

@property (nonatomic,assign) NSInteger newsOffset;

@property (nonatomic,assign) NSInteger newsCount;

@property (nonatomic,strong) UITableView *tableView;
/**
 *  @author NK, 15-10-22 11:10:45
 *
 *  请求参数
 */
@property (nonatomic,strong) NSMutableDictionary *paraArray;

/**
 *  广告图片
 */
@property (nonatomic,strong) NSMutableArray *focusImages;

/**
 *  新闻列表
 */
@property (nonatomic,strong) NSMutableArray *newsList;

@property (nonatomic,strong) NKPlayADView *playADView;

-(void) setUpHeaderViewFocusImgsWith:(NSArray *)imageArray;


-(void) requestLastestNewsInfo;

-(void) requestMoreNewsInfo;

@end
