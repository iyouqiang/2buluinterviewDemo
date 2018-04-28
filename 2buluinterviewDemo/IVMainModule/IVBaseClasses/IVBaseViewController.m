//
//  IVBaseViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVBaseViewController.h"

@interface IVBaseViewController ()

@property (nonatomic, copy) void(^rightNavigationItemBlock)(void);

@end

@implementation IVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureNavigationBar];
}

- (void)configureNavigationBar
{
    /** 导航栏颜色 */
    self.navigationController.navigationBar.barTintColor = Color_Green;

    /** 设置导航栏标题 */
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: Color_BluishViolet};
}

/** 右侧添加导航栏按钮 */
- (UIButton *)addrightNavigationItemtitle:(NSString *)title textColor:(UIColor*)textColor clickCallBack:(void(^)(void))clickCallBackBlock
{
    if (!title || title.length == 0) {
        return nil;
    }

    if (clickCallBackBlock) {
        _rightNavigationItemBlock = clickCallBackBlock;
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:14];

    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 40.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: button.titleLabel.font} context:nil].size;
    button.frame = CGRectMake(0, 0, size.width + 10, 40);
    [button setTitle:title forState:UIControlStateNormal];

    [button addTarget:self action:@selector(rightNavigationBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barItem;

    [button setShowsTouchWhenHighlighted:YES];

    if (textColor) {

        [button setTitleColor:textColor forState:UIControlStateNormal];
    }else {

        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

    return button;
}

- (void)rightNavigationBarItemAction:(UIButton *)sender
{
    if (_rightNavigationItemBlock) {

        _rightNavigationItemBlock();
    }
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
