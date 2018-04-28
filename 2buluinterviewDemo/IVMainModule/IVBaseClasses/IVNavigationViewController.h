//
//  IVNavigationViewController.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVNavigationViewController : UINavigationController

/** 禁止拖动手势 */
- (void)isForbiddingDragPop;

/** 可以拖动 */
- (void)isCanDragPop;

@end
