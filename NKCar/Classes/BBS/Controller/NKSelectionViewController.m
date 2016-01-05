//
//  NKSelectionViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/24.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKSelectionViewController.h"

@interface NKSelectionViewController()

/** 浏览器*/
@property (nonatomic,strong)UIWebView *webView;


@end

@implementation NKSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUPWebView];
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, NKSCREEN_W, NKSCREEN_H-80)];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)setUPWebView
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
