//
//  IVNavigationViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVNavigationViewController.h"

@interface IVNavigationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isCanDrag;

@end

@implementation IVNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    id target = self.interactivePopGestureRecognizer.delegate;
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.edges = UIRectEdgeLeft;

    pan.delegate = self;

    [self.view addGestureRecognizer:pan];

    self.interactivePopGestureRecognizer.enabled = YES;
}

/** 禁止拖动手势 */
- (void)isForbiddingDragPop
{
    self.isCanDrag = NO;
}

- (void)isCanDragPop
{
    self.isCanDrag = YES;
}

- (void)handleNavigationTransition:(UIGestureRecognizer *)recoginzer{

    NSLog(@"我被拖动了");
}

// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1 || (!_isCanDrag)) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
