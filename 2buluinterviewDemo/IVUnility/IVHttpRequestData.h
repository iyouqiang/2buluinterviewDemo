//
//  IVHttpRequestData.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/30.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkcompleteHander) (id resultValue ,NSString* errorInfo);

@interface IVHttpRequestData : NSObject

/**
 豆瓣电影
 文档API说明请访问：https://developers.douban.com/wiki/?title=movie_v2#works
 Top250API示例: https://api.douban.com/v2/movie/top250?start=0&count=15
 正在热映API示例: https://api.douban.com/v2/movie/in_theaters?start=0&count=15
 即将上映API示例: https://api.douban.com/v2/movie/coming_soon?start=0&count=15
 
 豆瓣城市列表
 文档说明访问页面：https://developers.douban.com/wiki/?title=event_v2#loc_list
 API示例:https://api.douban.com/v2/loc/list?start=0&count=20
 
 苍老师主页图片地址：https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=3d55cb20da00baa1ae214fe92679d277/d1160924ab18972b766f0606edcd7b899f510aa0.jpg

 */

/** top250 */
+ (void)request_top250start:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander;

/** 正在上映 */
+ (void)request_hotstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander;

/** 即将上映 */
+ (void)request_comingstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander;

/** 获取城市列表 */
+ (void)request_cityListstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander;

/** sora图片 */
+ (void)request_imageurl:(NSString *)imageurl completeHandle:(NetworkcompleteHander)networkcompleteHander;

@end
