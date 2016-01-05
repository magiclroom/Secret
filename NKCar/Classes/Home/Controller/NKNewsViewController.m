//
//  NKNewsViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKNewsViewController.h"
#import "NKNetworkTool.h"
#import "NKNews.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@implementation NKNewsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)requestLastestNewsInfo
{
    self.paraArray[LIMIT] = @30;
    self.paraArray[OFFSET] = @0;
    self.paraArray[TYPE] = @2;
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


@end
