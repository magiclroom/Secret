//
//  NKMyViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKMyViewController.h"
#import "NKMyHeaderView.h"
#import "NKMyCollectionViewCell.h"
#import "NKMYModel.h"
#import "MJExtension.h"
#import "NKLoginViewController.h"
#import "NKMyHeaderLoginFinshView.h"
#import "NKSettingTableViewController.h"



@interface  NKMyViewController()<NKMyHeaderViewDelegate,NKLoginViewControllerDelegate>


@property (nonatomic,weak)NKMyHeaderView *headerView;
@property (nonatomic,weak)NKMyHeaderLoginFinshView *finshHeaderView;

@end

@implementation NKMyViewController

static NSString *ID = @"myCollection";

#pragma mark -初始化
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpHeaderView];
    [self setUPNotification];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[NKMyCollectionViewCell class] forCellWithReuseIdentifier:ID];
}

-(instancetype)init
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(NKSCREEN_W  * 0.25 , NKSCREEN_W  * 0.25);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [self initWithCollectionViewLayout:layout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKMyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSArray *items = @[
                       @{@"title" :@"今日推荐", @"imageName":@"plugin_profile_0"},
                       @{@"title" :@"系统通知", @"imageName":@"plugin_profile_1"},
                       @{@"title" :@"收到的回复", @"imageName":@"plugin_profile_2"},
                       @{@"title" :@"私信", @"imageName":@"plugin_profile_3"},
                       @{@"title" :@"草稿", @"imageName":@"plugin_profile_4"},
                       @{@"title" :@"我的收藏", @"imageName":@"plugin_profile_5"},
                       @{@"title" :@"签到", @"imageName":@"plugin_profile_1"},
                       @{@"title" :@"添加工具", @"imageName":@"plugin_profile_7"},
                       ];
    NSArray *modelArr = [NKMYModel objectArrayWithKeyValuesArray:items];
    NKMYModel *model = modelArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark -操作
//点击登录按钮
- (void)loginBtnDidClick:(NKMyHeaderView *)headerV
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    //创建箭头指定控制器
    NKLoginViewController *login = [board instantiateInitialViewController];
    login.delegate = self;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
}

//登录前头条
-(void) setUpHeaderView
{
    NKMyHeaderView *headerView = [[NKMyHeaderView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.3)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerView = headerView;
}


//登录返回
- (void)loginBtnDidClick:(NKLoginViewController *)loginVC title:(NSString *)title
{
    
    [self.headerView removeFromSuperview];
    [self setUpLoginFinshHeaderView];
    [self.finshHeaderView replaceUserName:title];
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"Mylottery_config.imageset"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    [settingBtn addTarget:self action:@selector(settingBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = settingItem;
    
}

//登录后头条
-(void) setUpLoginFinshHeaderView
{
    NKMyHeaderLoginFinshView *headerView = [[NKMyHeaderLoginFinshView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.3)];
    self.finshHeaderView = headerView;
    [self.view addSubview:headerView];
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
}


//点击设置按钮
- (void)settingBtnDidClick
{
    NKSettingTableViewController *settingTab = [[NKSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingTab animated:YES];

}

//注册通知
- (void)setUPNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyHeaderView) name:@"removeUIView" object:nil];
}
//显示登录前头条
- (void)showMyHeaderView
{
    [self.finshHeaderView removeFromSuperview];
    NKMyHeaderView *headerView = [[NKMyHeaderView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H * 0.3)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
