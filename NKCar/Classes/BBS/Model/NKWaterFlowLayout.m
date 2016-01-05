//
//  NKWaterFlowLayout.m
//  NKCar
//
//  Created by J on 15/11/18.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKWaterFlowLayout.h"

/** 默认的列数 */
static const NSInteger NKDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat NKDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat NKDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets NKDefaultEdgeInsets = {10, 10, 10, 10};


@interface NKWaterFlowLayout()
/** cell布局属性数组*/
@property (nonatomic,strong)NSMutableArray *attrsArray;
/** 所有列当前高度数组*/
@property (nonatomic,strong)NSMutableArray *columnHeights;
/** 内容高度*/
@property (nonatomic,assign) CGFloat contentHeight;

//声明一下。点语法就能调用
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end


@implementation NKWaterFlowLayout


#pragma mark -数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return NKDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return NKDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return NKDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return NKDefaultEdgeInsets;
    }
}

#pragma mark -懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


//初始化
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    //清除之前高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    
    //清除之前布局属性
    [self.attrsArray removeAllObjects];
    //开始创建cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    
}


//cell排布
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSLog(@"%@", self.attrsArray);
    return self.attrsArray;
}


//返回indexPath位置cell对应的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    //collectionView宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
//    NSLog(@"!!!!!!!!!!!%ld",self.columnCount);
    CGFloat h = [self.delegate waterflowLayout:self heightForItemIndex:indexPath.item itemWidth:w];
    
    //找出高度最短一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    
    //判断是不是第一行
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    //更新最短那列高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    
    //记录内容高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    
    return attrs;
}


- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < NKDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}



@end
