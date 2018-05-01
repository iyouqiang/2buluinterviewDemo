//
//  IVDoubanTableAdapter.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVDoubanTableAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray* dataArray;

@property (nonatomic,assign) id delegate;

@end
