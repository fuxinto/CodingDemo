//
//  UIStoryboard+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIStoryboard (HFXCategory)

+ (UIViewController *)storyboardWithName:(NSString *)name
               instantiateWithIdentifier:(NSString *)identifier;

@end
