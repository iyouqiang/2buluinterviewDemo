//
//  IVDoubanView.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^ToucheCellBlock)(NSInteger index, BOOL isPresent);

@interface IVDoubanView : UIView

@property (nonatomic,copy) ToucheCellBlock touchBlcok;

@end
