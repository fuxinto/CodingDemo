//
//  HFXTaskLisitCell.h
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"
#import "TaskModel.h"

@interface HFXTaskLisitCell : HFXBaseTableViewCell
@property (strong, nonatomic) IBOutlet UIButton *checkButton;

@property (strong, nonatomic) IBOutlet UIImageView *taskImageView;
@property (strong, nonatomic) IBOutlet UIImageView *levelImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *onwerLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) TaskModel *model;
@property (copy, nonatomic) void(^StatusDidChangeBlock)(BOOL isSelected);

@end
