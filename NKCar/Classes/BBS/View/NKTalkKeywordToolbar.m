//
//  NKTalkKeywordToolbar.m
//  NKCar
//
//  Created by J on 15/11/17.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKTalkKeywordToolbar.h"

@interface NKTalkKeywordToolbar()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NKTalkKeywordToolbar

- (UITextField *)inputField
{
    return _textField;
}

- (IBAction)send:(id)sender {
    if ([_delegateToolbar respondsToSelector:@selector(talkWithsendBtnDidClick:)]) {
        [_delegateToolbar talkWithsendBtnDidClick:self];
    }
}
- (IBAction)exit:(id)sender {
    if ([_delegateToolbar respondsToSelector:@selector(talkWithexitBtnDidClick:)]) {
        [_delegateToolbar talkWithexitBtnDidClick:self];
    }
}


@end
