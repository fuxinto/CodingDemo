//
//  HFXOnlyTextTableCell.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXOnlyTextTableCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface HFXOnlyTextTableCell () {
    UIView *view;
}

@end
@implementation HFXOnlyTextTableCell 



- (void)cellDidLoadSubView {
    
    view = [[UIView alloc]init];
    [super cellDidLoadSubView];
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.captchaImageView];
    
    
    
    __weak typeof(self) weakSelf = self;
    self.captchaImageView.handleTapBlock = ^(HFXTapImageView *imageView){
        [weakSelf refreshCaptcha];
    };

}



- (void)cellDidAdjustAutoLayout {
    [super cellDidAdjustAutoLayout];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(18);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(43);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(18);
        make.trailing.mas_equalTo(-18);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.captchaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
}

- (void)layoutSubviews {
    
    [self refreshCaptcha];
}


#pragma mark - Public

- (void)refreshCaptcha {
    
    NSURL *url = [NSURL URLWithString:[HFXBaseURLString stringByAppendingString:kGetCaptcha]];
    
    [self.captchaImageView sd_setImageWithURL:url
                             placeholderImage:nil
                                      options:(SDWebImageRetryFailed | SDWebImageRefreshCached | SDWebImageHandleCookies)];
    
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock([textField.text stringByAppendingString:string]);
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.mark == 1) {
        self.textFieldLineFeedBlock(YES);
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    view.backgroundColor = self.cliCkColor;
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    view.backgroundColor = [UIColor grayColor];
    
    return YES;
}


- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = [UIColor colorWithHex:0x222222 alpha:1];
        _textField.delegate = self;
    }
    return _textField;
}


- (HFXTapImageView *)captchaImageView {
    if (!_captchaImageView) {
        _captchaImageView = [[HFXTapImageView alloc]init];
        _captchaImageView.hidden = YES;
    }
    return _captchaImageView;
}

@end
