//
//  NKEventViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKEventViewController.h"
#import "NKEventViewCell.h"
#import "NKEventInfo.h"
#import "NKNetworkTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface NKEventViewController()

@property (nonatomic,strong) NSArray *eventArray;

@end

@implementation NKEventViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
   
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = NKSCREEN_H * 0.55;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self requestEventInfo];

}


-(NSArray *)eventArray
{
    if (_eventArray == nil) {
        _eventArray = [NSArray array];
    }
    return _eventArray;
}


-(void) requestEventInfo
{
    [[[NKNetworkTool sharedNetworkTool] GET:NKGetEventList parameters:nil success:^ void(NSURLSessionDataTask * __nonnull task, NSDictionary*  __nonnull responseObject) {
        self.eventArray = [NKEventInfo objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"event";
    NKEventViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NKEventViewCell alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.5)];
    }
    cell.backgroundColor = NKRGBColor(235, 233, 236);
    cell.eventInfo = self.eventArray[indexPath.row];
    return cell;
}

@end
