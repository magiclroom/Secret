//
//  NKBrandCell.m
//  XCar
//
//  Created by 牛康康 on 15/10/29.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKBrandCell.h"
#import "NKBrand.h"
#import "UIImageView+WebCache.h"


@interface NKBrandCell()

@property (nonatomic,weak) UIImageView *brandImage;

@property (nonatomic,weak) UILabel *brandNameLabel;

@end

@implementation NKBrandCell

static NSString *ID = @"brand";


-(instancetype)initWithTableView:(UITableView *)tableView
{
    
    NKBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NKBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *brandImage = [[UIImageView alloc] init];
        [self.contentView addSubview:brandImage];
        self.brandImage = brandImage;
        
        UILabel *brandNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:brandNameLabel];
        self.brandNameLabel = brandNameLabel;
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat margin = 10;
    [self.brandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(2 * margin);
        make.bottom.mas_equalTo(self.contentView).offset(-2 * margin);
        make.width.mas_equalTo(40);
    }];
    
    [self.brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.brandImage.mas_right).offset(margin);
        make.top.mas_equalTo(self.brandImage);
        make.bottom.mas_equalTo(self.brandImage);
        make.width.mas_equalTo(120);
    }];
    
    
}

-(void)setBrand:(NKBrand *)brand
{
    _brand = brand;

    [self.brandImage sd_setImageWithURL:[NSURL URLWithString:brand.icon]];
    self.brandNameLabel.text = brand.name;
}





@end
