//
//  HFXTapImageView.h
//  Coding
//
//  Created by tens04 on 16/9/28.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFXTapImageView : UIImageView

@property (strong, nonatomic) void (^handleTapBlock)(HFXTapImageView *imageView);

@end
