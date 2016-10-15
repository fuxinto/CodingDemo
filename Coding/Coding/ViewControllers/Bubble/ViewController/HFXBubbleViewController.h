//
//  HFXBubbleViewController.h
//  Coding
//
//  Created by tens04 on 16/10/12.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXBaseViewController.h"

typedef NS_ENUM(NSInteger,BubbleType) {
    BubbleTypeDefault = 0,
    BubbleTypeFriend ,
    BubbleTypeHot,
    
};

@interface HFXBubbleViewController : HFXBaseViewController
@property (assign, nonatomic) BubbleType bubbletype;
@end
