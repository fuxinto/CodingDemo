//
//  UIColor+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/9/26.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HFXCategory)

/**
 * rgb从0到255
 */
+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b
                  alpha:(CGFloat)alpha;

/**
 * 随机颜色
 */
+ (UIColor *)randomColor;

@end
