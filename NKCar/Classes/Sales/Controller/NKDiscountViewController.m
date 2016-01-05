//
//  NKDiscountViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/30.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKDiscountViewController.h"
#import "NKDiscountInfo.h"
#import "NKNetworkTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NKDiscountViewCell.h"

@interface NKDiscountViewController()


@property (nonatomic,strong) NSArray *discountArray;

@property (nonatomic,strong) NSMutableDictionary *paraDict;

@end

@implementation NKDiscountViewController

-(NSMutableDictionary *)paraDict
{
    if (_paraDict == nil) {
        _paraDict = [NSMutableDictionary dictionary];
        //brandId=0&cityId=347&provinceId=30&seriesId=0&sortType=1
        _paraDict[@"brandId"] = @0;
        _paraDict[@"cityId"] = @347;
        _paraDict[@"provinceId"] = @30;
        _paraDict[@"seriesId"] = @0;
        _paraDict[@"sortType"] = @1;
    }
    return _paraDict;

}



-(NSArray *)discountArray
{
    if (_discountArray == nil) {
        _discountArray = [NSArray array];
    }
    return _discountArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = NKSCREEN_H * 0.2;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestDiscountInfo];
}


-(void) requestDiscountInfo
{
    [[[NKNetworkTool sharedNetworkTool] GET:NKGetDiscountList parameters:self.paraDict success:^ void(NSURLSessionDataTask * __nonnull task, NSDictionary*  __nonnull responseObject) {
        self.discountArray = [NKDiscountInfo objectArrayWithKeyValuesArray:responseObject[@"discountList"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discountArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"discount";
    NKDiscountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NKDiscountViewCell alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.3)];
    }
    cell.backgroundColor = NKRGBColor(235, 233, 236);
    cell.discountInfo = self.discountArray[indexPath.row];
    return cell;
}


@end
