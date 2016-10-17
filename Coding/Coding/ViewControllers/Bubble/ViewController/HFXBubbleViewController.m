//
//  HFXBubbleViewController.m
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBubbleViewController.h"
#import "BubbleModel.h"
#import "YYModel.h"
#import "HFXBubbleCell.h"

static NSString *reuseIdentifier = @"HFXBubbleCell";
@interface HFXBubbleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HFXBubbleListRequest *requestModel;
@property (strong, nonatomic) NSArray *bubbleList;
/**
 刷新数据
 */
- (void)refreshData;

/**
 下载冒泡列表

 @param api 下载接口
 */
- (void)downLoadBubbleListWithAPI:(NSString *)api;
@end

@implementation HFXBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    [self.tableView registerClass:[HFXBubbleCell class] forCellReuseIdentifier:reuseIdentifier];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView registerClass:[HFXBubbleCell class] forCellReuseIdentifier:reuseIdentifier];
    [self refreshData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)refreshData {
    
    switch (self.bubbletype) {
        case BubbleTypeDefault:{
            self.requestModel.sort = @"time";
            [self downLoadBubbleListWithAPI:kBubbleListAPI];
        }
            break;
        case BubbleTypeFriend:{
            [self downLoadBubbleListWithAPI:kBubbleFriendAPI];
        }
            break;
        case BubbleTypeHot: {
            self.requestModel.sort = @"hot";
            [self downLoadBubbleListWithAPI:kBubbleListAPI];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private

- (void)downLoadBubbleListWithAPI:(NSString *)api {
    
    [[HFXNetWorkManager shareInstance] bubbleListWithAPI:api requestModel:self.requestModel completionHandler:^(id resulst, NSError *error) {
        
        if (error) {
            [self showTipsWithError:error];
        }else if(resulst){
            
            self.bubbleList = [NSArray yy_modelArrayWithClass:[BubbleModel class] json:resulst[@"data"]];
            
            [self.tableView reloadData];
        }
        
    }];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionre {
    
    return self.bubbleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.bubbleModel = self.bubbleList[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BubbleModel *model  = self.bubbleList[indexPath.row];
    return 38+18 + 15 + 15 + 15 + 20+10 +15 + model.varContentHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Custom Assessors

- (HFXBubbleListRequest *)requestModel {
    if (!_requestModel) {
        _requestModel = [[HFXBubbleListRequest alloc]init];
    }
    return _requestModel;
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
