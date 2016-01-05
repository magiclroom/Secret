
//
//  NKCityPickerView.m
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#define NKSCREEN_W [UIScreen mainScreen].bounds.size.width
#define NKSCREEN_H [UIScreen mainScreen].bounds.size.height
#define NKBorderColor [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0].CGColor

#import "NKCityPickerView.h"
#import "NKSettingCellModel.h"
#import "NKCity.h"

@interface NKCityPickerView() <UIPickerViewDataSource,UIPickerViewDelegate>
/** 城市模型数组*/
@property (nonatomic,strong)NSMutableArray *cities;
/** 当前选定的省份对应的索引*/
@property (nonatomic,assign) NSInteger seltRowIndex;
@property (nonatomic,weak)UIButton *cancelBtn;
@property (nonatomic,weak)UIButton *confirmBtn;
@property (nonatomic,weak)UIPickerView *pickerView;
@property (nonatomic,weak)UIView *bgView;
@end

@implementation NKCityPickerView

- (NSMutableArray *)cities
{
    if (!_cities) {
        _cities = [NSMutableArray array];
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil]];
        
        for (NSDictionary *dict in dictArray) {
            id city = [NKCity cityWithDict:dict];
            [_cities addObject:city];
        }
    }
    return _cities;
}


- (void)awakeFromNib
{
    [self setUPCityPicker];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUPCityPicker];
    }
    return self;
}


- (void)setUPCityPicker
{
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NKSCREEN_H - 250, NKSCREEN_W, 250)];
    bgView.transform = CGAffineTransformMakeTranslation(0, 250);
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];

    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.pickerView = pickerView;
    [bgView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark -数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.cities.count;
    }else {
        NKCity *city = self.cities[_seltRowIndex];
        return city.cities.count;
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NKCity *city = self.cities[row];
        return city.name;
    }else {
        NKCity *city = self.cities[_seltRowIndex];
        return city.cities[row];
    }
}

//选中某一行的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //滚动省会
    if (component == 0) {
        //记录选中省会的角标
        _seltRowIndex = row;
        //刷新第一列
        [pickerView reloadComponent:1];
        //选中第0列的第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    //获取选中的省
    NKCity *city = self.cities[_seltRowIndex];
    //省相对应的城市
    NSArray *cityes = city.cities;
    //获取第一列选中的行
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    //获取城市的名称
    NSString *cityName = cityes[cityIndex];
   
    self.cityName = [NSString stringWithFormat:@"%@-%@",city.name,cityName];
}


//点击cell
- (void)cellDidClick:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
    //取消形变
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        self.bgView.transform = CGAffineTransformIdentity;
        
        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    }];
}

//确定
- (void)confirmBtnClick
{
    if ([_delegate respondsToSelector:@selector(cityConfirmBtnClick:)]) {
        [_delegate cityConfirmBtnClick:self];
    }
}

//取消
- (void)cancelBtnClick
{
    if ([_delegate respondsToSelector:@selector(cityCancelBtnClick:)]) {
        [_delegate cityCancelBtnClick:self];
    }
}


@end
