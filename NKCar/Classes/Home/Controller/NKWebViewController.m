//
//  NKWebViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/22.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKWebViewController.h"

@interface NKWebViewController()

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation NKWebViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIWebView *)webView
{
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:webView];
        self.webView = webView;
    }
    return _webView;
}

-(void)setWebUrl:(NSString *)webUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    [self.webView loadRequest:request];
}

@end
