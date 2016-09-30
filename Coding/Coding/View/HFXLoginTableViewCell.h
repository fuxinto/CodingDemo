//
//  HFXLoginTableViewCell.h
//  Coding
//
//  Created by tens04 on 16/9/29.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseTableViewCell.h"

@interface HFXLoginTableViewCell : HFXBaseTableViewCell
<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) void (^textFieldDidChangeBlock)(NSString *text);


@end
