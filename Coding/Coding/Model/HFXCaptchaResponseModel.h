//
//  HFXCaptchaResponseModel.h
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@interface HFXCaptchaResponseModel : BasesModel

@property (assign, nonatomic, getter=isData) BOOL b_data;
@property (copy, nonatomic) NSNumber *n_code;

@end
