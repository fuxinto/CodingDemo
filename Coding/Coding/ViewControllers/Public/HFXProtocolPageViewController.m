//
//  HFXProtocolPageViewController.m
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXProtocolPageViewController.h"

@interface HFXProtocolPageViewController ()
@property(strong, nonatomic) UIWebView *webView;


@end

@implementation HFXProtocolPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"service_terms"
//                                                         ofType:@"html"];
//    NSData *data = [NSData dataWithContentsOfFile: htmlPath];
//    NSString *info = [[NSString alloc] initWithData:data
//                                           encoding:NSUTF8StringEncoding];
//    [self.webView loadHTMLString:info
//                         baseURL:[NSURL fileURLWithPath: htmlPath]];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"service_terms" withExtension:@"heml"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
