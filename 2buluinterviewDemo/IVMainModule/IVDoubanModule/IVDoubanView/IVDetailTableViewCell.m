//
//  IVDetailTableViewCell.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/29.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVDetailTableViewCell.h"

@implementation IVDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellInfo:(NSDictionary *)dic
{
    /** 封面地址 */
    NSDictionary *movieDic = dic[@"images"];
    NSString *images_medium = movieDic[@"medium"];
    
    /** 主演 */
    NSArray *directors = dic[@"directors"];
    NSString *avatars = [directors firstObject][@"avatars"][@"medium"];
    
    NSDictionary *subDic = dic[@"rating"];
    NSString *rateaverage = [NSString stringWithFormat:@"%0.1f",[subDic[@"average"] floatValue]];
    
    NSMutableArray *iconArray = [NSMutableArray array];
    [iconArray addObject:images_medium];
    [iconArray addObject:avatars];
    
    NSArray *casts = dic[@"casts"];
    for (NSDictionary *avatars in casts) {
        NSDictionary *tempDic = avatars[@"avatars"];
        [iconArray addObject:tempDic[@"medium"]];
    }
    
    /** 异步，存储到虚拟内存 */
    [iconArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *iconurl = obj;
        const char * threadName =[iconurl UTF8String];
        dispatch_queue_t asynchronousQueue = dispatch_queue_create(threadName, NULL);
        
        __block UIImage *image = [[UIImage alloc] init];
        
        dispatch_async(asynchronousQueue, ^{
            
            NSError *error;
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl] options:NSDataReadingMappedIfSafe error:&error];
            if (imageData) {
                image = [UIImage imageWithData:imageData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (idx == 0) {
                    [_mainPicView setImage:image];
                }else if (idx == 1) {
                    [_leadingRoleView setImage:image];
                }else if (idx == 2) {
                    [_role2View setImage:image];
                }else if (idx == 3) {
                    [_role3View setImage:image];
                }else if (idx == 4) {
                    [_role4View setImage:image];
                }
            });
        });
    }];
        
    _markL.text = rateaverage;
    _mainTitleL.text = dic[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
