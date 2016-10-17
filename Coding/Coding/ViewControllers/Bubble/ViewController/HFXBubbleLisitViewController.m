//
//  HFXBubbleLisitViewController.m
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBubbleLisitViewController.h"
#import "HFXBubbleViewController.h"
#import "Masonry.h"
@interface HFXBubbleLisitViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    NSInteger _currentPage;
}

@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation HFXBubbleLisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    self.pageViewController.view.frame = self.view.bounds;
    
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    [self.pageViewController setViewControllers:@[[self.viewControllers firstObject]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private 

- (void)setupNavigationBar {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"hot_topic_Nav" selectedImageName:nil target:self action:@selector(hotTopicOnClickButton:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"tweetBtn_Nav" selectedImageName:nil target:self action:@selector(releaseOnClickButton:)];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.size = CGSizeMake(100, 44);
    titleView.backgroundColor = [UIColor clearColor];
    
    [titleView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleView);
        make.centerX.equalTo(titleView);
        make.height.mas_equalTo(20);
    }];
    
    [titleView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView);
        make.bottom.equalTo(self.pageControl.mas_top).offset(0);
    }];
    
    self.navigationItem.titleView = titleView;

    
}
#pragma mark - IBAction

- (void)hotTopicOnClickButton:(UIButton *)sender {
    
}

- (void)releaseOnClickButton:(UIButton *)sender {
    
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return self.viewControllers[index-1];

    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 2) {
        return nil;
    }
    return self.viewControllers[index+1];

}



#pragma mark - UIPageViewControllerDelegate



- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    _currentPage = [self.viewControllers indexOfObject:pendingViewControllers[0]];
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (!completed) return;
    
    switch (_currentPage) {
        case 0:{
            self.titleLabel.text = @"冒泡广场";
            break;
        }
        case 1: {
            self.titleLabel.text = @"朋友圈";
            break;
        }
        default:
            self.titleLabel.text = @"热门冒泡";
            break;
    }
    
    self.pageControl.currentPage = _currentPage;
}

#pragma mark - Custom Accessors

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithR:126 G:130 B:135 alpha:1];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController =
        [[UIPageViewController alloc]initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.view.borderColor = [UIColor colorWithHex:0xfafafa alpha:1];
        
    }
    return _pageViewController;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"冒泡广场";
    }
    return _titleLabel;
}
- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            
            HFXBubbleViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:HFXBubblePageIdentifier];
            VC.bubbletype = i;
            [_viewControllers addObject:VC];
        }
    }
    return _viewControllers;
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
