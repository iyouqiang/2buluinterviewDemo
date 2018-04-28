//
//  IVDoubanViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVDoubanViewController.h"
#import "IVDoubanView.h"

@implementation IVDoubanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"主页";

    /** APP首页 */
    IVDoubanView *doubanView = [[IVDoubanView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:doubanView];
}

@end
