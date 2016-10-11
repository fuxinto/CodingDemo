//
//  HFXMessageViewController.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXMessageViewController.h"

@interface HFXMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *infoArray;
@property (strong, nonatomic) NSMutableArray *nofityCells;

@end

@implementation HFXMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"tweetBtn_Nav"]
                                              style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(sendNewMessageButtonOnClicked:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (void)sendNewMessageButtonOnClicked:(UIButton *)sender {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count + self.nofityCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (indexPath.row < 3) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HFXCellDefaultIdentifier];
        NSDictionary *info = self.infoArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:info[@"iconName"]];
        cell.textLabel.text = info[@"title"];
        
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXCellCustomIdentifier];
        NSDictionary *info = self.nofityCells[indexPath.row-3];
        cell.imageView.image = [UIImage imageNamed:info[@"iconName"]];
        cell.textLabel.text = info[@"title"];
        cell.detailTextLabel.text = info[@"detail"];
        
        UILabel *dateLabel = [cell.contentView viewWithTag:100];
        dateLabel.right = kScreenWidth - 15;
        dateLabel.text = info[@"date"];
        
        return cell;
    }
}

#pragma mark - Custom Accessors

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = @[@{@"iconName": @"messageAT", @"title": @"@我的"},@{@"iconName": @"messageComment", @"title": @"评论"},@{@"iconName": @"messageSystem", @"title": @"系统通知"}];
    }
    return _infoArray;
}
- (NSMutableArray *)nofityCells {
    if (!_nofityCells) {
        _nofityCells = [NSMutableArray arrayWithObject:@{@"iconName":@"user_monkey",
                                                         @"title": @"Coding",
                                                         @"detail": @"Coding项目讨论功能升级", @"date": @"08/17"}];
    }
    return _nofityCells;
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
