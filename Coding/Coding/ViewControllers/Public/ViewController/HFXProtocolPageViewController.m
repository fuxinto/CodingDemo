//
//  HFXProtocolPageViewController.m
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXProtocolPageViewController.h"
#import <WebKit/WebKit.h>

@interface HFXProtocolPageViewController ()<WKNavigationDelegate>
@property(strong, nonatomic) WKWebView *WKwebView;
@property(strong, nonatomic) UIActivityIndicatorView *activity;
@property(strong, nonatomic) UILabel *label;
@end

@implementation HFXProtocolPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"service_terms" withExtension:@"html"];
    
    
    [self.WKwebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.WKwebView];
    [self.view addSubview:self.activity];
    [self.view addSubview:self.label];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.label removeFromSuperview];
    [self.activity removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.activity startAnimating];
}

- (WKWebView *)WKwebView {
    if (!_WKwebView) {
        _WKwebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _WKwebView.navigationDelegate = self;
    }
    return _WKwebView;
}

- (UIActivityIndicatorView *)activity {
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.frame = CGRectMake(kScreenWidth/2, (kScreenHeight-80)/2, 0, 0) ;
    }
    return _activity;
}

-(UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
        _label.center = self.view.center;
        _label.text = @"正在努力加载中...";
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
