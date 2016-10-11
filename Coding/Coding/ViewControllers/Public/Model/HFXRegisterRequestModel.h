//
//  HFXRegisterRequestModel.h
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@interface HFXRegisterRequestModel : BasesModel


@property (copy, nonatomic) NSString *channel;      // 渠道
@property (copy, nonatomic) NSString *global_key;   // 昵称
@property (copy, nonatomic) NSString *email;        // 邮箱
@property (copy, nonatomic) NSString *password;     // 密码
@property (copy, nonatomic) NSString *confirm;      // 确认密码
@property (copy, nonatomic) NSString *j_captcha;    // 验证码

@end
