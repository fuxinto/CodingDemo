//
//  HFXSearchBar.m
//  Coding
//
//  Created by tens04 on 16/10/11.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXSearchBar.h"
#import "Masonry.h"
CGFloat const kSearchBarHeight = 30;

@interface HFXSearchBar ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *searchIcon;
@property (strong, nonatomic) UITextField *searchTextFiled;
@property (strong, nonatomic) UIButton *rightButton;

/**
 初始化SearchBar
 */
- (void)initSearchBar;

/**
 右边按钮的点击事件
 */
- (void)rightButtonOnClicked:(UIButton *)sender;
@end

@implementation HFXSearchBar

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSearchBar];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initSearchBar];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.searchTextFiled becomeFirstResponder];
}

#pragma mark - IBActions

- (void)rightButtonOnClicked:(UIButton *)sender {
    
    if ([self.searchBarDelegate respondsToSelector:@selector(rightButtonOnClicked:)]) {
        [self.searchBarDelegate rightButtonOnClicked:sender];
    }
}


#pragma mark - Private

- (void)initSearchBar {
    
    self.height = kSearchBarHeight;
    self.cornerRadius = kSearchBarHeight/2;
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.searchIcon];
    [self addSubview:self.searchTextFiled];
    [self addSubview:self.rightButton];
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(kSearchBarHeight/2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kSearchBarHeight/2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.searchIcon.mas_trailing).offset(10);
        make.trailing.equalTo(self.rightButton.mas_leading).offset(-10);
    }];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([self.searchBarDelegate respondsToSelector:@selector(HFXSearchBarShouldBeginEditing)]) {
        
        return [self.searchBarDelegate HFXSearchBarShouldBeginEditing];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([self.searchBarDelegate respondsToSelector:@selector(HFXSearchBarShouldEndEditing)]) {
        return [self.searchBarDelegate HFXSearchBarShouldEndEditing];
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self.searchBarDelegate respondsToSelector:@selector(HFXSearchBarTextDidChangeWithString:)]) {
        return [self.searchBarDelegate HFXSearchBarTextDidChangeWithString:[textField.text stringByAppendingString:string]];
    } else {
        return YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.searchBarDelegate respondsToSelector:@selector(HFXSearchBarShouldReturn:)]) {
        return [self.searchBarDelegate HFXSearchBarShouldReturn:textField];
    } else {
        return YES;
    }
}


#pragma mark - Custom Accessors

- (UIImageView *)searchIcon {
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search_searchbar"]];
    }
    return _searchIcon;
}

- (UITextField *)searchTextFiled {
    if (!_searchTextFiled) {
        _searchTextFiled = [[UITextField alloc] init];
        _searchTextFiled.font = [UIFont systemFontOfSize:14];
        _searchTextFiled.placeholder = @"搜索";
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"button_scan"] forState:UIControlStateNormal];
        [_rightButton addTarget:self
                         action:@selector(rightButtonOnClicked:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end

