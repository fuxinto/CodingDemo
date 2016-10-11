//
//  NSObject+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "NSObject+HFXCategory.h"
#import "MBProgressHUD.h"

#define kArchivePath(path, name)   [path stringByAppendingPathComponent:name]

@implementation NSObject (HFXCategory)

- (void)showTipsWithMessage:(NSString *)message {
    if (message && message.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = message;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1];
    }
}

- (void)showTipsWithError:(NSError *)error {
    NSDictionary *dictionary = error.userInfo[@"msg"];
    [self showTipsWithMessage:[[dictionary allValues] firstObject]];
}

- (void)showHUDQueryStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在获取数据...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.detailsLabel.text = titleStr;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
}

- (void)hideHUDQuery{
    
    NSArray *huds = [MBProgressHUD allHUDsForView:kWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (BOOL)archive {
    return [NSKeyedArchiver archiveRootObject:self toFile:kArchivePath(kDocumentsPath, NSStringFromClass([self class]))];
}

+ (instancetype)unarchive {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kArchivePath(kDocumentsPath, NSStringFromClass([self class]))];;
}

+ (BOOL)removeArchive {
    return [[NSFileManager defaultManager] removeItemAtPath:kArchivePath(kDocumentsPath, NSStringFromClass([self class])) error:nil];
}

@end
