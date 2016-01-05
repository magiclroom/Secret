//
//  NKAboutTableViewController.m
//  NKCar
//
//  Created by J on 15/11/13.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKAboutTableViewController.h"

@interface NKAboutTableViewController ()

@end

@implementation NKAboutTableViewController

static NSString *ID = @"cell";

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"意见";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"推荐给好友";
    }else {
        cell.textLabel.text = @"关于App";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
