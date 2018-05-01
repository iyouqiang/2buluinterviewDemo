//
//  IVSoraMainViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVSoraMainViewController.h"
#import "UIImageView+IVLoadURLImage.h"
@interface IVSoraMainViewController ()

@property (nonatomic, strong) UIImageView *soraImageView;

@end

@implementation IVSoraMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"苍老师主页";
    
    IVWeakSelf(self);
    [self addLeftNavigationItemtitle:@"关闭" textColor:Color_BluishViolet clickCallBack:^{
        IVStrongSelf(self);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    _soraImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREENWIDTH-250.0)/2.0, kNAVIGATIONHEIGHT, 250, 333)];
    _soraImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_soraImageView];
    
    UILabel *descriptionL = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(_soraImageView.frame), kSCREENWIDTH, 40.0)];
    descriptionL.textAlignment = NSTextAlignmentCenter;
    descriptionL.font = Font_Normal(18);
    descriptionL.textColor = Color_Green;
    descriptionL.text = @"欢迎访问我的主页，我是苍老师";
    [self.view addSubview:descriptionL];
    
    /** 获取图片 */
    [self.soraImageView setImageURLStr:@"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=3d55cb20da00baa1ae214fe92679d277/d1160924ab18972b766f0606edcd7b899f510aa0.jpg"];
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
