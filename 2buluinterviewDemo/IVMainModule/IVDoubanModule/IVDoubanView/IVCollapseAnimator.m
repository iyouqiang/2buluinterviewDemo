//
//  IVCollapseAnimator.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/5/1.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVCollapseAnimator.h"

@implementation IVCollapseAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _duration = _duration ? : 1;
    
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _sideLength = _sideLength ? : 10;
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView      = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView        = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    /** 截取一张视图 */
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    /** 获取横、纵两轴抽样点 抽样间隔为10 */
    NSMutableArray *xSampleArray = [[NSMutableArray alloc] init];
    NSMutableArray *ySampleArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < fromView.bounds.size.width; i = i + _sideLength) {
        
        [xSampleArray addObject:@(i)];
    }
    
    for (NSInteger i = 0; i < fromView.bounds.size.height; i = i + _sideLength) {
        
        [ySampleArray addObject:@(i)];
    }
    
    /** 根据抽样点切割 */
    NSMutableArray *snapshots = [[NSMutableArray alloc] init];
    
    for (NSNumber *x in xSampleArray) {
        
        for (NSNumber *y in ySampleArray) {
            
            CGRect snapshotRegion = CGRectMake([x doubleValue], [y doubleValue], _sideLength, _sideLength);
            
            /** 分割截取的那张图 */
            UIView *snapshot      = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            
            snapshot.frame        = snapshotRegion;
            
            [containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    [containerView sendSubviewToBack:fromView];
    
    [UIView animateWithDuration:_duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         for (UIView *view in snapshots) {
                             
                             // 相对于源矩形原点（左上角的点）沿x轴和y轴偏移
                             view.frame = CGRectOffset(view.frame, [self randomRange:200 offset:-100], [self randomRange:200 offset:fromView.frame.size.height]);
                         }
                         
                     } completion:^(BOOL finished) {
                         
                         for (UIView *view in snapshots) {
                             
                             [view removeFromSuperview];
                         }
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (CGFloat)randomRange:(NSInteger)range offset:(NSInteger)offset {
    
    return (CGFloat)(arc4random()%range + offset);
}

@end
