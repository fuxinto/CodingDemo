//
//  HFXSettingsViewController.m
//  Coding
//
//  Created by tens04 on 16/10/9.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXSettingsViewController.h"
#import "HFXLoginPageViewController.h"
#import "Masonry.h"
#import "HFXNavigationViewController.h"
#import "SDImageCache.h"

@interface HFXSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *mePageCellInfo;
/**
 退出到引导界面

 @param sender 按钮
 */
- (IBAction)exitToGuidePage:(id)sender;
@end

@implementation HFXSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HFXCellDefaultIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.mePageCellInfo count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mePageCellInfo[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HFXCellDefaultIdentifier];
    if (indexPath.section == 2) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:HFXCellDefaultIdentifier];
        cell.detailTextLabel.text = [self calcCachesSize];
        
    }else {
        cell.detailTextLabel.text = nil;
    }
    cell.editingAccessoryType = UITableViewCellStyleDefault;
    cell.textLabel.text = self.mePageCellInfo[indexPath.section][indexPath.row][@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    view.backgroundColor = [UIColor colorWithR:228 G:228 B:228 alpha:1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        [self cleanCache];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (IBAction)exitToGuidePage:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认是否退出当前账号?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        BOOL isRemove = [HFXUserInfoModel removeArchive];
        
        isRemove = YES;
        if (isRemove) {
            HFXUserInfoModel *user = [HFXUserInfoModel defaultInfo];
            user = nil;
            
            HFXLoginPageViewController *VC = (HFXLoginPageViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXLoginPageIdentifier];
            
            VC.isHiddenCancelButton = YES;
            
            [self presentViewController:VC animated:YES completion:nil];
        } else {
            [self showTipsWithMessage:@"退出不成功，请稍后再试."];
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Private

- (NSString *)calcCachesSize {
    
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                               NSUserDomainMask,
                                                               YES)
                           firstObject];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSUInteger folderSize = 0;
    
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager]
                               attributesOfItemAtPath:filePath error:nil];
        folderSize += [attrs fileSize];
    }
    
    NSString *sizeString = [NSString stringWithFormat:@"%.2f M", ((cacheSize+folderSize)/1000.0/1000.0)];
    
    return sizeString;
}
- (void)cleanCache {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                               NSUserDomainMask, YES)
                           firstObject];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            
            NSString *absolutePath=[cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
    [self showTipsWithMessage:@"清除缓存成功!"];
    
}
#pragma mark - Custom Accessors

- (NSMutableArray *)mePageCellInfo {
    if (!_mePageCellInfo) {
        _mePageCellInfo = [NSMutableArray array];
        [_mePageCellInfo addObject:@[@{@"title":@"账号设置"}]];
        [_mePageCellInfo addObject:@[@{@"title":@"意见反馈"},@{@"title":@"去评分"},@{@"title":@"推荐Coding"}]];
        [_mePageCellInfo addObject:@[@{@"title":@"清除缓存"}]];
        [_mePageCellInfo addObject:@[@{@"title":@"帮助中心"},@{@"title":@"关于Coding"}]];
    }
    return _mePageCellInfo;
}
@end
