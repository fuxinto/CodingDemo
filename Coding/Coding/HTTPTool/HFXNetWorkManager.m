//
//  HFXNetWorkManager.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXNetWorkManager.h"
#import "AFNetworking.h"

#import <YYModel/YYModel.h>

static HFXNetWorkManager *netWorkManager = nil;

@interface HFXNetWorkManager ()

@property (strong,nonatomic)AFHTTPSessionManager *sessionManager;


/**
 POST请求

 @param urlString         接口
 @param parametes         参数
 @param completionHandler 请求完成后的回调
 */
- (void)postWithURLString:(NSString *)urlString
                parametes:(NSDictionary *)parametes
        completionHandler:(CompletionHandler)completionHandler;

/**
 GET请求

 @param urlString         接口
 @param parametes         参数
 @param completionHandler 完成后的回调
 */
- (void)getWithURLString:(NSString *)urlString
               parametes:(NSDictionary *)parametes
       completionHandler:(CompletionHandler)completionHandler;

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

#pragma mark - API

- (void)isNeedCaptchaWithCompletionHandler:(CompletionHandler)completionHandler {
    
    [self getWithURLString:kRegisterNeedCaptcha parametes:nil completionHandler:^(id resulst, NSError *error) {
        
        completionHandler(resulst,error);
    }];
}


- (void)registerWithRequestModel:(HFXRegisterRequestModel *)registerModel
               completionHandler:(CompletionHandler)completionHandler {
    
    registerModel.password = [registerModel.password sha1];
    registerModel.confirm = registerModel.password;
    
    [self postWithURLString:kRegisterAPI parametes:[registerModel yy_modelToJSONObject]  completionHandler:^(id resulst, NSError *error) {
        
        if (error) {
            if (error.code == ErrorTypeCaptcha ||
                error.code == ErrorTypeUserName) {
                [self showTipsWithError:error];
            }
            completionHandler(nil, error);
        } else {
            completionHandler(resulst, nil);
        }
    }];
}


#pragma mark - Private
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



- (void)getWithURLString:(NSString *)urlString
                parametes:(NSDictionary *)parametes
        completionHandler:(CompletionHandler)completionHandler {
    
    [self.sessionManager GET:urlString parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = [self handlerErrorWithData:responseObject];
        if (completionHandler) {
            completionHandler(responseObject, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlerErrorWithData:error];
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}

- (NSError *)handlerErrorWithData:(id)data {
    
    NSError *error;
    if ([data isKindOfClass:[NSDictionary class]]) {
        int errorCode = [data[@"code"] intValue];
        if (errorCode == 404) {
            [self showTipsWithMessage:@"网络错误，请稍后再试!"];
        } else if (errorCode == 0) {
            return nil;
        }else if (errorCode == 1000) {
            
        }
        error = [NSError errorWithDomain:@"Https://www.coding.com/" code:errorCode userInfo:data];
    }
    
    if ([data isKindOfClass:[NSError class]]) {
        [self showTipsWithMessage:@"不可预料的错误，请稍后重试!"];
    }
    
    return error;
}

#pragma mark - Custom Accessors

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:HFXBaseURLString]];
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return _sessionManager;
}

@end
