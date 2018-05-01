//
//  IVDoubanViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVDoubanViewController.h"
#import "IVDoubanView.h"
#import "IVCollapseAnimator.h"
@implementation IVDoubanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"主页";

    /** APP首页 */
    IVDoubanView *doubanView = [[IVDoubanView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:doubanView];
    
    NSArray *vcarray = @[@"IVTop250ViewController",
                         @"IVHotViewController",
                         @"IVComingViewController",
                         @"IVSoraMainViewController",
                         @"IVSoraPhotoViewController",
                         @"IVTestViewController",
                         @"IVCityListViewController"];
    
    IVWeakSelf(self);
    doubanView.touchBlcok = ^(NSInteger index, BOOL isPresent) {
        IVStrongSelf(self);
        if (vcarray.count <= index) {
            return ;
        }
        
        NSString *vcStr = vcarray[index];
        IVBaseViewController *controller = [[NSClassFromString(vcStr) alloc] init];
        
        if (isPresent) {
            IVNavigationViewController *nav = [[IVNavigationViewController alloc] initWithRootViewController:controller];
            /** sora御用 */
            nav.transitioningDelegate = index==3? self:nil;
            [self presentViewController:nav animated:YES completion:nil];
        }else {
            [self.navigationController pushViewController:controller animated:YES];
        }
    };
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    IVCollapseAnimator *animator = [[IVCollapseAnimator alloc] init];
    //animator.duration = 1;
    //animator.sideLength = 8;
    return animator;
}

@end
