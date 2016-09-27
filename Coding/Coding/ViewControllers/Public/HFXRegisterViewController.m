//
//  HFXRegisterViewController.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXRegisterViewController.h"
#import "HFXOnlyTextTableCell.h"
@interface HFXRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *serverLabel;

/**
 * 同意条款点击事件
 */
- (void)protocolLabelOnClicked:(UITapGestureRecognizer*)gasture;


/**
 * 取消按钮事件
 */
- (void)cancelButtonOnClicked:(UIButton *)sender;

@end


@implementation HFXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonOnClicked:)];
    
    self.navigationItem.leftBarButtonItem = barButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolLabelOnClicked:)];
    
    [self.serverLabel addGestureRecognizer:tap];
    
    [self.tableView registerClass:[HFXOnlyTextTableCell class] forCellReuseIdentifier:HFXOnlyTextTableCellIdentifier];
    
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


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXOnlyTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXOnlyTextTableCellIdentifier];
    
    switch (indexPath.row) {
        case 0:{
            cell.textField.placeholder = @"用户名（个性后缀）";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                NSLog(@"%@",text);
            };
            break;
        }
        case 1:{
            cell.textField.placeholder = @"邮箱";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                NSLog(@"%@",text);
            };
            break;
        }
        case 2:{
            cell.textField.placeholder = @"设置密码";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                NSLog(@"%@",text);
            
            };
            break;
        }
        default:{
            break;
        }
    }
    
    return cell;
    
}

#pragma mark - IBActions

- (void)protocolLabelOnClicked:(UITapGestureRecognizer*)gasture {
    
    
}

- (void)cancelButtonOnClicked:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
