//
//  IVTestViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVTestViewController.h"

@interface IVTestViewController ()

@end

@implementation IVTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试VC";
    
    IVWeakSelf(self);
    [self addLeftNavigationItemtitle:@"关闭" textColor:Color_BluishViolet clickCallBack:^{
        IVStrongSelf(self);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UILabel *descriptionL = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, kSCREENWIDTH, 40.0)];
    descriptionL.center = self.view.center;
    descriptionL.textAlignment = NSTextAlignmentCenter;
    descriptionL.font = Font_Normal(18);
    descriptionL.textColor = Color_Green;
    descriptionL.text = @"我用来测试";
    [self.view addSubview:descriptionL];
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
