//
//  NSObject+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "NSObject+HFXCategory.h"
#import "MBProgressHUD.h"
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


@end
