//
//  IVHttpRequestTool.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPREQUESTMETHOD)
{
    HTTP_POST,
    HTTP_GET
};

typedef void(^RequestcompleteHander)(id resultValue, NSString *errorInfo);

@interface IVHttpRequestTool : NSObject

/** 参数拼接 */
+ (NSString *)sortparameter:(NSDictionary *)parameter;

/** urlcode */


@end
