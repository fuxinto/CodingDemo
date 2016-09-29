//
//  HFXAPPMacro.m
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXAPPMacro.h"

#ifdef RELEASE
NSString *const HFXBaseURLString = @"http://192.168.0.188:8080/";
#else
NSString *const HFXBaseURLString = @"https://coding.net/";
#endif
