//
//  NKFindBrandCarViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/26.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKFindBrandCarViewController.h"
#import "NKNetworkTool.h"
#import "NKBrand.h"
#import "NKBrandGroup.h"
#import "NKBrandCell.h"
#import "NKFindCarHeaderView.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface NKFindBrandCarViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) UITableView *tableView;

//参数信息
@property (nonatomic,strong) NSMutableDictionary *paraArray;

//所有汽车品牌信息的数组
@property (nonatomic,strong) NSArray *brandsArray;

@property(nonatomic,weak) NKFindCarHeaderView *headerView;

@end


@implementation NKFindBrandCarViewController

-(NSArray *)brandsArray
{
    if (_brandsArray == nil) {
        _brandsArray = [NSArray array];
    }
    return _brandsArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tv.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 23;
    self.tableView.rowHeight = 60;
    self.tableView.sectionIndexColor = [UIColor grayColor];
    NKFindCarHeaderView *headerView = [[NKFindCarHeaderView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.2)];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    [self requestLastestBrandsInfo];
    [self requestSalesInfo];
}


#pragma mark --------------- UITableViewDataSource   UITableViewDelegate

//设置索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *section = [NSMutableArray array];
    for (NKBrandGroup *group in self.brandsArray) {
        [section addObject:[group.letter uppercaseString]];
    }
    return section;
}

//设置每组数组的头部
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NKBrandGroup *group = self.brandsArray[section];
    return [group.letter uppercaseString];
}

//返回多少组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.brandsArray.count;
}
//返回每组数据的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NKBrandGroup *group = self.brandsArray[section];
    return group.brands.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NKBrandCell *cell = [[NKBrandCell alloc] initWithTableView:tableView];
  
    NKBrandGroup *group = self.brandsArray[indexPath.section];
    NKBrand *brand = group.brands[indexPath.row];
    cell.brand = brand;
    return cell;
}

//请求获取所有的汽车品牌信息
-(void) requestLastestBrandsInfo
{
    [[[NKNetworkTool sharedNetworkTool] GET:NKGetAllCarBrands parameters:nil success:^ void(NSURLSessionDataTask * __nonnull task, NSDictionary*  __nonnull responseObject) {
        self.brandsArray = [NKBrandGroup objectArrayWithKeyValuesArray:responseObject[@"letters"]];
        [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
           
    }] resume];
}

-(void) requestSalesInfo
{
    [[[NKNetworkTool sharedNetworkTool] GET:NKGetCarSales parameters:nil success:^ void(NSURLSessionDataTask * __nonnull task, NSDictionary*  __nonnull responseObject) {
        self.headerView.salesCar = [NKSalesCar objectWithKeyValues:responseObject];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];


}



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


@end
