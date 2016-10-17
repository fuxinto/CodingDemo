//
//  HFXBubbleCell.m
//  Coding
//
//  Created by tens04 on 16/10/14.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBubbleCell.h"
#import "Masonry.h"
#import "TTTAttributedLabel.h"
#import "UIImageView+WebCache.h"
#import "HFXCommentCell.h"
#import "BubbleModel.h"
#import "HFXOnlyImageItem.h"
#import "YYModel.h"

@interface HFXBubbleCell ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITableViewDelegate,
UITableViewDataSource,
TTTAttributedLabelDelegate>

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *createDateLabel;
@property (strong, nonatomic) TTTAttributedLabel *contentLabel;
@property (strong, nonatomic) UICollectionView *imageListView;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *rewardButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) UICollectionView *likeListView;
@property (strong, nonatomic) UITableView *commentListView;

@property (strong, nonatomic) NSArray *likeUsers;
@property (strong, nonatomic) NSArray *commentList;

@end
@implementation HFXBubbleCell

- (void)cellDidLoadSubView {
    [super cellDidLoadSubView];
    self.contentView.autoresizesSubviews = NO;
    self.contentView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1];
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.createDateLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.imageListView];
    [self.contentView addSubview:self.likeButton];
    [self.contentView addSubview:self.rewardButton];
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.commentListView];
}

- (void)cellDidAdjustAutoLayout {
    [super cellDidAdjustAutoLayout];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.icon.mas_trailing).offset(10);
        make.trailing.mas_equalTo(15);
        make.top.equalTo(self.icon);
    }];
    
    [self.createDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.nameLabel);
        make.bottom.equalTo(self.icon);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.equalTo(self.icon.mas_bottom).offset(15);
        make.trailing.mas_equalTo(-15);
    }];
    
    [self.imageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.icon);
        make.size.mas_equalTo(CGSizeMake(92, 92));
    }];
    
    [self.rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.likeButton.mas_trailing).offset(30);
        make.top.equalTo(self.likeButton);
        make.size.equalTo(self.likeButton);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.top.equalTo(self.likeButton);
        make.size.equalTo(self.likeButton);
    }];
    
    [self.commentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeButton.mas_bottom).offset(15);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];

    
}
#pragma mark - Private

- (void)updateUI {
    
    NSString *iconString = self.bubbleModel.owner.avatar;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"placeholder_monkey_round_25"]];
    
    self.nameLabel.text = self.bubbleModel.owner.name;
    self.createDateLabel.text = [self.bubbleModel.created_at stringFromDateType:DateTypeMMD];
    
    
    /**
     "content": "<p><a class=\"topic\" href=\"/pp/topic/288\" rel=\"nofollow noopener noreferrer\">#为了码币#</a> <img class=\"emotion emoji\" src=\"https://coding.net/static/emojis/smiley.png\" title=\"smiley\">完成第一份数据结构作业</p>",
     */
    
    
    self.contentLabel.text = self.bubbleModel.content;
    
    // 给html其他标签添加链接
    for (HtmlMediaItem *item in self.bubbleModel.htmlMedia.mediaItems) {
        if (item.linkStr.length > 0) {
            [self.contentLabel addLinkToTransitInformation:@{@"key":(item.linkStr ? : item.src)} withRange:item.range];
        }
    }
    
    NSInteger imageCount = self.bubbleModel.htmlMedia.imageItems.count;
    
    [self resetImageListViewHeightFromImageCount:imageCount];
    
    [self.imageListView reloadData];
    
    [self.likeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (imageCount == 0) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        } else {
            make.top.equalTo(self.imageListView.mas_bottom).offset(20);
        }
        
        make.leading.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 18));
    }];
    
    [self.likeButton setTitle:self.bubbleModel.likes.stringValue forState:UIControlStateNormal];
    [self.rewardButton setTitle:self.bubbleModel.rewards.stringValue forState:UIControlStateNormal];
    [self.commentButton setTitle:self.bubbleModel.comments.stringValue forState:UIControlStateNormal];
    
    if (self.commentList.count == 0 && self.likeUsers.count == 0) {
        self.commentListView.hidden = YES;
    } else {
        self.commentListView.hidden = NO;
        [self.commentListView reloadData];
    }
}

- (void)resetImageListViewHeightFromImageCount:(NSInteger)imageCout {
    
    imageCout = MIN(imageCout, 9);
    
    self.imageListView.hidden = !imageCout;
    
    if (imageCout == 1) {
        [self.imageListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(192, 192));
        }];
    } else if (imageCout == 2) {
        [self.imageListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(95*2+5, 95));
        }];
    } else if (imageCout == 4) {
        [self.imageListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(95*2+5, 95*2+5));
        }];
    } else {
        //        NSInteger space = (imageCout/3.0 - imageCout%3) > 0.001 ? imageCout%3+1 : imageCout %3;
        NSInteger space = (imageCout+2)/3;
        
        [self.imageListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(95*3+10, 95*space+5*(space-1)));
        }];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.imageListView) {
        NSInteger imageCount = [self.bubbleModel.htmlMedia.imageItems count];
        return MIN(imageCount, 9);
    } else {
        
        int itemCount = CGRectGetWidth(collectionView.frame)/36;
        
        return MIN(self.likeUsers.count, itemCount);
    }

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXOnlyImageItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFXOnlyImageItem" forIndexPath:indexPath];
    
    if (self.imageListView == collectionView) {
        
        [cell.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(cell.contentView);
        }];
        
        HtmlMediaItem *item = self.bubbleModel.htmlMedia.imageItems[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.src] placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_80"]];
    } else {
        Like_Users *likeUser = self.likeUsers[indexPath.row];
        
        cell.imageView.cornerRadius = 13;
        [cell.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
        }];
        
        NSString *iconString = [likeUser.avatar imageURLStringWithSize:26];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"placeholder_monkey_round_25"]];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.imageListView) {
        if (self.bubbleModel.htmlMedia.imageItems.count == 1) {
            return CGSizeMake(192, 192);
        }
        else {
            return CGSizeMake(95, 95);
        }
    } else {
        return CGSizeMake(36, 45);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HFXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFXCommentCell" forIndexPath:indexPath];
    cell.commentModel = self.commentList[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    headerView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1];
    
    if (self.likeUsers.count > 0) {
        
        [headerView addSubview:self.likeListView];
        [self.likeListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(headerView);
            make.top.mas_equalTo(7);
            make.height.mas_equalTo(45);
        }];
    }
    
    UIImageView *arrowhead = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 15, 7)];
    arrowhead.image = [UIImage imageNamed:@"commentOrLikeBeginImg"];
    [headerView addSubview:arrowhead];
    
    // 如果多处使用，请提取出来
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithR:220 G:220 B:220 alpha:1];
    
    [headerView addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(headerView);
        make.height.mas_offset(1);
    }];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.commentList.count <= 6) return nil;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 0, 45);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    [button setTitleColor:[UIColor colorWithHex:0x222222 alpha:1] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tweet_more_comment_icon"] forState:UIControlStateNormal];
    [button setTitle:@"查看11条全部评论" forState:UIControlStateNormal];
    return button;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.likeUsers.count > 0) {
        return 52;
    } else {
        return 7;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.commentList.count > 6) {
        return 45;
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSLog(@"%@", components[@"key"]);
}

#pragma mark - Custom Assessors

- (void)setBubbleModel:(BubbleModel *)bubbleModel {
    if (_bubbleModel == bubbleModel) return;
    
    _bubbleModel = bubbleModel;
    
    _likeUsers = [NSArray yy_modelArrayWithClass:[Like_Users class] json:_bubbleModel.like_users];
    _commentList = [NSArray yy_modelArrayWithClass:[Comment_List class] json:_bubbleModel.comment_list];
    
    [self updateUI];
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}


- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = [UIColor colorWithR:116 G:188 B:124 alpha:1];
    }
    return _nameLabel;
}

- (UILabel *)createDateLabel {
    if (!_createDateLabel) {
        _createDateLabel = [[UILabel alloc] init];
        _createDateLabel.font = [UIFont systemFontOfSize:12];
        _createDateLabel.textColor = [UIColor colorWithR:152 G:152 B:152 alpha:1];
    }
    return _createDateLabel;
}

- (TTTAttributedLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        
        NSDictionary *linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName:@NO,
                                         (NSString *)kCTForegroundColorAttributeName: (__bridge id)[[UIColor colorWithR:125 G:193 B:135 alpha:1] CGColor]};
        
        _contentLabel.linkAttributes = linkAttributes;
        
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = [UIColor colorWithR:39 G:39 B:39 alpha:1];
        _contentLabel.delegate = self;
    }
    return _contentLabel;
}

- (UICollectionView *)imageListView {
    if (!_imageListView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsZero;
        _imageListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _imageListView.delegate = self;
        _imageListView.dataSource = self;
        _imageListView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1];
        UINib *nib = [UINib nibWithNibName:@"HFXOnlyImageItem" bundle:nil];
        [_imageListView registerNib:nib forCellWithReuseIdentifier:@"HFXOnlyImageItem"];
    }
    return _imageListView;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"tweet_btn_like"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"tweet_btn_liked"] forState:UIControlStateSelected];
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_likeButton setTitleColor:[UIColor colorWithR:152 G:152 B:152 alpha:1] forState:UIControlStateNormal];
    }
    return _likeButton;
}

- (UIButton *)rewardButton {
    if (!_rewardButton) {
        _rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rewardButton setImage:[UIImage imageNamed:@"tweet_btn_reward"] forState:UIControlStateNormal];
        [_rewardButton setImage:[UIImage imageNamed:@"tweet_btn_rewarded"] forState:UIControlStateSelected];
        _rewardButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _rewardButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_rewardButton setTitleColor:[UIColor colorWithR:152 G:152 B:152 alpha:1] forState:UIControlStateNormal];
    }
    return _rewardButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"tweet_btn_comment"] forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_commentButton setTitleColor:[UIColor colorWithR:152 G:152 B:152 alpha:1] forState:UIControlStateNormal];
    }
    return _commentButton;
}

- (UICollectionView *)likeListView {
    if (!_likeListView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        _likeListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _likeListView.delegate = self;
        _likeListView.dataSource = self;
        _likeListView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
        UINib *nib = [UINib nibWithNibName:@"HFXOnlyImageItem" bundle:nil];
        [_likeListView registerNib:nib forCellWithReuseIdentifier:@"HFXOnlyImageItem"];
    }
    return _likeListView;
}

- (UITableView *)commentListView {
    if (!_commentListView) {
        _commentListView = [[UITableView alloc] init];
        _commentListView.scrollEnabled = NO;
        _commentListView.delegate = self;
        _commentListView.dataSource = self;
        _commentListView.rowHeight = 47;
        [_commentListView registerClass:[HFXCommentCell class] forCellReuseIdentifier:@"HFXCommentCell"];
        _commentListView.backgroundColor = [UIColor colorWithHex:0xeeeeee alpha:1];
    }
    return _commentListView;
}


@end
