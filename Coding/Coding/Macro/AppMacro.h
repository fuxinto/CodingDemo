//
//  AppMacro.h
//  Coding
//
//  Created by tens04 on 16/9/27.
//  Copyright © 2016年 fuxinto. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

// release 模式下删除NSLog
#ifdef DEBUG
#else
#define NSLog(...)
#endif


#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

#define kWindow ([UIApplication sharedApplication].keyWindow)

#endif /* AppMacro_h */
