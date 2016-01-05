//
//  NKBaseViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/23.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKBaseViewController.h"
#import "NKCircleButton.h"
#import "NKNetworkTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NKNews.h"
#import "NKNewsCell.h"
#import "NKWebViewController.h"



@interface NKBaseViewController()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation NKBaseViewController

-(NSMutableArray *)newsList
{
    if (_newsList == nil) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setUpPullingRefresh];
    
    [self setUpDraggingRefresh];
    
}

/**
 *  设置tableview
 */
-(void) setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, NKSCREEN_W, NKSCREEN_H) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = 90;
}



/**
 *  设置tableView下拉刷新
 */
-(void) setUpPullingRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestLastestNewsInfo)];
    // 设置普通状态的动画图片
    NSArray *idleImages = [NSArray arrayWithObject:[UIImage imageNamed:@"load_1"]];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSArray *pullingImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"load_1"], nil];
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    NSArray *refreshingImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"load_1"],[UIImage imageNamed:@"load_2"],[UIImage imageNamed:@"load_3"],[UIImage imageNamed:@"load_4"], nil];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    
    
}

/**
 *  设置上拉刷新
 */
-(void) setUpDraggingRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreNewsInfo)];
}


/**
 *  @author NK, 15-10-22 10:10:47
 *
 *  向服务器请求更多新闻信息
 *  http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=1&ver=6.2.2
 */
-(void) requestMoreNewsInfo
{
    self.newsCount +=NewsCount;
    NKNetworkTool *tool = [NKNetworkTool sharedNetworkTool];
    self.paraArray[LIMIT] = @10;
    self.paraArray[OFFSET] = @(self.newsCount);
    [[tool GET:NKGetNewsList parameters:self.paraArray success:^ void(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        
        NSMutableArray *newsArray = [NKNews objectArrayWithKeyValuesArray:responseObject[@"newsList"]];
       
        for (NKNews *news in newsArray) {
            if (news.newsType == 2) {
                [self.newsList addObject:news];
            }
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
    
}

/**
 *  @author NK, 15-10-22 11:10:20
 *
 *  向服务器请求最近的N条新闻数据
 */
-(void) requestLastestNewsInfo
{
    self.paraArray[LIMIT] = @30;
    self.paraArray[OFFSET] = @0;
    [[[NKNetworkTool sharedNetworkTool] GET:NKGetNewsList parameters:self.paraArray success:^ void(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        
        self.newsList = nil;
        NSMutableArray *newsArray = [NKNews objectArrayWithKeyValuesArray:responseObject[@"newsList"]];
        for (NKNews *news in newsArray) {
            if (news.newsType == 2) {
                [self.newsList addObject:news];
            }
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
}


/**
 *  @author NK, 15-10-22 11:10:38
 *
 *  向服务器请求的参数信息
 */
-(NSMutableDictionary *)paraArray
{
    if (_paraArray == nil) {
        _paraArray = [NSMutableDictionary  dictionary];
        _paraArray[LIMIT] = @30;
        _paraArray[TYPE] = @1;
        _paraArray[OFFSET] = @0;
        _paraArray[VERSION] = @"6.2.2";
    }
    return _paraArray;
}

#pragma mark -----------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NKNewsCell *cell = [[NKNewsCell alloc] init];
    cell.news = self.newsList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NKWebViewController *wbController = [[NKWebViewController alloc] init];
    NKNews *news = self.newsList[indexPath.row];
    wbController.webUrl = news.newsLink;
    
    [self.navigationController pushViewController:wbController animated:YES];
}
@end

