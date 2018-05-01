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
@property (nonatomic, copy) void(^leftNavigationItemBlock)(void);

@end

@implementation IVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationBar];
}

- (void)configureNavigationBar
{
    /** 导航栏颜色 */
    self.navigationController.navigationBar.barTintColor = Color_Green;
    self.navigationController.navigationBar.tintColor = Color_BluishViolet;
    
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
    
    return [self addnavigationItemTitle:title
                              textcolor:textColor event:@selector(rightNavigationBarItemAction:)
                                 isLeft:NO];
}

/** 左侧添加导航栏按钮 */
- (UIButton *)addLeftNavigationItemtitle:(NSString *)title textColor:(UIColor*)textColor clickCallBack:(void(^)(void))clickCallBackBlock
{
    if (!title || title.length == 0) {
        return nil;
    }
    
    if (clickCallBackBlock) {
        _leftNavigationItemBlock = clickCallBackBlock;
    }
    
    return [self addnavigationItemTitle:title
                              textcolor:textColor event:@selector(leftNavigationBarItemAction:)
                                 isLeft:YES];
}

- (UIButton *)addnavigationItemTitle:(NSString *)title textcolor:(UIColor *)textColor event:(SEL)itemEvent isLeft:(BOOL)isLeft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 40.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: button.titleLabel.font} context:nil].size;
    button.frame = CGRectMake(0, 0, size.width + 10, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:itemEvent forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    if (textColor) {
        
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }else {
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *navbarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    if (isLeft) {
     
        self.navigationItem.leftBarButtonItem = navbarItem;
    }else {
        self.navigationItem.rightBarButtonItem = navbarItem;
    }
    
    /** 返回button,供外部使用 */
    return button;
}

- (void)rightNavigationBarItemAction:(UIButton *)sender
{
    if (_rightNavigationItemBlock) {

        _rightNavigationItemBlock();
    }
}

- (void)leftNavigationBarItemAction:(UIButton *)sender
{
    if (_leftNavigationItemBlock) {
        
        _leftNavigationItemBlock();
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
