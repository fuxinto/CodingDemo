//
//  NSString+HFXCategory.m
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "NSString+HFXCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"

@implementation NSString (HFXCategory)

- (NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)imageURLStringWithSize:(CGFloat)size {
    
    NSString *string = self;
    if (![string hasPrefix:@"http"]) {
        string = [@"https://coding.net/" stringByAppendingString:string];
    }
    return [string stringByAppendingString:[NSString stringWithFormat:@"?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr", size, size]];
    
}
@end

@implementation NSString (HTML)

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}

@end

