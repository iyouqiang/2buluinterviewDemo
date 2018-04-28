//
//  IVHttpRequestTool.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVHttpRequestTool.h"

@implementation IVHttpRequestTool

+ (NSString *)sortparameter:(NSDictionary *)parameter
{
    NSArray* sortedKeyArray = [[parameter allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSString* key in sortedKeyArray) {
        NSString* orderItem = [self itemWithKey:key andValue:[NSString stringWithFormat:@"%@",[parameter objectForKey:key]]];

        if (orderItem.length > 0) {
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

+ (NSString*)itemWithKey:(NSString*)key andValue:(NSString*)value
{
    if (key.length > 0 && value.length > 0) {
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }

    return nil;
}

@end
