//
//  BasesModel.m
//  News
//
//  Created by tens04 on 16/8/17.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@implementation BasesModel



- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        // 根据字典的数据给 model 属性设置
        [self setValuesForKeysWithDictionary:dic];
        // self.newId = dic[@"id"];
    }
    return self;
}

// 过滤掉字典中没有用到的 key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // 内部不用写
}
@end
