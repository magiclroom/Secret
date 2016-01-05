//
//  NKBrandCell.h
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKBrand;

@interface NKBrandCell : UITableViewCell

@property (nonatomic,strong) NKBrand *brand;

-(instancetype) initWithTableView:(UITableView *)tableView;

@end
