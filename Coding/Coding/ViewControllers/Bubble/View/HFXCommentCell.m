//
//  HFXCommentCell.m
//  Coding
//
//  Created by tens04 on 16/10/15.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXCommentCell.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"

@interface HFXCommentCell ()<TTTAttributedLabelDelegate>

@property (strong, nonatomic) TTTAttributedLabel *contentLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIImageView *dateIcon;


/**
 更新UI
 */
- (void)updateUI;
@end

@implementation HFXCommentCell

#pragma mark - init

- (void)cellDidLoadSubView {
    [super cellDidLoadSubView];
    
    self.contentView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateIcon];
    [self.contentView addSubview:self.dateLabel];
}

- (void)cellDidAdjustAutoLayout {
    [super cellDidAdjustAutoLayout];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentLabel);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.dateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dateIcon.mas_trailing).offset(5);
        make.centerY.equalTo(self.nameLabel);
    }];
}


#pragma mark - Private

- (void)updateUI {
    
    self.contentLabel.text = self.commentModel.content;
    
    for (HtmlMediaItem *item in self.commentModel.htmlMeida.mediaItems) {
        if (item.name.length > 0) {
            [self.contentLabel addLinkToTransitInformation:@{@"key":item.href} withRange:item.range];
        }
    }
    
    self.nameLabel.text = self.commentModel.owner.name;
    self.dateLabel.text = [self.commentModel.created_at stringFromDateType:DateTypeYYMMDHHmmss];
}


#pragma mark - Custom Accessors


- (void)setCommentModel:(Comment_List *)commentModel {
    if (_commentModel == commentModel) return;
    
    _commentModel = commentModel;
    
    [self updateUI];
}

- (TTTAttributedLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        
        NSDictionary *linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName:@NO,
                                         (NSString *)kCTForegroundColorAttributeName: (__bridge id)[[UIColor colorWithR:125 G:193 B:135 alpha:1] CGColor]};
        
        _contentLabel.linkAttributes = linkAttributes;
        _contentLabel.textColor = [UIColor colorWithHex:0x222222 alpha:1];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.delegate = self;
    }
    return _contentLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:10];
        _nameLabel.textColor = [UIColor colorWithHex:0x666666 alpha:1];
    }
    return _nameLabel;
}

- (UIImageView *)dateIcon {
    if (!_dateIcon) {
        _dateIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time_clock_icon"]];
    }
    return _dateIcon;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:10];
        _dateLabel.textColor = [UIColor colorWithHex:0xb9b9b9 alpha:1];
    }
    return _dateLabel;
}

@end
