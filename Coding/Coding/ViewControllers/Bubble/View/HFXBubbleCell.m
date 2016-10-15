//
//  HFXBubbleCell.m
//  Coding
//
//  Created by tens04 on 16/10/14.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBubbleCell.h"
#import "Masonry.h"

@interface HFXBubbleCell ()
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *nameLabel;
@end
@implementation HFXBubbleCell

- (void)cellDidLoadSubView {
    [super cellDidLoadSubView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
}

- (void)cellDidAdjustAutoLayout {
    [super cellDidAdjustAutoLayout];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
}


- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = [UIColor colorWithR:116 G:188 B:124 alpha:1];
        
    }
    return _nameLabel;
}

@end
