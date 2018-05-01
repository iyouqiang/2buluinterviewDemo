//
//  UIImageView+IVLoadURLImage.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/5/1.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "UIImageView+IVLoadURLImage.h"
#import "IVHttpRequestData.h"
#import "IVDefinitionMacro.h"
@implementation UIImageView (IVLoadURLImage)

- (void)setImageURLStr:(NSString *)imgurl
{
    NSLog(@"__%p__", self);
    
    [IVHttpRequestData request_imageurl:imgurl completeHandle:^(id resultValue, NSString *errorInfo) {
        
        if (errorInfo) {
            NSLog(@"加载图片失败");
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"__%p__", self);
            self.image = [UIImage imageWithContentsOfFile:resultValue];
        });
    }];
}

@end
