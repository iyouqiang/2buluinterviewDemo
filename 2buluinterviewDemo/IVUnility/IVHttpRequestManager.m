//
//  IVHttpRequestManager.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVHttpRequestManager.h"

@interface IVHttpRequestManager()<NSURLSessionDownloadDelegate>

@property (nonatomic, copy) DownloadProgressBlock progressBlock;
@property (nonatomic, copy) RequestcompleteHander completeBlock;

@end

@implementation IVHttpRequestManager

+ (void)requestHttpMethod:(HTTPREQUESTMETHOD)httpMethod
               requestURL:(NSString *)requestURL
               parameters:(NSMutableDictionary *)parameters
           completeHander:(RequestcompleteHander)completeHander
{
    /** 参数拼接 */
    NSString *sortStr = [IVHttpRequestTool sortparameter:parameters];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@", requestURL, sortStr];
    NSURL *httpURL = [NSURL URLWithString:[IVHttpRequestTool urlEncode:urlStr]];
    
    NSLog(@"urlStr : %@", urlStr);
    
    if (httpMethod == HTTP_GET) {
     
        [[[NSURLSession sharedSession] dataTaskWithURL:httpURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            /** 反序列化 */
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSLog(@"请求完成：%@",result);
            
            if (completeHander) {
                
                completeHander(result, error);
            }
            
        }] resume];
        
        return;
    }
    
    NSURL *postURL = [NSURL URLWithString:requestURL];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:postURL];
    request.HTTPMethod = @"POST";
    
    NSString *parameterstr = [IVHttpRequestTool sortparameter:parameters];
    request.HTTPBody = [[IVHttpRequestTool urlEncode:parameterstr] dataUsingEncoding:NSUTF8StringEncoding];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        /** 反序列化 */
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"请求完成：%@",result);
        
        if (completeHander) {
            
            completeHander(result, error);
        }
        
    }] resume];
}

/** 加载网络图片 */
+ (void)requestImageData:(NSString *)requestURL loadprogress:(DownloadProgressBlock)loadProgressBlock completeHander:(RequestcompleteHander)completeHander;
{
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:[IVHttpRequestManager shareRequestManager] delegateQueue:nil];
    [[session downloadTaskWithURL:[NSURL URLWithString:requestURL]] resume];
    
    [IVHttpRequestManager shareRequestManager].progressBlock = loadProgressBlock;
    [IVHttpRequestManager shareRequestManager].completeBlock = completeHander;
}

/** NSURLSession 监听下载进度 */

+ (instancetype)shareRequestManager
{
    static IVHttpRequestManager *requestmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        requestmanager = [[IVHttpRequestManager alloc] init];
    });
    
    return requestmanager;
}

/** 下载完成方法 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    [mgr moveItemAtPath :location.path toPath:file error : nil];
    
    if (_completeBlock) {
        
        _completeBlock(file, nil);
    }
}

/** 监听下载进度 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float) totalBytesWritten / totalBytesExpectedToWrite;
    
    if (_progressBlock) {
        _progressBlock(progress);
    }
    
    NSLog(@" %f ",progress);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        /** 回到主线程更新UI */
    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (_completeBlock && error) {
        
        /** 获取数据失败回调 */
        _completeBlock(nil, error);
    }
}

@end
