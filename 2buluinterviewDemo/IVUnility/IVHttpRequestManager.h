//
//  IVHttpRequestManager.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVHttpRequestTool.h"

@interface IVHttpRequestManager : NSObject

+ (instancetype)shareRequestManager;

/** get/post 请求 */
+ (void)requestHttpMethod:(HTTPREQUESTMETHOD)httpMethod
                  requestURL:(NSString *)requestURL
               parameters:(NSMutableDictionary *)parameters
           completeHander:(RequestcompleteHander)completeHander;

/** 加载网络图片 */
+ (void)requestImageData:(NSString *)requestURL loadprogress:(DownloadProgressBlock)loadProgressBlock completeHander:(RequestcompleteHander)completeHander;

@end
