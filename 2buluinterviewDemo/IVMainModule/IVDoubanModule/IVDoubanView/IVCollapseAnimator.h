//
//  IVCollapseAnimator.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/5/1.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IVCollapseAnimator : NSObject

<UIViewControllerAnimatedTransitioning>

/**
 *  转场持续时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  碎片大小
 */
@property (nonatomic, assign) NSInteger sideLength;

@end
