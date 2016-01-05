//
//  NKPlayADView.m
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKPlayADView.h"
#import "NKFocusImgs.h"
#import "NKFocusPost.h"

@interface NKPlayADView()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIImageView *centerImageView;

@property (nonatomic,weak) UIImageView *leftImageView;

@property(nonatomic,weak) UIImageView *rightImageView;

@property (nonatomic,weak) UIPageControl *pageControl;

@property (nonatomic,assign) NSInteger currentImageIndex;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation NKPlayADView


-(instancetype)initWithFrame:(CGRect)frame isAutoPay:(BOOL)isAutoPay timeInterval:(NSTimeInterval)timeInterval
{
    if (self = [super initWithFrame:frame]) {
        self.isAutoPay =isAutoPay;
        self.timeInterval = timeInterval;
        //添加scrollView
        [self addScrollView];
        
        //添加scroolView的三个子控件
        [self AddImageViews];

    }
    return self;
}


-(void)setImages:(NSArray *)images
{
    _images = images;
    if (images.count <= 3) {
        return;
    }
    
    //添加分页控件
    [self addPageControl];

    //设置初始图片
    [self setDefaultImage];
    
    [self reloadImages];
    
    if (self.isAutoPay) {
        [self startTimer];
    }
    
}



/**
 *  @author NK, 15-10-21 10:10:53
 *
 *  设置初始的图片
 */
-(void) setDefaultImage
{
    
    self.centerImageView.image = [self.images firstObject];
    self.leftImageView.image = [self.images lastObject];
    self.rightImageView.image = [self.images objectAtIndex:1];
    self.currentImageIndex = 0;
    self.pageControl.currentPage = self.currentImageIndex;
}

/**
 *  @author NK, 15-10-21 09:10:24
 *
 *  添加三个图像控件
 */
-(void) AddImageViews
{
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    [_scrollView addSubview:leftImageV];
    leftImageV.image = [UIImage imageNamed:@"zhanwei4_3"];
    _leftImageView = leftImageV;
   
    UIImageView *centerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [_scrollView addSubview:centerImageV];
    //由于UIImageVIew没有点击事件 所有给UIimageVIew绑定了一个轻触手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewClick:)];
    centerImageV.userInteractionEnabled = YES;
    [centerImageV addGestureRecognizer:tap];
    centerImageV.image = [UIImage imageNamed:@"zhanwei4_3"];
    _centerImageView = centerImageV;
 
    UIImageView *rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.frame.size.width, 0,self.frame.size.width,self.frame.size.height)];
    _rightImageView = rightImageV;
     rightImageV.image = [UIImage imageNamed:@"zhanwei4_3"];
    
    [_scrollView addSubview:rightImageV];
}


/**
 *  当中间的UIView被点击时触发的事件
 *
 *  @param tap 轻触手势
 */
-(void) ImageViewClick:(UITapGestureRecognizer *)tap
{
    if (self.images == nil) {
        return;
    }
    NSString *linkUrl = @"";
    if ([self.delegate respondsToSelector:@selector(playADView:DidClickImageWebUrl:)]) {
        if ([self.focusArray[self.currentImageIndex] isKindOfClass:[NKFocusImgs class]]) {
             NKFocusImgs *img =self.focusArray[self.currentImageIndex];
            linkUrl = img.newsLink;
        }else if ([self.focusArray[self.currentImageIndex] isKindOfClass:[NKFocusPost class]]){
            NKFocusPost *post = self.focusArray[self.currentImageIndex];
            linkUrl = post.focusLink;
        }
       
        [self.delegate playADView:self DidClickImageWebUrl:linkUrl];
    }
}

/**
 *  @author NK, 15-10-21 09:10:37
 *
 *  添加scrollview
 */
-(void) addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    [self addSubview:scrollView];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //不显示垂直和水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    //设置滚动区域
    scrollView.contentSize = CGSizeMake(3 * width, height);
    scrollView.contentOffset = CGPointMake(width,0);
    //允许分页
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    _scrollView = scrollView;

}

/**
 *  @author NK, 15-10-21 09:10:24
 *
 *  添加分页控件
 */
-(void) addPageControl
{
    UIPageControl *pc = [[UIPageControl alloc] init];
    pc.center = CGPointMake(50, self.scrollView.frame.size.height - 10);
       //设置颜色
    pc.pageIndicatorTintColor = NKRGBColor(193, 219, 255);
    //设置当前页的颜色
    pc.currentPageIndicatorTintColor = NKRGBColor(0, 150, 255);
    //总页数
    pc.numberOfPages = self.images.count;
    [self addSubview:pc];

    self.pageControl = pc;
}


#pragma -----------------UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.images == nil) {
        return;
    }

    [self reloadImages];
    //移动到中间
    [self.scrollView setContentOffset:CGPointMake(NKSCREEN_W, 0) animated:NO];
    //设置分页
    self.pageControl.currentPage=self.currentImageIndex;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reloadImages];
    //移动到中间
    [self.scrollView setContentOffset:CGPointMake(NKSCREEN_W, 0) animated:NO];
    //设置分页
    self.pageControl.currentPage=self.currentImageIndex;
}

//当用户点开始拖拽时停止定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.images == nil) {
        return;
    }
    if (self.timer) {
         [self endTimer];
    }
}

-(void) autoPlay
{
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width  * 2, 0) animated:YES];
}


//用户结束拖拽时开启定时器
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

//开启定时器
-(void) startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

//关闭定时器
-(void) endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  @author NK, 15-10-21 10:10:31
 *
 *  重新加载图片
 */
-(void) reloadImages
{
    NSInteger leftImageIndex = 0;
    NSInteger rightImageIndex = 0;
    CGPoint point = [self.scrollView contentOffset];
    //⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️
    //向右滑动
    if (point.x > NKSCREEN_W) {
        self.currentImageIndex =(self.currentImageIndex+1) % self.images.count;
    }else if(point.x < NKSCREEN_W){
    //向左滑动
        self.currentImageIndex=(self.currentImageIndex+self.images.count-1) % self.images.count;
    }
   
    self.centerImageView.image=[self.images objectAtIndex:self.currentImageIndex];
    
    //重新设置左右图片®
    leftImageIndex=(self.currentImageIndex - 1  + self.images.count) % self.images.count;
    rightImageIndex=(self.currentImageIndex +1) % self.images.count;
     //⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️
    self.leftImageView.image= [self.images objectAtIndex:leftImageIndex];
    self.rightImageView.image=[self.images objectAtIndex:rightImageIndex];
}





@end
