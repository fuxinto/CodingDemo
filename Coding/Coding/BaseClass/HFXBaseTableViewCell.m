//
//  HFXBaseTableViewCell.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"


@interface HFXBaseTableViewCell ()

/**
 * 初始化Cell
 */
- (void)initCell;

@end


@implementation HFXBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCell];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initCell];
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCell {
    
    [self cellDidLoadSubView];
    [self cellDidAdjustAutoLayout];
    
}

- (void)cellDidLoadSubView {
    
    
}

- (void)cellDidAdjustAutoLayout {
    
    
}

@end
