//
//  HFXTaskLisitCell.m
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXTaskLisitCell.h"
#import "UIImageView+WebCache.h"

@implementation HFXTaskLisitCell

#pragma mark - IBActions
- (IBAction)clickOnButton:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.StatusDidChangeBlock) {
        self.StatusDidChangeBlock(sender.selected);
    }
}


#pragma mark - Private

- (void)updateUI {
    
    self.checkButton.selected = self.model.status.intValue ? NO: YES;
    
    NSString *urlString = [self.model.owner.avatar imageURLStringWithSize:33];
    [self.taskImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_55"]];
    
    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"taskPriority%@_small", self.model.priority]];
    
    self.descriptionLabel.text = self.model.content;
    
    self.typeLabel.text = [NSString stringWithFormat:@"#%@",self.model.number];
    
    self.onwerLabel.text = self.model.creator.name;
    
    self.dateLabel.text = [self.model.created_at stringFromDateType:DateTypeMMD];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@", self.model.comments];
}


#pragma mark - Custom Accessors

- (void)setModel:(TaskModel *)model {
    if (_model == model) {
        return;
    }
    
    _model = model;
    [self updateUI];
}

@end
