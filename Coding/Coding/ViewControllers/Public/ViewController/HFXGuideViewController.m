//
//  HFXGuideViewController.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXGuideViewController.h"
#import "Masonry.h"
#import "HFXRegisterViewController.h"
#import "HFXLoginPageViewController.h"

@interface HFXGuideViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

/**
 *  加载Scroll View
 */
- (void)loadScrollView;


/**
 注册按钮方法

 @param sender 按钮
 */
- (IBAction)registerButtonOnClicker:(id)sender;



/**
 登录按钮方法

 @param sender 按钮
 */
- (IBAction)loginButtonOnClicked:(id)sender;


@end

@implementation HFXGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.statusBarStyle = UIStatusBarStyleDefault;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)loadScrollView {
    
    NSArray *iconNames = @[@"intro_icon_6", @"intro_icon_0", @"intro_icon_1", @"intro_icon_2", @"intro_icon_3", @"intro_icon_4", @"intro_icon_5"];
    
    NSArray *tipNames= @[@"intro_icon123", @"intro_tip_0", @"intro_tip_1", @"intro_tip_2", @"intro_tip_3", @"intro_tip_4", @"intro_tip_5"];
    
    for (int i =0; i<7; i++) {
        
        /**
         加载图片有两种方法：
         1.通过图片名字加载，会自动缓存
         2.通过路径加载，不会缓存
         当图片只显示一次的时候，可以用路径方式加载。
         */
        
        UIImage *iconImage = [UIImage imageNamed:iconNames[i]];
        UIImage *tipsImage = [UIImage imageNamed:tipNames[i]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        [self.scrollView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(i*kScreenWidth);
            make.centerY.equalTo(self.view).offset(-100);
        }];
        
        UIImageView *tipsImageView = [[UIImageView alloc] initWithImage:tipsImage];
        [self.scrollView addSubview:tipsImageView];
        
        [tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_bottom).offset(25);
            make.centerX.equalTo(iconImageView.mas_centerX);
        }];
    }
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*7, kScreenHeight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int currentPage = scrollView.contentOffset.x/kScreenWidth;
    self.pageControl.currentPage = currentPage;
}

- (IBAction)registerButtonOnClicker:(id)sender {
    
    HFXRegisterViewController * VC = (HFXRegisterViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXRegisterPageIdentifier];
    UINavigationController *naviga = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self presentViewController:naviga animated:YES completion:nil];
}

- (IBAction)loginButtonOnClicked:(id)sender {
    
    HFXLoginPageViewController *VC = (HFXLoginPageViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXLoginPageIdentifier];
    
    UINavigationController *naviga = [[UINavigationController alloc]initWithRootViewController:VC];
    
    naviga.navigationBarHidden = YES;

    [self presentViewController:naviga animated:YES completion:nil];
}
@end
