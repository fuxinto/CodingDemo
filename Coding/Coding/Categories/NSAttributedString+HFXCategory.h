//
//  NSAttributedString+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/10/8.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (HFXCategory)
/**
 拼接图片到富文本后边
 
 @param string    文字
 @param font      字体
 @param color     颜色
 @param imageName 图片名字
 @param bounds    图片大小
 
 @return 富文本对象
 */
+ (instancetype)attributedString:(NSString *)string
                            font:(UIFont *)font
                       textColor:(UIColor *)color
              appendingImageName:(NSString *)imageName
                     imageBounds:(CGRect)bounds;
@end
