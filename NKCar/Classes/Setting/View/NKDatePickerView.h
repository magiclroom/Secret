//
//  NKDatePickerView.h
//  NKCar
//
//  Created by J on 15/11/11.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKDatePickerView;
@protocol NKDatePickerViewDelegate <NSObject>
@optional
- (void)dateConfirmBtnClick:(NKDatePickerView *)datePickerView;
- (void)dateCancelBtnClick:(NKDatePickerView *)datePickerView;
@end


@interface NKDatePickerView : UIView
@property (nonatomic,weak)UIDatePicker *datePicker;
//点击cell
- (void)cellDidClick:(UITableView *)tableView index:(NSIndexPath *)indexPath;
/** 代理属性*/
@property (nonatomic,weak)id<NKDatePickerViewDelegate> delegate;

@end
