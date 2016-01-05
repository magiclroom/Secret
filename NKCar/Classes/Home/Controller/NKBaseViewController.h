//
//  NKBaseViewController.h
//  XCar
//
//  Created by 牛康康 on 15/10/23.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKBaseViewController : UIViewController

@property (nonatomic,assign) NSInteger newsOffset;

@property (nonatomic,assign) NSInteger newsCount;

@property (nonatomic,strong) UITableView *tableView;
/**
 *  请求参数
 */
@property (nonatomic,strong) NSMutableDictionary *paraArray;

/**
 *  新闻列表
 */
@property (nonatomic,strong) NSMutableArray *newsList;

-(void) requestLastestNewsInfo;

-(void) requestMoreNewsInfo;

@end
