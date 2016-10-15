//
//  HFXBaseTableViewCell.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFXBaseTableViewCell : UITableViewCell

/*
 * 加载子View
 */
- (void)cellDidLoadSubView;

/*
 * 调整布局
 */
- (void)cellDidAdjustAutoLayout;

@end
