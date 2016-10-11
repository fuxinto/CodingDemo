//
//  UIBarButtonItem+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/10/11.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HFXCategory)
/**
 创建barButton
 
 @param normalImageName   默认图片名字
 @param selectedImageName 选中图片名字
 @param target            目标对象
 @param action            事件
 
 @return barButton
 */
+ (instancetype)itemWithNormalImageName:(NSString *)normalImageName
                      selectedImageName:(NSString *)selectedImageName
                                 target:(id)target
                                 action:(SEL)action;
@end
