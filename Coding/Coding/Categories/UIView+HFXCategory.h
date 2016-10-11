//
//  UIView+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Layer)

/**
 * IBInspectable 修饰符使用之后可以在故事板里面设置属性
 */
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (assign, nonatomic) IBInspectable UIColor *borderColor;

@end
