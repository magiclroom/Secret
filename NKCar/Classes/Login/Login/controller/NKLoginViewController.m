//
//  NKViewController.m
//  01-通讯录
//
//  Created by J on 15/9/9.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKLoginViewController.h"
#import "NKLoginAnimView.h"
#import "MBProgressHUD+NK.h"
#import "UIView+NKExtension.h"


@interface NKLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;
@property (weak, nonatomic) IBOutlet UIButton *remberBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeft;
@property (weak, nonatomic) IBOutlet UITextField *zhuceAccountField;
@property (weak, nonatomic) IBOutlet UITextField *zhucePwdField;
@property (weak, nonatomic) IBOutlet UIButton *zhuceBtn;
/** 登录动画*/
@property (nonatomic,weak)NKLoginAnimView *loginAnimView;

@end

@implementation NKLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //添加Xib
    NKLoginAnimView *loginAnimView = [NKLoginAnimView loginAnimView];
    _loginAnimView = loginAnimView;
    [_imageView addSubview:loginAnimView];
    
    //设置代理
    self.accountField.delegate = self;
    self.pwdFiled.delegate = self;
    
    //监听输入
    [_accountField addTarget:self action:@selector(loginChange) forControlEvents:UIControlEventEditingChanged];
    [_pwdFiled addTarget:self action:@selector(loginChange) forControlEvents:UIControlEventEditingChanged];
    [_zhuceAccountField addTarget:self action:@selector(zhuceChange) forControlEvents:UIControlEventEditingChanged];
    [_zhucePwdField addTarget:self action:@selector(zhuceChange) forControlEvents:UIControlEventEditingChanged];

       //主动调用
    [self loginChange];
    [self zhuceChange];
}


//开始编辑调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.frame.origin.y == self.accountField.frame.origin.y) {
        [_loginAnimView setAnim:NO];
    }else{
        [_loginAnimView setAnim:YES];
    }
}

//记住密码
- (IBAction)rember:(UIButton *)btn
{
    if (btn.selected == YES) {
        btn.selected = NO;
        self.autoBtn.selected = NO;
    }else {
    
        btn.selected = YES;
    }
}


//自动登录
- (IBAction)auto:(UIButton *)btn
{
    if(btn.selected == NO){
        btn.selected = YES;
        self.remberBtn.selected = YES;
    }else {
    
        btn.selected = NO;
    }
}

//登录
- (IBAction)login {
    //弹出蒙版
    [MBProgressHUD showMessage:@"正在登录ing..."];
    
    //延迟0.25秒去判断
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //隐藏蒙版
        [MBProgressHUD hideHUD];
    
        //账号密码正确
        if (([_accountField.text isEqualToString:@"nk"] || [_accountField.text isEqualToString:@"jay"] )&& [_pwdFiled.text isEqualToString:@"123" ]) {
            
            if ([_delegate respondsToSelector:@selector(loginBtnDidClick:title:)]) {
                [_delegate loginBtnDidClick:self title:self.accountField.text];
            }
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [MBProgressHUD showError:@"账号或密码错误"];
        }
    });
                   
}

//点击取消
- (IBAction)exit
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//退出键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//登录按钮状态
- (void)loginChange
{
    _loginBtn.enabled = _accountField.text.length && _pwdFiled.text.length;
}

//注册按钮状态
- (void)zhuceChange
{
    _zhuceBtn.enabled = _zhuceAccountField.text.length && _zhucePwdField.text.length;
}

//点击注册按钮
- (IBAction)loginBtnClick:(UIButton *)loginBtn {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeft.constant) {
        self.loginViewLeft.constant = 0;
        [loginBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        self.zhuceAccountField.text = nil;
        self.zhucePwdField.text = nil;
    }else {
        self.loginViewLeft.constant = -self.view.NK_width;
        [loginBtn setTitle:@"已经注册？" forState:UIControlStateNormal];
        self.accountField.text = nil;
        self.pwdFiled.text = nil;
         [_loginAnimView setAnim:NO];
        self.remberBtn.selected = NO;
        self.autoBtn.selected = NO;
    }
    
    //刷新
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
