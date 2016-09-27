//
//  NSObject+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HFXCategory)


- (void)showTipsWithMessage:(NSString *)message;
- (void)showTipsWithError:(NSError *)error;

- (void)showHUDQueryStr:(NSString *)titleStr;
- (void)hideHUDQuery;

@end