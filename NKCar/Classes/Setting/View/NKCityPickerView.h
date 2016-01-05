//
//  NKCityPickerView.h
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKCityPickerView;
@protocol NKCityPickerViewDelegate <NSObject>
@optional
- (void)cityConfirmBtnClick:(NKCityPickerView *)CityPickerView;
- (void)cityCancelBtnClick:(NKCityPickerView *)CityPickerView;
@end


@interface NKCityPickerView : UIView
/** 城市名称*/
@property (nonatomic,copy)NSString *cityName;
//点击cell
- (void)cellDidClick:(UITableView *)tableView index:(NSIndexPath *)indexPath;
/** 代理属性*/
@property (nonatomic,weak)id<NKCityPickerViewDelegate> delegate;
@end
