//
//  HFXProjectViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXProjectViewController.h"
#import "HFXProjectLisitCell.h"
#import "UIImageView+WebCache.h"
#import "NSObject+YYModel.h"
#import "MJRefresh.h"
#import "HFXNetWorkManager.h"
#import "UIBarButtonItem+HFXCategory.h"
#import "Projects.h"
#import "HFXSearchBar.h"

@interface HFXProjectViewController ()<UITableViewDelegate,UITableViewDataSource,HFXSearchBarDelegate>
@property (strong, nonatomic) HFXProjectRequestModel *projectRequestModel;
@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *projectList;
@end

@implementation HFXProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusBarStyle = UIStatusBarStyleDefault;
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.projectRequestModel.page = @1;
        [weakSelf downLoadProjectList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.projectRequestModel.page = @(weakSelf.projectRequestModel.page.intValue +1);
        [weakSelf downLoadProjectList];
    }];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Private

- (void)setupNavigationBar {
    
    UIBarButtonItem *leftBarButton =
    [UIBarButtonItem itemWithNormalImageName:@"filtertBtn_normal_Nav" selectedImageName:@"filterBtn_selected_Nav"
        target:self action:@selector(leftBarButtonOnClicked:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton =
    [UIBarButtonItem itemWithNormalImageName:@"addBtn_Nav" selectedImageName:nil target:self action:@selector(addBarButtonOnClicked:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    HFXSearchBar *searchBar = [[HFXSearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 0, 205, 30);
    searchBar.searchBarDelegate = self;
    self.navigationItem.titleView = searchBar;
}
- (void)downLoadProjectList {
    
    [[HFXNetWorkManager shareInstance] projectLisitWithRequestModel:self.projectRequestModel completionHandler:^(id resulst, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        
        if (error) {
            [self showTipsWithError:error];
        }else if (resulst) {
            
            ProjectListResponse *response = [ProjectListResponse yy_modelWithDictionary:resulst];
            
            response.data.list = [NSArray yy_modelArrayWithClass:NSClassFromString(@"Projects") json:response.data.list];
            
            if (self.projectRequestModel.page.intValue == 1) {
            
                [self.projectList removeAllObjects];
            }

            [self.projectList addObjectsFromArray:response.data.list];
            [self.tableView reloadData];
        }
    }];
}


#pragma mark - IBActions

- (void)leftBarButtonOnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)addBarButtonOnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (sender.selected) {
            sender.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } else {
            sender.transform = CGAffineTransformIdentity;
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.projectList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXProjectLisitCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXCellCustomIdentifier];
    
    Projects *project = self.projectList[indexPath.row];
    
    NSString *urlString = [project.icon imageURLStringWithSize:160];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_80"]];
    
    cell.titleLabel.text = project.name;
    cell.contentLabel.text = project.str_description;
    cell.onwerLabel.text = project.owner_user_name;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom Accessors

- (HFXProjectRequestModel *)projectRequestModel {
    
    if (!_projectRequestModel) {
        _projectRequestModel = [[HFXProjectRequestModel alloc]init];
        _projectRequestModel.type = @"all";
        _projectRequestModel.pageSize = @10;
        _projectRequestModel.sort = @"hot";
        _projectRequestModel.page = @1;
    }
    return _projectRequestModel;
}

- (NSMutableArray *)projectList {
    if (!_projectList) {
        _projectList = [NSMutableArray array];
    }
    return _projectList;
}
                                
                                
@end
