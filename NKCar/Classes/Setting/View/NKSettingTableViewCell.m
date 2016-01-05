//
//  NKSettingTableViewCell.m
//  NKCar
//
//  Created by J on 15/11/10.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKSettingTableViewCell.h"

@interface NKSettingTableViewCell() 
@property (weak, nonatomic) IBOutlet UILabel *leftText;
@property (weak, nonatomic) IBOutlet UILabel *rightText;

@end

@implementation NKSettingTableViewCell

- (void)awakeFromNib
{
    self.leftText.textColor = [UIColor grayColor];
    self.leftText.font = [UIFont systemFontOfSize:15];
    self.rightText.font = [UIFont systemFontOfSize:15];
}


- (void)setCellModel:(NKSettingCellModel *)cellModel
{
    _cellModel = cellModel;
    self.leftText.text = cellModel.leftTitle;
    self.rightText.text = cellModel.rightTitle;
}


@end
