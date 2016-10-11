//
//  HFXProjectRequestModel.h
//  Coding
//
//  Created by tens04 on 16/10/10.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@interface HFXProjectRequestModel : BasesModel

@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pageSize;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *sort;
@end
