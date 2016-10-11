//
//  UIBarButtonItem+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/10/11.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "UIBarButtonItem+HFXCategory.h"

@implementation UIBarButtonItem (HFXCategory)



+ (instancetype)itemWithNormalImageName:(NSString *)normalImageName
                      selectedImageName:(NSString *)selectedImageName
                                 target:(id)target
                                 action:(SEL)action {
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = normalImage.size;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
@end

