//
//  HFXLoginViewController.m
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXLoginPageViewController.h"
#import "HFXLoginTableViewCell.h"
#import "HFXRegisterViewController.h"
#import "HFXOnlyTextTableCell.h"

@interface HFXLoginPageViewController ()
<UITableViewDelegate,UITableViewDataSource> {
    BOOL _isNeedCaptcha;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HFXLoginRequestModel *loginRequestModel;
/**
 取消按钮

 @param sender 按钮
 */
- (IBAction)cancelButtonOnClick:(id)sender;

/**
 跳转到注册页面

 @param sender 按钮
 */
- (IBAction)goToRegisterPage:(id)sender;



/**
 登录按钮方法

 @param sender 按钮
 */
- (IBAction)loginButtonClick:(id)sender;
@end

@implementation HFXLoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    [self.tableView registerClass:[HFXOnlyTextTableCell class] forCellReuseIdentifier:HFXOnlyTextTableCellIdentifier];

}
- (void)viewWillAppear:(BOOL)animated {
    
    [self isNeedCaptcha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)isNeedCaptcha {
    
    [[HFXNetWorkManager shareInstance] loginIsNeedCaptchaWithCompletionHandler:^(id resulst, NSError *error) {
        if (error) {
            _isNeedCaptcha = NO;
        }else {
            
            HFXCaptchaResponseModel *captchaModel = [[HFXCaptchaResponseModel alloc] initWithDictionary:resulst];
            
            _isNeedCaptcha = captchaModel.data;
        }
        [self.tableView reloadData];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _isNeedCaptcha ? 3 :2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXOnlyTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXOnlyTextTableCellIdentifier];
    
    if (indexPath.row == 2) {
        cell.captchaImageView.hidden = NO;
    }else {
        cell.captchaImageView.hidden = YES;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            cell.textField.placeholder = @"手机号码/电子邮箱/个性后缀";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                self.loginRequestModel.account = text;
            };
        }
            break;
        case 1:{
            cell.textField.placeholder = @"密码";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                self.loginRequestModel.password = text;
            };
        }
            break;
        default:{
            cell.textField.placeholder = @"验证码";
            cell.textFieldDidChangeBlock = ^(NSString *text){
                weakSelf.loginRequestModel.j_captcha = text;
            };
        }
            break;
    }
    
    return cell;
}


- (IBAction)cancelButtonOnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToRegisterPage:(id)sender {
    
    HFXRegisterViewController *VC = (HFXRegisterViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXRegisterPageIdentifier];
    
    UINavigationController *naviga = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self presentViewController:naviga animated:YES completion:nil];
    
}

- (IBAction)loginButtonClick:(id)sender {
    
    [[HFXNetWorkManager shareInstance] loginWithRequestModel:self.loginRequestModel completionHandler:^(id resulst, NSError *error) {
        if (error) {
            NSLog(@"登录失败");
        }else {
            NSLog(@"登录成功");
        }
    }];
}


- (HFXLoginRequestModel *)loginRequestModel {
    if (!_loginRequestModel) {
        _loginRequestModel = [[HFXLoginRequestModel alloc]init];
    }
    return _loginRequestModel;
}
@end
