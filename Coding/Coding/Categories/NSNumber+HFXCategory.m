//
//  NSNumber+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "NSNumber+HFXCategory.h"
#import <objc/runtime.h>

@implementation NSNumber (HFXCategory)
@dynamic dateFormatter;

- (NSString *)stringFromDateType:(DateType)type {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.longLongValue/1000.0];
    
    NSString *dateFormat;
    switch (type) {
        case DateTypeMMD: {
            dateFormat = @"MM/d";
            break;
        }
        default:
            dateFormat = @"YY/MM/d HH:m:s";
            break;
    }
    
    self.dateFormatter.dateFormat = dateFormat;
    
    return [self.dateFormatter stringFromDate:date];
}

- (NSDateFormatter *)dateFormatter {
    
    NSDateFormatter *dateFormatter = objc_getAssociatedObject(self, @selector(setDateFormatter:));
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        objc_setAssociatedObject(self, @selector(setDateFormatter:), dateFormatter, OBJC_ASSOCIATION_RETAIN);
    }
    return dateFormatter;
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    objc_setAssociatedObject(self, @selector(setDateFormatter:), dateFormatter, OBJC_ASSOCIATION_RETAIN);
}


@end
