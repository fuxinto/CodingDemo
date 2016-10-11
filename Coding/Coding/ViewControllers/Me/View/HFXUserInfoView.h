//
//  HFXUserInfoView.h
//  Coding
//
//  Created by tens04 on 16/10/8.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#import "HFXTapImageView.h"
#import "HFXUserInfoModel.h"
@interface HFXUserInfoView : HFXTapImageView
@property (strong, nonatomic) HFXUserInfoModel *userInfo;
@property (strong, nonatomic) UIImage *backgroundImage;


- (void)refreshData;
+ (instancetype)createWithUserInfo:(HFXUserInfoModel *)user backgroundImage:(UIImage *)backgroundImage;
@end
