//
//  HFXOnlyTextTableCell.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"

@interface HFXOnlyTextTableCell : HFXBaseTableViewCell
<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) void (^textFieldDidChangeBlock)(NSString *text);

@end
