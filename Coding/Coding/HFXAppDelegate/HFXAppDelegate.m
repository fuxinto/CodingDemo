//
//  AppDelegate.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXAppDelegate.h"
#import "HFXGuideViewController.h"
#import "SDWebImageManager.h"
#import "HFXUserInfoModel.h"
#import "HFXRootTabBarController.h"


@interface HFXAppDelegate ()

/*
 * 统一设置UI样式
 */
- (void)customAppearance;

@end

@implementation HFXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //sd加载的数据类型
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    [self customAppearance];
    
    //BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
    
    if ([HFXUserInfoModel unarchive]) {
        [self setupRootViewController];
    } else {
        [self setupGuidePage];
    }

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setupGuidePage {
    
    HFXGuideViewController *guide = (HFXGuideViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXGuidePageIdentifier];
    
    self.window.rootViewController = guide;
    
}

- (void)setupRootViewController {
    
    HFXRootTabBarController *tabbar = (HFXRootTabBarController *)[UIStoryboard storyboardWithName:HFXMainStoryboardName instantiateWithIdentifier:nil];
    self.window.rootViewController = tabbar;
}

#pragma mark - Private

- (void)customAppearance {
    
    // NavigationBar
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.tintColor = [UIColor whiteColor];
    
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x28303b alpha:1]] forBarMetrics:UIBarMetricsDefault];
    
    // UITextField
    [[UITextField appearance] setTintColor:[UIColor colorWithHex:0x3bbc79 alpha:1]];
}

@end
