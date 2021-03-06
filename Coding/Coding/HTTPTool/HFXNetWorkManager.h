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
#import "HFXProjectRequestModel.h"
#import "HFXTaskListRequestModel.h"
#import "HFXBubbleListRequest.h"

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


/**
 项目列表请求方法

 @param projectListModel 请求参数Model
 @param completionHandler 完成后的回调
 */
- (void)projectListWithRequestModel:(HFXProjectRequestModel *)projectListModel completionHandler:(CompletionHandler)completionHandler;

/**
 任务列表请求方法

 @param taskListRequestMode 请求参数Model
 @param completionHandler    完成后的回调
 */
- (void)taskListWithRequestModel:(HFXTaskListRequestModel *)taskListRequestMode completionHandler:(CompletionHandler)completionHandler;


/**
 冒泡列表

 @param api               接口地址
 @param bubbleListRequest 请求参数Model
 @param completionHandler 完成后的回调
 */
- (void)bubbleListWithAPI:(NSString *)api requestModel:(HFXBubbleListRequest *)bubbleListRequest completionHandler:(CompletionHandler)completionHandler;
@end
