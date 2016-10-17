//
//  NSNumber+HFXCategory.h
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, DateType) {
    DateTypeMMD = 0,
    DateTypeHHmmss = 1,
    DateTypeYYMMDHHmmss = 2,
};

@interface NSNumber (HFXCategory)

- (NSString *)stringFromDateType:(DateType)type;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end
