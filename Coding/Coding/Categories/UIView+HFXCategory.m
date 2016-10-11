//
//  UIView+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "UIView+HFXCategory.h"

@implementation UIView (Layer)

/**
 * @dynamic 使用后让系统不创建后面属性的set，get方法，自己写
 */
@dynamic right,height,size;
@dynamic cornerRadius, borderWidth, borderColor;

- (CGFloat)right {
    return CGRectGetMaxY(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right-CGRectGetWidth(frame);
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

@end
