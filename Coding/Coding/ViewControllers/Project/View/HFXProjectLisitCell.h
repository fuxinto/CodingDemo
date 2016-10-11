//
//  HFXProjectLisitCell.h
//  Coding
//
//  Created by tens04 on 16/10/10.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"

@interface HFXProjectLisitCell : HFXBaseTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *onwerLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
