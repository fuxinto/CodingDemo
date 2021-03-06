//
//  UIStoryboard+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "UIStoryboard+HFXCategory.h"

@implementation UIStoryboard (HFXCategory)


+ (UIViewController *)storyboardWithName:(NSString *)name
               instantiateWithIdentifier:(NSString *)identifier {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    if (identifier) {
        return [storyboard instantiateViewControllerWithIdentifier:identifier];
    } else {
        return [storyboard instantiateInitialViewController];
    }
    
}

@end
