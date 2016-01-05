//
//  NKDatePickerView.m
//  NKCar
//
//  Created by J on 15/11/11.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#define NKSCREEN_W [UIScreen mainScreen].bounds.size.width
#define NKSCREEN_H [UIScreen mainScreen].bounds.size.height
#define NKBorderColor [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0].CGColor

#import "NKDatePickerView.h"
#import "NKSettingCellModel.h"

@interface NKDatePickerView()



@property (nonatomic,weak)UIButton *cancelBtn;
@property (nonatomic,weak)UIButton *confirmBtn;
@property (nonatomic,weak)UIView *bgView;
@end


@implementation NKDatePickerView

- (void)awakeFromNib
{
    [self setUPDatePicker];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUPDatePicker];
    }
    return self;
}


- (void)setUPDatePicker
{


    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NKSCREEN_H - 250, NKSCREEN_W, 250)];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    bgView.transform = CGAffineTransformMakeTranslation(0, 250);
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    datePicker.datePickerMode = UIDatePickerModeDate;
    //地区
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [bgView addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right);
        make.top.equalTo(self.bgView.mas_top);
        make.left.equalTo(self.bgView.mas_left);
        make.height.mas_equalTo(214);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn = cancelBtn;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:NKBlueColor forState:UIControlStateNormal];
    cancelBtn.layer.borderColor = NKBorderColor;
    cancelBtn.layer.borderWidth = 1;
    [bgView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-1);
        make.width.mas_equalTo(NKSCREEN_W * 0.5);
        make.height.mas_equalTo(35);
    }];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn = confirmBtn;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:NKBlueColor forState:UIControlStateNormal];
    confirmBtn.layer.borderColor = NKBorderColor;
    confirmBtn.layer.borderWidth = 1;
    [bgView addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-1);
        make.width.mas_equalTo(NKSCREEN_W * 0.5);
        make.height.mas_equalTo(35);
    }];
}


//点击cell
- (void)cellDidClick:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
      
        self.bgView.transform = CGAffineTransformIdentity;
    }];
    
}

//确定
- (void)confirmBtnClick
{
    if ([_delegate respondsToSelector:@selector(dateConfirmBtnClick:)]) {
        [_delegate dateConfirmBtnClick:self];
    }
}

//取消
- (void)cancelBtnClick
{
    if ([_delegate respondsToSelector:@selector(dateCancelBtnClick:)]) {
        [_delegate dateCancelBtnClick:self];
    }
}

@end
