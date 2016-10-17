//
//  HFXCommentCell.h
//  Coding
//
//  Created by tens04 on 16/10/15.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"
#import "Comment_List.h"

@interface HFXCommentCell : HFXBaseTableViewCell
@property (strong, nonatomic) Comment_List *commentModel;
@end
