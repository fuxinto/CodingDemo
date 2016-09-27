//
//  UIColor+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "UIColor+HFXCategory.h"

@implementation UIColor (HFXCategory)

+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b
                  alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r/255.0
                           green:g/255.0
                            blue:b/255.0
                           alpha:alpha];
}


+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(((hex & 0xFF0000) >> 16))/255.0 green:(((hex &0xFF00) >>8))/255.0 blue:((hex &0xFF))/255.0 alpha:alpha];
}


+ (UIColor *)randomColor {
    return [UIColor colorWithR:arc4random()%255 G:arc4random()%255 B:arc4random()%255 alpha:1];
}

@end
