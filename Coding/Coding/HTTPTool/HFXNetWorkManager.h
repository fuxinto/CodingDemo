//
//  HFXNetWorkManager.h
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFXRegisterRequestModel.h"

typedef NS_ENUM(NSInteger, ErrorType) {
    ErrorTypeUserName = 1,
    ErrorTypeCaptcha = 903,
};


typedef void(^CompletionHandler)(id resulst, NSError *error);

@interface HFXNetWorkManager : NSObject

/**
 * 返回一个单例对象
 */
+ (instancetype)shareInstance;



/**
 是否需要验证码请求
 
 @param completionHandler 完成后的回调
 */
- (void)isNeedCaptchaWithCompletionHandler:(CompletionHandler)completionHandler;

/**
 注册请求方法

 @param registerModel     请求参数Model
 @param completionHandler 完成后的回调
 */
- (void)registerWithRequestModel:(HFXRegisterRequestModel *)registerModel
               completionHandler:(CompletionHandler)completionHandler;

@end
