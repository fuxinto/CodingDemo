//
//  HFXSearchBar.h
//  Coding
//
//  Created by tens04 on 16/10/11.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HFXSearchBarDelegate <NSObject>

@required

@optional

/**
 将要编辑
 
 @return 是否编辑
 */
- (BOOL)HFXSearchBarShouldBeginEditing;

/**
 将要结束编辑
 
 @return 是否结束编辑
 */
- (BOOL)HFXSearchBarShouldEndEditing;

/**
 文本发生改变
 
 @param string 改变的文本
 
 @return 是否改变文本
 */
- (BOOL)HFXSearchBarTextDidChangeWithString:(NSString *)string;

/**
 键盘将要按下return
 
 @return 是否允许按下
 */
- (BOOL)HFXSearchBarShouldReturn:(UITextField *)textField;

/**
 右边按钮的点击事件
 */
- (void)rightButtonOnClicked:(UIButton *)sender;

@end

@interface HFXSearchBar : UIView
@property (weak ,nonatomic) id<HFXSearchBarDelegate> searchBarDelegate;
@end
