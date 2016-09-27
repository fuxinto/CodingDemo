//
//  HFXNetWorkManager.h
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(id resulst, NSError *error);

@interface HFXNetWorkManager : NSObject

/**
 * 返回一个单例对象
 */
+ (instancetype)shareInstance;

- (void)login:(NSDictionary *)parametes
completionHandler:(CompletionHandler)completionHandler;

- (void)logout:(NSDictionary *)parametes
completionHandler:(CompletionHandler)completionHandler;

@end
