//
//  HFXBaseViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseViewController.h"

@interface HFXBaseViewController ()

@end

@implementation HFXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Custom Accessors

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
}

- (UIStatusBarStyle)statusBarStyle {
    return [[UIApplication sharedApplication] statusBarStyle];
}


- (void)dealloc {
    NSLog(@"%@ dealloc", self.class);
}

@end
