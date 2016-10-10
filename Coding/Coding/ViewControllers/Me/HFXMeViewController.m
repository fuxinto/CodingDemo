//
//  HFXMeViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXMeViewController.h"
#import "HFXUserInfoView.h"
#import "HFXSettingsViewController.h"
@interface HFXMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *cellInfo;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HFXUserInfoView *userInfoView;
@end

@implementation HFXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HFXCellDefaultIdentifier];
    self.tableView.backgroundColor = [UIColor colorWithR:228
                                                       G:228
                                                       B:228
                                                   alpha:1];
    
    self.tableView.tableHeaderView = self.userInfoView;
    [self setupNavigationBar];
}

#pragma mark - Private

- (void)setupNavigationBar {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addUserBtn_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(addUserButtonOnClicked:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(settingButtonOnClicked:)];
}

#pragma mark - IBActions

- (void)addUserButtonOnClicked:(UIButton *)sender {
    
}

- (void)settingButtonOnClicked:(UIButton *)sender {
    
    HFXSettingsViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:HFXSettingsPageIdentifier];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
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

#pragma mark - UITabViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cellInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellInfo[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXCellDefaultIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.separatorInset = UIEdgeInsetsMake(0, 18, 0, 0);
    
    NSDictionary *info = self.cellInfo[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:info[@"icon"]];
    cell.textLabel.text = info[@"title"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 20;
    } else {
        return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    view.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    view.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
    return view;
}

#pragma mark - Custom Accessors
- (HFXUserInfoView *)userInfoView {
    if (!_userInfoView) {
        _userInfoView = [HFXUserInfoView createWithUserInfo:[HFXUserInfoModel defaultInfo] backgroundImage:[UIImage imageNamed:@"STARTIMAGE"]];
        _userInfoView.frame = CGRectMake(0, 0, 320, 190);
    }
    return _userInfoView;
}
- (NSMutableArray *)cellInfo {
    
    if (!_cellInfo) {
        _cellInfo = [NSMutableArray array];
        [_cellInfo addObject:@[@{@"title":@"详细信息", @"icon":@"user_info_detail"}]];
        [_cellInfo addObject:@[
                               @{@"title":@"我的项目", @"icon":@"user_info_project"},
                               @{@"title":@"我的冒泡", @"icon":@"user_info_tweet"},
                               @{@"title":@"我的话题", @"icon":@"user_info_topic"},
                               @{@"title":@"本地文件", @"icon":@"user_info_file"}]];
        [_cellInfo addObject:@[@{@"title":@"我的码币", @"icon":@"user_info_point"}]];
    }
    return _cellInfo;
}

@end
