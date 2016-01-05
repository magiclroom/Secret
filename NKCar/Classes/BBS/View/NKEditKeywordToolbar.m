//
//  NKKeywordToolbar.m
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKEditKeywordToolbar.h"

@interface NKEditKeywordToolbar()
@end

@implementation NKEditKeywordToolbar

- (IBAction)selectPhoto:(UIBarButtonItem *)sender {
    
    if ([_delegateToolbar respondsToSelector:@selector(editWithPhotoBtnDidClick:)]) {
        [_delegateToolbar editWithPhotoBtnDidClick:self];
    }
}

- (IBAction)trash:(UIBarButtonItem *)sender {
    
    if ([_delegateToolbar respondsToSelector:@selector(editWithExitBtnDidClick:)]) {
        [_delegateToolbar editWithExitBtnDidClick:self];
    }
}

@end
