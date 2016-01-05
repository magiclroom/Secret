//
//  NKTabBar.m
//  XCar
//
//  Created by 牛康康 on 15/10/20.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKTabBar.h"
#import "NKCircleButton.h"
#import "NKTabBarButton.h"

@interface NKTabBar()

@property (nonatomic,weak) NKCircleButton *centerBtn;

@property (nonatomic,weak) UIView *shadeView;

@property (nonatomic,weak) UIButton *selectedBtn;

@end

@implementation NKTabBar

-(void)setItems:(NSArray *)items
{
    _items = items;
    NSInteger index = 0;
    for (UITabBarItem *item in items) {
        //设置的按钮的属性(字体、图像等)
        if(item.title == nil){
            return;
        }
        NKTabBarButton *button = [NKTabBarButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:item.selectedImage forState:UIControlStateSelected];
        [button.titleLabel setTextColor:[UIColor blackColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:8];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchDown];
        button.tag = index;
        //默认选择第一个
        if (index == 0) {
            self.selectedBtn = button;
            self.selectedBtn.selected = YES;
        }
        index ++;
        [self addSubview:button];
    }
}



-(void) tabBtnClick:(UIButton *)sender
{
    //判断如果是按同一按钮的话不做处理
    if (sender == self.selectedBtn) {
        return;
    }
    self.centerBtn.layer.borderColor = [UIColor grayColor].CGColor;
        //重新复制新的选中的按钮
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
    [self.selectedBtn setTitleColor:NKRGBColor(73, 177, 225) forState:UIControlStateSelected];
    
    //如果点击的是非中间按钮 并且原来选中的是中间的按钮 先降背景层移除
    if ([self.selectedBtn isKindOfClass:[NKCircleButton class]]) {
        self.shadeView.hidden = NO;
        self.selectedBtn.layer.borderColor = [UIColor grayColor].CGColor;
         sender.layer.borderColor = NKRGBColor(73, 177, 225).CGColor;
    }else{
        self.shadeView.hidden = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClick:)]) {
        [self.delegate tabBar:self didClick:sender.tag];
    }



}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0 , self.frame.size.height , self.frame.size.height)];
        bgView.layer.cornerRadius = bgView.frame.size.width * 0.5;
        bgView.backgroundColor =NKRGBColor(73, 177, 225);
        bgView.clipsToBounds = YES;
        bgView.alpha = 0.4;
        [self addSubview:bgView];
        CGPoint centerPoint = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        bgView.center = centerPoint;
        bgView.hidden = YES;
        
        _shadeView = bgView;
        NKCircleButton *centerBtn = [[NKCircleButton alloc] initWithFrame:CGRectMake(0, 0 , self.frame.size.height-10, self.frame.size.height -10)];
        centerBtn.center = centerPoint;
        centerBtn.tag = 4;
        [centerBtn addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:centerBtn];
        _centerBtn = centerBtn;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableArray *framexArray = [NSMutableArray array];
    NSInteger index = 0;
    CGFloat margin = (self.centerBtn.center.x - 2 * self.bounds.size.height) / 3.0 - 10;
    for (NKTabBarButton *btn in self.subviews) {
        if ([btn isKindOfClass:[NKTabBarButton class]]) {
            if (index == 2) {
                  btn.frame = CGRectMake(0, 0,self.bounds.size.height, self.bounds.size.height);
                  btn.center = CGPointMake(self.centerBtn.center.x - [framexArray[1] floatValue]+ self.centerBtn.center.x, self.center.y);
            }else if(index == 3){
                btn.frame = CGRectMake(0, 0,self.bounds.size.height, self.bounds.size.height);
                btn.center = CGPointMake(self.centerBtn.center.x - [framexArray[0] floatValue]+ self.centerBtn.center.x, self.center.y);

            }else{
                btn.frame = CGRectMake( (index+1) * margin + index * self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
                [framexArray addObject:@(btn.center.x)];

            }
            index++;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelSelectBtn) name:@"cancelSelectBtn" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cancelSelectBtn
{
    self.centerBtn.selected = YES;
}



@end