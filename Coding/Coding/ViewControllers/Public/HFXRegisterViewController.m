//
//  HFXRegisterViewController.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXRegisterViewController.h"
#import "HFXOnlyTextTableCell.h"
#import "HFXRegisterRequestModel.h"


@interface HFXRegisterViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    BOOL _isNeedCaptcha;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *serverLabel;

@property (strong, nonatomic) HFXRegisterRequestModel *requestModel;
/**
 * 同意条款点击事件
 */
- (void)protocolLabelOnClicked:(UITapGestureRecognizer*)gasture;

/**
 注册按钮

 @param sender 按钮
 */
- (IBAction)registerButton:(id)sender;


/**
 * 取消按钮事件
 */
- (void)cancelButtonOnClicked:(UIButton *)sender;


/**
 是否需要验证码
 */
- (void)isNeedCaptcha;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self isNeedCaptcha];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)isNeedCaptcha {
    
    [[HFXNetWorkManager shareInstance] isNeedCaptchaWithCompletionHandler:^(id resulst, NSError *error) {
        if (error) {
            _isNeedCaptcha = NO;
        }else {
            
            HFXCaptchaResponseModel *captchaModel = [[HFXCaptchaResponseModel alloc] initWithDictionary:resulst];
            
            _isNeedCaptcha = captchaModel.b_data;
            
        }
        
        [self.tableView reloadData];
        
    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _isNeedCaptcha ? 4 : 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXOnlyTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXOnlyTextTableCellIdentifier];
    
    __weak typeof(self) weakSelf = self;
    
    switch (indexPath.row) {
        case 0:{
            cell.textField.placeholder = @"用户名（个性后缀）";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                weakSelf.requestModel.global_key = text;
            };
            break;
        }
        case 1:{
            cell.textField.placeholder = @"邮箱";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                weakSelf.requestModel.email = text;
            };
            break;
        }
        case 2:{
            cell.textField.placeholder = @"设置密码";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                weakSelf.requestModel.password = text;
            
            };
            break;
        }
        default:{
            cell.textField.placeholder = @"验证码";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                weakSelf.requestModel.j_captcha = text;
            };
            break;
        }
    }
    
    return cell;
    
}

#pragma mark - IBActions

- (void)protocolLabelOnClicked:(UITapGestureRecognizer*)gasture {
    
    
}

- (IBAction)registerButton:(id)sender {
    
    [[HFXNetWorkManager shareInstance] registerWithRequestModel:self.requestModel completionHandler:^(id resulst, NSError *error) {
        if (error.code == ErrorTypeCaptcha) {
            [self isNeedCaptcha];
            NSLog(@"错误");
        }else if (resulst) {
            NSLog(@"注册成功:%@",resulst);
        }
    }];
}

- (void)cancelButtonOnClicked:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Custom Accessors

- (HFXRegisterRequestModel *)requestModel {
    
    if (!_requestModel) {
        _requestModel = [[HFXRegisterRequestModel alloc]init];
    }
    return _requestModel;
}

@end
