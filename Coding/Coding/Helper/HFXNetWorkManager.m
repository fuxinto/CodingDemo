//
//  HFXNetWorkManager.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXNetWorkManager.h"
#import "AFNetworking.h"
#import "NSObject+HFXCategory.h"
static HFXNetWorkManager *netWorkManager = nil;

@interface HFXNetWorkManager ()

@property (strong,nonatomic)AFHTTPSessionManager *sessionManager;

@end

@implementation HFXNetWorkManager


#pragma mark - init
+ (instancetype)shareInstance {
    
    return [[HFXNetWorkManager alloc]init];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        netWorkManager = [super allocWithZone:zone];
        
    });
    return netWorkManager;
}

- (id)copy {
    
    return netWorkManager;
}

- (id)mutableCopy {
    
    return netWorkManager;
}

#pragma mark - NetWork

- (void)login:(NSDictionary *)parametes
completionHandler:(CompletionHandler)completionHandler {
    
    [self postWithURLString:@"1" parametes:parametes completionHandler:^(id resulst, NSError *error) {
        if (completionHandler) {
            if (error) {
                completionHandler(nil,error);
            }else {
                
                completionHandler(resulst,nil);
            }
        }
    }];

}

- (void)logout:(NSDictionary *)parametes
completionHandler:(CompletionHandler)completionHandler {
    
}

- (void)postWithURLString:(NSString *)urlString
                parametes:(NSDictionary *)parametes
        completionHandler:(CompletionHandler)completionHandler {
    
    [self.sessionManager POST:urlString parameters:parametes
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error = [self handlerErrorWithData:responseObject];
        
        if (completionHandler) {
            completionHandler(responseObject,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) {
            completionHandler(nil,error);
        }
    }];
}


- (NSError *)handlerErrorWithData:(id)data {
    
    NSError *error;
    if ([data isKindOfClass:[NSDictionary class]]) {
        int errorCode = [data[@"code"] intValue];
        if (errorCode == 404) {
            [self showTipsWithMessage:@"网络错误，请稍后再试!"];
        } else if (errorCode == 1000) {
            
        }
        error = [NSError errorWithDomain:@"Https://www.coding.com/" code:errorCode userInfo:@{}];
    }
    
    if ([data isKindOfClass:[NSError class]]) {
        [self showTipsWithMessage:@"不可预料的错误，请稍后重试!"];
    }
    
    return error;
}


- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return _sessionManager;
}

@end
