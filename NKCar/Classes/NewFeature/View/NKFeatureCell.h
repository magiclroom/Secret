//
//  NKFeatureCell.h
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKFeatureCell : UICollectionViewCell

@property(nonatomic,strong) UIImage *image;

-(void) setIndexPath:(NSIndexPath *)indexPath count:(int) count;

@end
