//
//  HFXTaskLisitRequestModel.h
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "BasesModel.h"

@interface HFXTaskListRequestModel : BasesModel
@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pageSize;

@end
