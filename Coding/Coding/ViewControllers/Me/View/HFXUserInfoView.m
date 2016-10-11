//
//  HFXUserInfoView.m
//  Coding
//
//  Created by tens04 on 16/10/8.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXUserInfoView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "NSAttributedString+HFXCategory.h"


@interface HFXUserInfoView ()

@property (strong, nonatomic) HFXTapImageView *icon;
@property (strong, nonatomic) UILabel       *nameLabel;
@property (strong, nonatomic) UIButton       *fansButton;
@property (strong, nonatomic) UIButton       *followsButton;
@property (strong, nonatomic) UIView        *lineView;
@property (strong, nonatomic) UIView        *translucenceView;

@end
@implementation HFXUserInfoView

#pragma mark - Public

+ (instancetype)createWithUserInfo:(HFXUserInfoModel *)user
                   backgroundImage:(UIImage *)backgroundImage {
    
    HFXUserInfoView *userInfoView = [[HFXUserInfoView alloc] init];
    userInfoView.contentMode = UIViewContentModeScaleAspectFill;
    userInfoView.clipsToBounds = YES;
    userInfoView.userInfo = user;
    userInfoView.backgroundImage = backgroundImage;
    [userInfoView refreshData];
    return userInfoView;
}

- (void)refreshData {
    
    self.image = self.backgroundImage;
    NSString *sexName = [self.userInfo.sex intValue] ? @"n_sex_woman_icon": @"n_sex_man_icon";
    NSAttributedString *name = [NSAttributedString attributedString:self.userInfo.name font:[UIFont boldSystemFontOfSize:20] textColor:[UIColor whiteColor] appendingImageName:sexName imageBounds:CGRectMake(10, 0, 14, 14)];
    self.nameLabel.attributedText = name;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[self.userInfo.avatar imageURLStringWithSize:75]] placeholderImage:[UIImage imageNamed:@"placeholder_monkey_round_54"]];
    
    NSLog(@"%@",self.icon.image);
    NSString *fansTitle = [NSString stringWithFormat:@"%@ 粉丝", self.userInfo.fans_count];
    [self.fansButton setTitle:fansTitle forState:UIControlStateNormal];
    
    NSString *followsTitle = [NSString stringWithFormat:@"%@ 关注", self.userInfo.follows_count];
    [self.followsButton setTitle:followsTitle forState:UIControlStateNormal];
}


#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubViews];
        [self setupLayout];
    }
    return self;
}


#pragma mark - Private

- (void)loadSubViews {
    [self addSubview:self.translucenceView];
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.fansButton];
    [self addSubview:self.followsButton];
    [self addSubview:self.lineView];
    
}

- (void)setupLayout {
    [self.translucenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(1, 15));
    }];
    
    [self.fansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.lineView.mas_leading).offset(-15);
        make.centerY.equalTo(self.lineView);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.followsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView.mas_trailing).offset(15);
        make.centerY.equalTo(self.lineView);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.fansButton.mas_top).offset(-20);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(200);
    }];
    
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-15);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(75, 75));
    }];
}


#pragma mark - Custom Accessors

- (HFXTapImageView *)icon {
    if (!_icon) {
        _icon = [[HFXTapImageView alloc] init];
        _icon.layer.borderWidth = 1;
        _icon.layer.borderColor = [UIColor whiteColor].CGColor;
        _icon.layer.cornerRadius = 37.5;
        _icon.clipsToBounds = YES;
    }
    return _icon;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)fansButton {
    if (!_fansButton) {
        _fansButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _fansButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    }
    return _fansButton;
}

- (UIButton *)followsButton {
    if (!_followsButton) {
        _followsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _followsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _followsButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UIView *)translucenceView {
    if (!_translucenceView) {
        _translucenceView = [[UIView alloc] init];
        _translucenceView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4];
    }
    return _translucenceView;
}


@end
