//
//  IVBaseViewController.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVDefinitionMacro.h"
#import "IVNavigationViewController.h"
#import "IVHttpRequestData.h"
#import "IVBaseTableView.h"

@interface IVBaseViewController : UIViewController

/** 导航栏  右侧添加按钮 */
- (UIButton *)addrightNavigationItemtitle:(NSString *)title textColor:(UIColor*)textColor clickCallBack:(void(^)(void))clickCallBackBlock;

/** 导航栏  左侧添加按钮 */
- (UIButton *)addLeftNavigationItemtitle:(NSString *)title textColor:(UIColor*)textColor clickCallBack:(void(^)(void))clickCallBackBlock;

@end
