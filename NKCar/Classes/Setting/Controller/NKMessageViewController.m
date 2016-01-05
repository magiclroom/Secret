//
//  NKMessageViewController.m
//  NKCar
//
//  Created by J on 15/11/21.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKMessageViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface NKMessageViewController ()

/** 号码*/
@property (nonatomic,weak)UITextField *messageField;
/** 验证码*/
@property (nonatomic,weak)UITextField *checkField;

@end

@implementation NKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUPView];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)setUPView
{
    UIView *messageView = [[UIView alloc] init];
    messageView.backgroundColor = NKBlueColor;
    [self.view addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(300);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(80);
    }];
    
    UITextField *messageField = [[UITextField alloc] init];
    self.messageField = messageField;
    messageField.borderStyle = UITextBorderStyleRoundedRect;
    messageField.placeholder = @"请输入手机号";
    [messageView addSubview:messageField];
    [messageField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(messageView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.top.equalTo(messageView.mas_top).offset(50);
    }];
    
    UIButton *gainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [gainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gainBtn setBackgroundColor:[UIColor redColor]];
    [messageView addSubview:gainBtn];
    [gainBtn addTarget:self action:@selector(gainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [gainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(messageView);
        make.top.equalTo(messageField.mas_bottom).offset(20);
    }];
    
    UITextField *checkField = [[UITextField alloc] init];
    self.checkField = checkField;
    checkField.borderStyle = UITextBorderStyleRoundedRect;
    checkField.placeholder = @"请输入验证码";
    [messageView addSubview:checkField];
    [checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(messageView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.top.equalTo(gainBtn.mas_bottom).offset(50);
    }];
    
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setTitle:@"比对验证码" forState:UIControlStateNormal];
    [checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkBtn setBackgroundColor:[UIColor redColor]];
    [messageView addSubview:checkBtn];
    [checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(messageView);
        make.top.equalTo(checkField.mas_bottom).offset(20);
    }];
}

- (void)gainBtnClick
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
     //这个参数可以选择是通过发送验证码还是语言来获取验证码
                            phoneNumber:self.messageField.text
                                   zone:@"86"
                       customIdentifier:nil //自定义短信模板标识
                                 result:^(NSError *error)
    {
        
        if (!error)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"获取成功"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];

            
        }
        else
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"获取失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];

            
        }
        
    }];
}

- (void)checkBtnClick
{
    [SMSSDK  commitVerificationCode:self.checkField.text
     //传获取到的区号
                        phoneNumber:self.messageField.text
                               zone:@"86"
                             result:^(NSError *error)
     {
         if (!error)
         {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"匹配正确"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
             [alert show];
             
             
         }
         else
         {
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"匹配失败"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
             [alert show];
             
             
         }
         
     }];
}

@end
