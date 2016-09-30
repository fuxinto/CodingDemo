//
//  HFXLoginRequestModel.h
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@interface HFXLoginRequestModel : BasesModel

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *remember_me;

@property (strong, nonatomic) NSString *j_captcha;


@end
