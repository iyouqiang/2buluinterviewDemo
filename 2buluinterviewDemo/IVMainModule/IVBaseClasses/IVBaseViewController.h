//
//  IVBaseViewController.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVStyleSheet.h"

@interface IVBaseViewController : UIViewController

/** 右侧添加导航栏按钮 */
- (UIButton *)addrightNavigationItemtitle:(NSString *)title textColor:(UIColor*)textColor clickCallBack:(void(^)(void))clickCallBackBlock;

@end
