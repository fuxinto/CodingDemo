//
//  HFXRegisterRequestModel.m
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXRegisterRequestModel.h"

@implementation HFXRegisterRequestModel


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        _channel = @"coding-ios";
    }
    
    return self;
}

@end
