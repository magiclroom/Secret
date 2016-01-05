//
//  NKSettingTableViewController.m
//  NKCar
//
//  Created by J on 15/11/7.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKSettingTableViewController.h"
#import "NKSettingModels.h"
#import "MJExtension.h"
#import "NKUserInfoTableViewController.h"
#import "NKAboutTableViewController.h"
#import "NKSettingClearTableViewCell.h"
#import "NKMessageViewController.h"


@interface NKSettingTableViewController ()
/** 模型数组*/
@property (nonatomic,strong)NSArray *modelArray;
@end

@implementation NKSettingTableViewController

static NSString * const clearCellID = @"clearCache";
static NSString * const otherCellID = @"other";

//修改表样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUPNavigationBar];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    
    [self.tableView registerClass:[NKSettingClearTableViewCell class] forCellReuseIdentifier:clearCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:otherCellID];
    
    // 设置内边距(-25代表：所有内容往上移动25)
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (NSArray *)modelArray
{
    if (!_modelArray) {
        NSArray *dictArray = @[
                               @[@{@"image":@"More_LotteryRecommend",@"title":@"用户"},
                                 ],
                               
                                @[@{@"image":@"handShake",@"title":@"验证"},
                                  @{@"image":@"MoreShare",@"title":@"分享"},
                                  ],
                                
                                @[@{@"image":@"MorePush",@"title":@"允许推送"},
                                  @{@"image":@"MoreHelp",@"title":@""},
                                  @{@"image":@"MoreAbout",@"title":@"关于"},
                                  ],
                                ];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSArray *arr in dictArray) {
            NSArray *model = [NKSettingModels objectArrayWithKeyValuesArray:arr];
            [modelArray addObject:model];
        }
        _modelArray = modelArray;
    }
    return _modelArray;
}


//导航栏
- (void)setUPNavigationBar
{
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [exitBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [exitBtn sizeToFit];
    //内边距，向左偏移
    exitBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
     self.tabBarController.tabBar.hidden = YES;
}
//点击返回按钮
- (void)exit
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - Table view data source
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *modelArray = self.modelArray[section];
    return modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 1) {
        
        NKSettingClearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCellID];
        cell.imageView.image = [UIImage imageNamed:@"MoreHelp"];
        return cell;
        
    }else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *modelArray = self.modelArray[indexPath.section];
        NKSettingModels *model = modelArray[indexPath.row];
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.accessoryView = [[UISwitch alloc] init];
        }
        cell.textLabel.text = model.title;
        cell.imageView.image = [UIImage imageNamed:model.image];
        return cell;
    }

}

//点击cell跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0) {
        
        NKUserInfoTableViewController *user = [[NKUserInfoTableViewController alloc]init];
        [self.navigationController pushViewController:user animated:YES];
    
    
    
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //验证
            NKMessageViewController *message = [[NKMessageViewController alloc] init];
            [self.navigationController pushViewController:message animated:YES];
        }else {
            //分享
        }
    
    }else {
    
        if (indexPath.row == 0) {
            //推送
        }else if (indexPath.row == 1) {
            //缓存
        }else {
            NKAboutTableViewController *about = [[NKAboutTableViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
        }
    }
    
}

@end
