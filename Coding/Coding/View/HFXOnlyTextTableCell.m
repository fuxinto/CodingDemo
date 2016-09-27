//
//  HFXOnlyTextTableCell.m
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXOnlyTextTableCell.h"
#import "Masonry.h"


@implementation HFXOnlyTextTableCell 

- (void)cellDidLoadSubView {
    
    [super cellDidLoadSubView];
    [self.contentView addSubview:self.textField];
}

- (void)cellDidAdjustAutoLayout {
    [super cellDidAdjustAutoLayout];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(18);
        make.trailing.mas_equalTo(-18);
        make.top.bottom.mas_equalTo(0);
    }];
    
    
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock([textField.text stringByAppendingString:string]);
    }
    
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


@end
