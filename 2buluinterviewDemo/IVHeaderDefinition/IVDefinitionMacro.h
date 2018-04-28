//
//  IVDefinitionMacro.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#ifndef IVDefinitionMacro_h
#define IVDefinitionMacro_h

/** 屏幕适配 */
#define kDeviceiPhoneX \
([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kNAVIGATIONHEIGHT (kDeviceiPhoneX ? 88.0 : 64.0)
#define kTABBARHEIGHT (kDeviceiPhoneX ? 83 : 49.0)

#define kSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define kSCREENWIDTH  [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_SIZE  [UIScreen mainScreen].bounds.size

/** 强弱引用 */
#define ECWeakSelf(type)    __weak typeof(type) weak##type = type;
#define ECStrongSelf(type)  __strong typeof(type) type = weak##type;

/** NSlog定义 */
#ifdef DEBUG

#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else

#define NSLog(...)

#endif

#endif /* IVDefinitionMacro_h */
