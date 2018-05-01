//
//  IVBaseTableView.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/30.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVBaseTableView : UITableView

@property (nonatomic, strong) UILabel *footerL;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) BOOL isLoadAnimation;
@property (nonatomic, strong) void(^LoadMoreBlock)(void);

@end
