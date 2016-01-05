//
//  NKTableViewController.m
//  NKCar
//
//  Created by J on 15/11/10.
//  Copyright (c) 2015年 jay. All rights reserved.
//


#import "NKUserInfoTableViewController.h"
#import "NKSettingTableViewCell.h"
#import "NKSettingCellModel.h"
#import "MJExtension.h"

#import "TYAlertController.h"
#import "UIView+TYAlertView.h"
#import "NKDatePickerView.h"
#import "NKMyViewController.h"
#import "NKUserInfoTableHeaderView.h"
#import "NKUserInfoTableFooterView.h"
#import "NKCityPickerView.h"
#import "MBProgressHUD+NK.h"

@interface NKUserInfoTableViewController ()<NKDatePickerViewDelegate,NKUserInfoTableHeaderViewDelegate,NKUserInfoTableFooterViewDelegate,NKCityPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 模型数组*/
@property (nonatomic,strong)NSArray *modelArray;
/** 日期*/
@property (nonatomic,strong) UIDatePicker *datePicker;
/*日期View**/
@property (nonatomic,strong) NKDatePickerView *datePickerView;
/** 城市View*/
@property (nonatomic,weak)NKCityPickerView *cityPickerView;
/** 蒙版*/
@property (nonatomic,weak)UIView *popmenuView;
/** 日期位置*/
@property (nonatomic,strong)NSIndexPath *dateIndexPath;
/** 城市位置*/
@property (nonatomic,weak)NSIndexPath *cityIndexPath;
/** 选中的生日cell*/
@property (nonatomic,weak)UITableViewCell *dateSelectCell;
/** 选中的城市cell*/
@property (nonatomic,weak)UITableViewCell *citySelectCell;
/** 表头*/
@property (nonatomic,weak)NKUserInfoTableHeaderView *headerView;

@end

@implementation NKUserInfoTableViewController
static NSString *ID = @"cell";
#pragma mark -懒加载
- (NSArray *)modelArray
{
    if (!_modelArray) {
        NSArray *dictArray = @[
                               
                               @[
                                   @{@"leftTitle":@"用户名:",@"rightTitle":@"NK"},
                                   @{@"leftTitle":@"性别:",@"rightTitle":@"男"},
                                   @{@"leftTitle":@"地区:",@"rightTitle":@"河南-鹿邑"},
                                   @{@"leftTitle":@"生日:",@"rightTitle":@"0000-00-00"},
                                   @{@"leftTitle":@"手机:",@"rightTitle":@"114"},
                                   ],
                               
                               @[
                                   @{@"leftTitle":@"注册时间",@"rightTitle":@"2015-1-1"},
                                   @{@"leftTitle":@"级别",@"rightTitle":@"新手上路"},
                                   ],
                               
                               ];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSArray *arr in dictArray) {
            NSArray *model = [NKSettingCellModel objectArrayWithKeyValuesArray:arr];
            [modelArray addObject:model];
        }
        _modelArray = modelArray;
    }
    return _modelArray;
}

#pragma mark -初始化
//表样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUPHeaderView];
    [self setUPFooterView];
    self.navigationItem.title = @"个人资料";
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NKSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

//表头
- (void)setUPHeaderView
{
    NKUserInfoTableHeaderView *headerView = [[NKUserInfoTableHeaderView alloc] init];
    self.headerView = headerView;
    headerView.frame = CGRectMake(0, 0, 140, 140);
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
}

//退出登录按钮
- (void)setUPFooterView
{
    NKUserInfoTableFooterView *footerView = [[NKUserInfoTableFooterView alloc] init];
    footerView.frame = CGRectMake(0, 0, NKSCREEN_W, 100);
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *model = self.modelArray[section];
    return model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NKSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 1 || indexPath.row == 4) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *modelArray = self.modelArray[indexPath.section];
    NKSettingCellModel *model = modelArray[indexPath.row];
    cell.cellModel = model;
    
    return cell;
    
}

#pragma mark -操作

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                
            case 0:
                [self userNameDidClick:indexPath];
                break;
                
            case 1:
                [self sexDidClick:indexPath];
                break;
                
            case 2:
                [self addressDidClick:indexPath];
                break;
                
            case 3:
                [self birthdayDidClick:indexPath];
                break;
            
        }
    }
}

//用户名
- (void)userNameDidClick:(NSIndexPath *)indexPath
{
   
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"修改昵称" message:@"您有一次修改昵称的机会"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSArray *modelArray = self.modelArray[indexPath.section];
        NKSettingCellModel *model = modelArray[indexPath.row];
        model.rightTitle = ((UITextField *)[alertView.textFieldArray firstObject]).text;
          [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }]];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入要修改的昵称";
    }];
    // first way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
}

//性别
- (void)sexDidClick:(NSIndexPath *)indexPath
{
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"性别" message:@"请选择男神还是女神"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"男" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        NSArray *modelArray = self.modelArray[indexPath.section];
        NKSettingCellModel *model = modelArray[indexPath.row];
        model.rightTitle = action.title;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"女" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSArray *modelArray = self.modelArray[indexPath.section];
        NKSettingCellModel *model = modelArray[indexPath.row];
        model.rightTitle = action.title;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {

    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

//地区
- (void)addressDidClick:(NSIndexPath *)indexPath
{
    NKCityPickerView *cityPickerView = [[NKCityPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cityPickerView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:cityPickerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityCancelBtnClick:)];
    [cityPickerView addGestureRecognizer:tap];
    self.cityPickerView = cityPickerView;
    self.cityIndexPath = indexPath;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.userInteractionEnabled = NO;
    self.citySelectCell = cell;
    [cityPickerView cellDidClick:self.tableView index:indexPath];

}

//地区确定按钮
- (void)cityConfirmBtnClick:(NKCityPickerView *)CityPickerView
{
    NSArray *models = self.modelArray[self.cityIndexPath.section];
    NKSettingCellModel *model = models[self.cityIndexPath.row];
    model.rightTitle = self.cityPickerView.cityName;
    [self.tableView reloadRowsAtIndexPaths:@[self.cityIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.cityPickerView.transform = CGAffineTransformMakeTranslation(0, NKSCREEN_H);
    } completion:nil];
    self.citySelectCell.userInteractionEnabled = YES;
    [self.cityPickerView removeFromSuperview];
}
//地区取消按钮
- (void)cityCancelBtnClick:(NKCityPickerView *)CityPickerView
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.cityPickerView.transform = CGAffineTransformMakeTranslation(0, NKSCREEN_H);
    } completion:nil];
    self.citySelectCell.userInteractionEnabled = YES;
    [self.cityPickerView removeFromSuperview];
}

//生日
- (void)birthdayDidClick:(NSIndexPath *)indexPath
{
    NKDatePickerView *datePickerView = [[NKDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    datePickerView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:datePickerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateCancelBtnClick:)];
    [datePickerView addGestureRecognizer:tap];
    self.datePickerView = datePickerView;
    self.dateIndexPath = indexPath;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.userInteractionEnabled = NO;
    self.dateSelectCell = cell;
    [datePickerView cellDidClick:self.tableView index:indexPath];
}

//生日确定按钮
- (void)dateConfirmBtnClick:(NKDatePickerView *)datePickerView
{
    
    NSDateFormatter *frm = [[NSDateFormatter alloc] init];
    frm.dateFormat = @"yyyy-MM-dd";
    NSArray *models = self.modelArray[self.dateIndexPath.section];
    NKSettingCellModel *model = models[self.dateIndexPath.row];
    model.rightTitle = [frm stringFromDate:self.datePickerView.datePicker.date];
    [self.tableView reloadRowsAtIndexPaths:@[self.dateIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.datePickerView.transform = CGAffineTransformMakeTranslation(0, NKSCREEN_H);
    } completion:nil];
    [self.datePickerView removeFromSuperview];
    self.dateSelectCell.userInteractionEnabled = YES;
}

//生日取消按钮
- (void)dateCancelBtnClick:(NKDatePickerView *)datePickerView
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.datePickerView.transform = CGAffineTransformMakeTranslation(0, NKSCREEN_H);
    } completion:nil];
    [self.datePickerView removeFromSuperview];
    self.dateSelectCell.userInteractionEnabled = YES;

}

//编辑头像
- (void)editBtnDidClick:(NKUserInfoTableHeaderView *)headerView
{
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"头像" message:@"请设置头像"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"拍照" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
            imgPickerController = imgPickerController;
            imgPickerController.delegate = self;
            imgPickerController.allowsEditing = YES;

            imgPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController: imgPickerController animated:YES completion:NULL];
        }else{
            [MBProgressHUD showError:@"相机损坏，无法拍照"];
            
        }
        
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"相册" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            
            UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
            imgPickerController.delegate = self;
            imgPickerController.allowsEditing = YES;
            imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController: imgPickerController animated:YES completion:NULL];
        }}]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (image) {
        self.headerView.iconView.image = info[UIImagePickerControllerOriginalImage];
    }
        [picker dismissViewControllerAnimated:YES completion:nil];
}


//退出账号
- (void)quitBtnDidClick:(NKUserInfoTableFooterView *)footerView
{
    [MBProgressHUD showMessage:@"正在退出。。。"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeUIView" object:self];
    });
}

@end
