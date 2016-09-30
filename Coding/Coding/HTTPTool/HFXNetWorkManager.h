//
//  HFXNetWorkManager.h
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFXRegisterRequestModel.h"
#import "HFXLoginRequestModel.h"

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
 登录请求方法

 @param loginModel        登录参数Model
 @param completionHandler 完成后的回调
 */
- (void)loginWithRequestModel:(HFXLoginRequestModel *)loginModel completionHandler:(CompletionHandler)completionHandler;
    
/**
 注册是否需要验证码请求
 
 @param completionHandler 完成后的回调
 */
- (void)registerIsNeedCaptchaWithCompletionHandler:(CompletionHandler)completionHandler;



/**
 登录是否需要验证码请求

 @param completionHandler 完成后的回调
 */
- (void)loginIsNeedCaptchaWithCompletionHandler:(CompletionHandler)completionHandler;


/**
 注册请求方法

 @param registerModel     请求参数Model
 @param completionHandler 完成后的回调
 */
- (void)registerWithRequestModel:(HFXRegisterRequestModel *)registerModel
               completionHandler:(CompletionHandler)completionHandler;

@end
