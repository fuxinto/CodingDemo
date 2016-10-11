//
//  HFXTaskViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXTaskViewController.h"
#import "UIBarButtonItem+HFXCategory.h"
@interface HFXTaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


/**
 添加按钮的点击事件
 */
- (void)addBarButtonOnClicked:(UIButton *)sender;
@end

@implementation HFXTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    
    UIBarButtonItem *addBarButton =
    [UIBarButtonItem itemWithNormalImageName:@"addBtn_Nav"
                           selectedImageName:nil
                                      target:self
                                      action:@selector(addBarButtonOnClicked:)];
    
    self.navigationItem.rightBarButtonItem = addBarButton;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (void)addBarButtonOnClicked:(UIButton *)sender {
    
}

#pragma mark - 


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return NULL;
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
