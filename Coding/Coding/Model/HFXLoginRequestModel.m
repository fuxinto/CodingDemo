//
//  HFXLoginRequestModel.m
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXLoginRequestModel.h"

@implementation HFXLoginRequestModel


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        _remember_me = @"true";
    }
    
    return self;
}

@end
