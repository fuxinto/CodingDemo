//
//  BasesModel.m
//  News
//
//  Created by tens04 on 16/8/17.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"
#import "NSObject+YYModel.h"
@implementation BasesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"str_description"  : @"description",@"n_id": @"id"};
}

@end
