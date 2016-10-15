//
//  HFXRootTabBarController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXRootTabBarController.h"

#import "HFXNavigationViewController.h"

@interface HFXRootTabBarController ()

@end

@implementation HFXRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setupTabBar];
}



- (void)setupTabBar {
    
    self.tabBar.tintColor = [UIColor colorWithR:51 G:179 B:101 alpha:1];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    
    for (int i = 0; i < viewControllers.count; i++) {
        
        UIViewController *VC = viewControllers[i];
        
        HFXNavigationViewController *navi = [[HFXNavigationViewController alloc]initWithRootViewController:VC];
        
        viewControllers[i] = navi;
    }
    
    self.viewControllers = viewControllers;
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

@end
