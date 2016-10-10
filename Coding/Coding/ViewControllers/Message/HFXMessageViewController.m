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
@property (strong, nonatomic) NSMutableArray *infoArray;
@end

@implementation HFXMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HFXCellDefaultIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXCellDefaultIdentifier];
    
    
    if (indexPath.row == 3) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HFXCellDefaultIdentifier];
        
        cell.detailTextLabel.text = @"Coding 项目讨论功能升级...";
        cell.detailTextLabel.textColor = [UIColor colorWithR:153 G:153 B:153 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(250, 12, 100, 10)];
        label.text = @"08/17";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithR:153 G:153 B:153 alpha:1];
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [cell.contentView addSubview:label];
        
    }else {
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.imageView.image = [UIImage imageNamed:self.infoArray[indexPath.row][@"icon"]];
    cell.textLabel.text = self.infoArray[indexPath.row][@"title"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61;
}
- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
        [_infoArray addObject:@{@"title":@"@我的",@"icon":@"messageAT"}];
        [_infoArray addObject:@{@"title":@"评论",@"icon":@"messageComment"}];
        [_infoArray addObject:@{@"title":@"系统通知",@"icon":@"messageSystem"}];
        [_infoArray addObject:@{@"title":@"coding",@"icon":@"user_monkey"}];
    }
    return _infoArray;
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
