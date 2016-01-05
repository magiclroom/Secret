//
//  NKNewsCell.h
//  XCar
//
//  Created by 牛康康 on 15/10/22.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKNews;

@interface NKNewsCell : UITableViewCell

@property(nonatomic,strong) NKNews *news;

+(instancetype) newsCellWithTableView:(UITableView *)tableView;

@end
