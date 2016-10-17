//
//  HFXOnlyTextTableCell.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"
#import "HFXTapImageView.h"

@interface HFXOnlyTextTableCell : HFXBaseTableViewCell
<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIColor *cliCkColor;
@property (strong, nonatomic) void (^textFieldDidChangeBlock)(NSString *text);
@property (assign, nonatomic) NSInteger mark;
@property (strong, nonatomic) HFXTapImageView *captchaImageView;
@property (strong, nonatomic) void (^textFieldLineFeedBlock)(BOOL yes);

/**
 刷新验证码
 */
- (void)refreshCaptcha;



@end
