//
//  NSAttributedString+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/10/8.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "NSAttributedString+HFXCategory.h"

@implementation NSAttributedString (HFXCategory)
+ (instancetype)attributedString:(NSString *)string
                            font:(UIFont *)font
                       textColor:(UIColor *)color
              appendingImageName:(NSString *)imageName
                     imageBounds:(CGRect)bounds {
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName:color};
    
    NSMutableAttributedString *attributsObj = [[NSMutableAttributedString alloc] initWithString:(string ? : @"") attributes:attributes];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = bounds;
    NSAttributedString *imageAttributed = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributsObj appendAttributedString:imageAttributed];
    
    return attributsObj;
}

@end
