//
//  NKMainViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/19.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKMainViewController.h"
#import "NKAdManager.h"
#import "NKEventViewController.h"
#import  "WMPageController.h"
#import "NKGuideViewController.h"
#import "NKLastestViewController.h"
#import "NKMeasureViewController.h"
#import "NKNewsViewController.h"
#import "NKVideoViewController.h"
#import "NKSelectionViewController.h"
#import "NKHotPostViewController.h"
#import "NKWaterflowController.h"
#import "NKFindBrandCarViewController.h"
#import "NKTabBar.h"
#import "NKMyViewController.h"
#import "NKDiscountViewController.h"
#import "NKNavigationController.h"
#import "NKADView.h"



@interface NKMainViewController ()<NKTabBarDelegate>


@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation NKMainViewController

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
#pragma mark -初始化

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBar.backgroundColor = [UIColor clearColor];
    
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[NKTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAdView];
    [self setUpMainController];
    [self setUPNotification];
    [self setUPTabBar];
    [self setUPData];
}

#pragma mark -通知
- (void)setUPNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabBarBtn) name:@"removeUIView" object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)removeTabBarBtn
{
    for (UIView *btn in self.tabBar.subviews) {
        if ([@"UITabBarButton" isEqualToString:NSStringFromClass([btn class])]) {
            [btn removeFromSuperview];
        }
    }
}


#pragma mark ------------NKTabBarDelegate
-(void)tabBar:(NKTabBar *)tabbar didClick:(NSInteger)index
{
    self.selectedIndex = index;
}

//写入数据
- (void)setUPData
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *fullPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filename=[fullPath stringByAppendingPathComponent:@"statuses.plist"];
    if (![manager fileExistsAtPath:filename]) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"plist"];
        NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        [dataArray writeToFile:filename atomically:YES];

    }
}

- (void)setUPTabBar
{
    NKTabBar *tabBar = [[NKTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.delegate = self;
    tabBar.items = self.items;
    [self.tabBar addSubview:tabBar];
}

//设置启动的广告内容
-(void) setUpAdView
{
    //向服务器请求最新的广告图
    [NKAdManager loadLatestAdImage];
    //判断是否有广告显示
    if ([NKAdManager shouldShowAdImage]) {
    NKADView *adView = [[NKADView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:adView];
    }
}

-(void) setUpMainController
{
    
    //首页
    NSArray *indexTitleArray = @[@"最新",@"新闻",@"视频",@"评测",@"导购"];
    NSMutableArray *indexControllerArray = [NSMutableArray array];
    WMPageController *indexPageController =[[WMPageController alloc] init];
    [indexControllerArray addObject:[NKLastestViewController class]];
    [indexControllerArray addObject:[NKNewsViewController class]];
    [indexControllerArray addObject:[NKVideoViewController class]];
    [indexControllerArray addObject:[NKGuideViewController class]];
    [indexControllerArray addObject:[NKMeasureViewController class]];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [indexPageController.navigationItem setBackBarButtonItem:item];
    
    NKNavigationController *indexCtr = [self setUpChildContorller:indexPageController withTitleArray:indexTitleArray controllerArray:indexControllerArray image:@"tab_shouye_baitian" selectedImage:@"tab_shouye_baitian_hit" title:@"首页" width :66];

     [self addChildViewController:indexCtr];
    
    
    //论坛
    NSArray *bbsTitleArray = @[@"主页",@"热帖",@"图流"];
    NSMutableArray *bbsControllerArray = [NSMutableArray array];
    WMPageController *bbsPageController =[[WMPageController alloc] init];
    [bbsControllerArray addObject:[NKSelectionViewController class]];
    [bbsControllerArray addObject:[NKHotPostViewController class]];
    [bbsControllerArray addObject:[NKWaterflowController class]];
    
    [bbsPageController.navigationItem setBackBarButtonItem:item];
    
    
    NKNavigationController *bbsCtr = [self setUpChildContorller:bbsPageController withTitleArray:bbsTitleArray controllerArray:bbsControllerArray image:@"tab_luntan_baitian" selectedImage:@"tab_luntan_baitian_hit" title:@"论坛" width :66];
    [self addChildViewController:bbsCtr];
    
    
    
    //找车
    NSArray *carTitleArray = @[@"品牌选车",@"条件选车"];
    NSMutableArray *carControllerArray = [NSMutableArray array];
    WMPageController *carPageController =[[WMPageController alloc] init];
    [carControllerArray addObject:[NKFindBrandCarViewController class]];
    [carControllerArray addObject:[NKNewsViewController class]];
    [carPageController.navigationItem setBackBarButtonItem:item];
    NKNavigationController *carCtr = [self setUpChildContorller:carPageController withTitleArray:carTitleArray controllerArray:carControllerArray image:@"tab_zhaoche_baitian" selectedImage:@"tab_zhaoche_baitian_hit" title:@"找车" width :88];
    [self addChildViewController:carCtr];
    
    
    //降价
    NSArray *reducePriceTitleArray = @[@"降价",@"活动",@"车有惠" ,@"我报名的"];
    NSMutableArray *reducePriceControllerArray = [NSMutableArray array];
    WMPageController *reducePricePageController =[[WMPageController alloc] init];
    [reducePricePageController.navigationItem setBackBarButtonItem:item];
    [reducePriceControllerArray addObject:[NKDiscountViewController class]];
    [reducePriceControllerArray addObject:[NKEventViewController class]];
    [reducePriceControllerArray addObject:[NKNewsViewController class]];
    [reducePriceControllerArray addObject:[NKNewsViewController class]];
    NKNavigationController *reducePriceCtr = [self setUpChildContorller:reducePricePageController withTitleArray:reducePriceTitleArray controllerArray:reducePriceControllerArray image:@"tab_jiangjia_baitian" selectedImage:@"tab_jiangjia_baitian_hit" title:@"降价" width :88];
    [self addChildViewController:reducePriceCtr];

    
    //中部按钮控制器
    NKMyViewController *myVc = [[NKMyViewController alloc] init];
    NKNavigationController *myNavCtr = [[NKNavigationController alloc] init];
    [myNavCtr pushViewController:myVc animated:NO];
    [self addChildViewController:myNavCtr];
   
    
 
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(NKNavigationController *) setUpChildContorller:(WMPageController *) controller withTitleArray:(NSArray *)titleArray controllerArray:(NSArray *)controllerArray image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title width:(CGFloat)width
{
    controller.menuViewStyle = WMMenuViewStyleLine;
    controller.menuItemWidth = width;
    controller.titleColorNormal = NKRGBColor(45, 48, 53);
    controller.titleColorSelected = NKRGBColor(63, 169, 213);
    controller.postNotification = YES;
    controller.titles = titleArray;
    controller.viewControllerClasses = controllerArray;
    NKNavigationController *nav = [[NKNavigationController alloc] initWithRootViewController:controller];
    [controller.navigationController setNavigationBarHidden:YES];
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.title = title;
    [self.items addObject:nav.tabBarItem];
    return nav;
}



@end
