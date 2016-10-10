//
//  HFXSettingsViewController.m
//  Coding
//
//  Created by tens04 on 16/10/9.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXSettingsViewController.h"
#import "HFXGuideViewController.h"
#import "Masonry.h"

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
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M",[self folderSizeAtPath]];
        
    }else {
        cell.detailTextLabel.hidden = YES;
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


- (void)cleanCache {

    //文件路径
    NSString *directoryPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
    NSArray *subpaths = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:directoryPath error:nil];
        
    for (NSString *subPath in subpaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}
/**
 *  计算整个目录大小
 */
- (float)folderSizeAtPath
{
    NSString *folderPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager * manager=[NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0 );
}
/**
 *  计算单个文件大小
 */
- (long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize];
    }
    return 0 ;
    
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

- (IBAction)exitToGuidePage:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"退出后需要重新登录" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        
        if ([defaultManager isDeletableFileAtPath:[HFXUserInfoModel archivePath]]) {
            
            [defaultManager removeItemAtPath:[HFXUserInfoModel archivePath] error:nil];
        }
        
        HFXGuideViewController *VC = (HFXGuideViewController *)[UIStoryboard storyboardWithName:HFXPublicStoryboardName instantiateWithIdentifier:HFXGuidePageIdentifier];
        
        
        
        [self presentViewController:VC animated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
