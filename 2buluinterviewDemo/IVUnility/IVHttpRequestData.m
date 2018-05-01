//
//  IVHttpRequestData.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/30.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVHttpRequestData.h"
#import "IVHttpRequestManager.h"

@implementation IVHttpRequestData

/** top250 */
+ (void)request_top250start:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander
{
    NSString *index = [NSString stringWithFormat:@"%ld", (long)start];
    NSString *offset = [NSString stringWithFormat:@"%ld", (long)count];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:index forKey:@"start"];
    [para setValue:offset forKey:@"count"];
    
    [IVHttpRequestManager requestHttpMethod:HTTP_GET requestURL:@"https://api.douban.com/v2/movie/top250" parameters:para completeHander:^(id resultValue, NSError *errorInfo) {
       
        if (networkcompleteHander) {
            
            networkcompleteHander(resultValue, errorInfo.description);
        }
    }];
}

/** 正在上映 */
+ (void)request_hotstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander
{
    NSString *index = [NSString stringWithFormat:@"%ld", (long)start];
    NSString *offset = [NSString stringWithFormat:@"%ld", (long)count];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:index forKey:@"start"];
    [para setValue:offset forKey:@"count"];
    
    [IVHttpRequestManager requestHttpMethod:HTTP_GET requestURL:@"https://api.douban.com/v2/movie/in_theaters" parameters:para completeHander:^(id resultValue, NSError *errorInfo) {
        
        if (networkcompleteHander) {
            
            networkcompleteHander(resultValue, errorInfo.description);
        }
    }];
}

/** 即将上映 */
+ (void)request_comingstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander
{
    NSString *index = [NSString stringWithFormat:@"%ld", (long)start];
    NSString *offset = [NSString stringWithFormat:@"%ld", (long)count];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:index forKey:@"start"];
    [para setValue:offset forKey:@"count"];
    
    [IVHttpRequestManager requestHttpMethod:HTTP_GET requestURL:@"https://api.douban.com/v2/movie/coming_soon" parameters:para completeHander:^(id resultValue, NSError *errorInfo) {
        
        if (networkcompleteHander) {
            
            networkcompleteHander(resultValue, errorInfo.description);
        }
    }];
}

/** 获取城市列表 */
+ (void)request_cityListstart:(NSInteger)start count:(NSInteger)count completeHandle:(NetworkcompleteHander)networkcompleteHander
{
    NSString *index = [NSString stringWithFormat:@"%ld", (long)start];
    NSString *offset = [NSString stringWithFormat:@"%ld", (long)count];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:index forKey:@"start"];
    [para setValue:offset forKey:@"count"];

    [IVHttpRequestManager requestHttpMethod:HTTP_GET requestURL:@"https://api.douban.com/v2/loc/list" parameters:para completeHander:^(id resultValue, NSError *errorInfo) {
        
        if (networkcompleteHander) {
            
            networkcompleteHander(resultValue, errorInfo.description);
        }
    }];
}

+ (void)request_imageurl:(NSString *)imageurl completeHandle:(NetworkcompleteHander)networkcompleteHander
{
    /** 文件是否存在 */
    NSString *caches = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [caches stringByAppendingPathComponent:[imageurl lastPathComponent]];
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    if ([mgr fileExistsAtPath:file]) {
        networkcompleteHander(file, nil);
        NSLog(@"数据已缓存");
        return;
    }
    
    NSLog(@"下载图片");
    [IVHttpRequestManager requestImageData:imageurl loadprogress:^(CGFloat downloadProgress) {
        
    } completeHander:^(id resultValue, NSError *errorInfo) {
       
        if (networkcompleteHander) {
            
            networkcompleteHander(resultValue, errorInfo.description);
        }
    }];
}

@end
