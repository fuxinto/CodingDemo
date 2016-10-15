//
//  HFXLoginViewController.m
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXLoginPageViewController.h"
#import "HFXAppDelegate.h"
#import "HFXRegisterViewController.h"
#import "HFXOnlyTextTableCell.h"
#import "Masonry.h"
#import "YYModel.h"



@interface HFXLoginPageViewController ()
<UITableViewDelegate,UITableViewDataSource> {
    BOOL _isNeedCaptcha;
}
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HFXLoginRequestModel *loginRequestModel;
@property (strong, nonatomic) UIImageView *backImageView;
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
    
     self.tableView.backgroundView = self.backImageView;
    //设置状态栏样式
    self.cancelButton.hidden = self.isHiddenCancelButton;

    [self.tableView registerClass:[HFXOnlyTextTableCell class] forCellReuseIdentifier:HFXOnlyTextTableCellIdentifier];

}
- (void)viewWillAppear:(BOOL)animated {
    
    [self isNeedCaptcha];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)isNeedCaptcha {
    
    [[HFXNetWorkManager shareInstance] loginIsNeedCaptchaWithCompletionHandler:^(id resulst, NSError *error) {
        if (error) {
            _isNeedCaptcha = NO;
        }else {
            
            HFXCaptchaResponseModel *captchaModel = [HFXCaptchaResponseModel yy_modelWithDictionary:resulst];
            
            _isNeedCaptcha = captchaModel.data;
        }
        [self.tableView reloadData];
        
    }];
    
}


#pragma mark - UITableViewDataSource
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
    cell.textField.placeHolderColor = [UIColor colorWithR:223 G:223 B:223 alpha:0.5];
    cell.cliCkColor = [UIColor whiteColor];
    
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
            cell.textField.secureTextEntry = YES;
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

#pragma mark - IBAcitons

- (IBAction)cancelButtonOnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToRegisterPage:(id)sender {
    
    HFXRegisterViewController *VC = (HFXRegisterViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXRegisterPageIdentifier];
    
    
    UINavigationController *naviga = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [self presentViewController:naviga animated:YES completion:nil];
}

- (IBAction)loginButtonClick:(id)sender {
    
//    [self showHUDQueryStr:@"正在登录..."];
    
    [[HFXNetWorkManager shareInstance] loginWithRequestModel:self.loginRequestModel completionHandler:^(id resulst, NSError *error) {
        
        [self hideHUDQuery];
        if (error) {
            
//            HFXAppDelegate *appDelegate = (HFXAppDelegate *)[UIApplication sharedApplication].delegate;
//            [appDelegate setupRootViewController];

            [self showTipsWithError:error];
            [self.tableView reloadData];
        }else {
            HFXAppDelegate *appDelegate = (HFXAppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate setupRootViewController];
        }
    }];
}




#pragma mark - Custom Accessors

- (UIImageView *)backImageView {
    if (!_backImageView) {
        UIImage *image = [UIImage imageNamed:@"STARTIMAGE"];
        _backImageView = [[UIImageView alloc] initWithImage:image];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [_backImageView addSubview:effectView];
        
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_backImageView);
        }];
    }
    return _backImageView;
}

- (HFXLoginRequestModel *)loginRequestModel {
    if (!_loginRequestModel) {
        _loginRequestModel = [[HFXLoginRequestModel alloc]init];
    }
    return _loginRequestModel;
}
@end
