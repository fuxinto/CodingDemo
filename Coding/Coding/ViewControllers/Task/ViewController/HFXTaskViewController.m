//
//  HFXTaskViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXTaskViewController.h"
#import "HFXOnlyImageItem.h"
#import "YYModel.h"
#import "TaskModel.h"
#import "UIImageView+WebCache.h"
#import "HFXTaskLisitCell.h"
#import "MJRefresh.h"

@interface HFXTaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HFXTaskLisitRequestModel *requestModel;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) NSArray *projectLisit;
@property (strong, nonatomic) NSMutableArray *taskLisit;


/**
 刷新按钮的点击事件
 */
- (void)downLoadTaskLisit;
/**
 添加按钮的点击事件
 */
- (void)addBarButtonOnClicked:(UIButton *)sender;
@end

@implementation HFXTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    [self.collectionView addSubview:self.line];
    
    UIBarButtonItem *addBarButton =
    [UIBarButtonItem itemWithNormalImageName:@"addBtn_Nav"
                           selectedImageName:nil
                                      target:self
                                      action:@selector(addBarButtonOnClicked:)];
    
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf downLoadTaskLisit];
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (void)addBarButtonOnClicked:(UIButton *)sender {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
//    [self downLoadTaskLisit];
}

#pragma mark - Private

- (void)downLoadTaskLisit {
    
//    [self showHUDQueryStr:@"正在加载..."];
    
    [[HFXNetWorkManager shareInstance] taskLisitWithRequestModel:self.requestModel completionHandler:^(id resulst, NSError *error) {
//        [self hideHUDQuery];
        [self.tableView.mj_header endRefreshing];
        if (error) {
            [self showTipsWithError:error];
        }else {
            
            NSArray *info = [NSArray yy_modelArrayWithClass:[TaskModel class] json:resulst[@"data"][@"list"]];
    
            NSMutableArray *projectlisit = [info valueForKey:@"project"];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            for (Project *project in projectlisit) {
                
                [dic setObject:project forKey:project.n_id];
            }
            
            self.projectLisit = [dic allValues];
            
            if (self.requestModel.pageSize.integerValue == 1) {
                [self.taskLisit removeAllObjects];
            }
            [self.taskLisit addObjectsFromArray:info];
            [self.tableView reloadData];
            [self.collectionView reloadData];
        }
        NSLog(@"%ld",self.taskLisit.count);
    }];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.projectLisit.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXOnlyImageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFXOnlyImageItem" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        item.imageView.image = [UIImage imageNamed:@"tasks_all"];
    }else {
        
        Project *project = self.projectLisit[indexPath.row-1];
        
        NSString *url = [project.icon imageURLStringWithSize:40];
        
        [item.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_80"]];
        
    }
    
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //    CGRect frame = [cell convertRect:cell.superview.frame toView:self.view];
    CGRect frame = [cell convertRect:cell.superview.frame toView:self.collectionView];
    
    [UIView animateWithDuration:0.25 animations:^{
        //        self.leadingConstraint.constant = CGRectGetMinX(frame)-5;
        self.line.left = CGRectGetMinX(frame)-5;
        
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.taskLisit.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXTaskLisitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFXTaskLisitCell" forIndexPath:indexPath];
    

    cell.model = self.taskLisit[indexPath.row];
    cell.StatusDidChangeBlock = ^(BOOL isSelected) {
        NSLog(@"%d", isSelected);
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentifier"];
    if (!header) {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        header.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 15)];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithR:162 G:162 B:162 alpha:1];
        
        [header addSubview:label];
    }
    
    UILabel *label = [header viewWithTag:100];
    if (section==0) {
        label.text = @"进行中的任务";
    } else {
        label.text = @"已完成的任务";
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    view.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
    return view;
}

#pragma mark - Custom Accessors

- (HFXTaskLisitRequestModel *)requestModel {
    
    if (!_requestModel) {
        _requestModel = [[HFXTaskLisitRequestModel alloc]init];
        _requestModel.pageSize = @999;
    }
    return _requestModel;
}

- (NSMutableArray *)taskLisit {
    if (!_taskLisit) {
        _taskLisit = [NSMutableArray array];
    }
    return _taskLisit;
}

- (NSArray *)projectLisit {
    if (!_projectLisit) {
        _projectLisit = [NSArray array];
    }
    return _projectLisit;
}
- (UIView *)line {
    if (!_line) {
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(5, 67, 50, 2)];
        _line.backgroundColor = [UIColor colorWithR:40 G:173 B:74 alpha:1];
    }
    return _line;
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
