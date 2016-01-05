//
//  NKNewFeatureViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKNewFeatureViewController.h"
#import "NKFeatureCell.h"


@interface  NKNewFeatureViewController()

@property (nonatomic,weak) UIPageControl *pageControl;

@end


@implementation NKNewFeatureViewController
static NSString *ID = @"feature";
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.collectionView registerClass:[NKFeatureCell class] forCellWithReuseIdentifier:ID];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.pageControl.numberOfPages = 3;
    self.pageControl.center = CGPointMake(self.view.frame.size.width * 0.5 , self.view.frame.size.height - 20);
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self.view addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return _pageControl;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;

    self.pageControl.currentPage = page;
}


-(instancetype)init
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(NKSCREEN_W, NKSCREEN_H);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:layout];
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSString *featureName = [NSString stringWithFormat:@"feature%ld",indexPath.row + 1];
    cell.image = [UIImage imageNamed:featureName];
    [cell setIndexPath:indexPath count:3];
    return cell;
}



@end
