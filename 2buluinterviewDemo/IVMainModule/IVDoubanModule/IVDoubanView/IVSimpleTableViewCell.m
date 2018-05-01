//
//  IVSimpleTableViewCell.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/29.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVSimpleTableViewCell.h"

@implementation IVSimpleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellInfo:(NSDictionary *)dic
{
    /** 封面 */
    NSDictionary *movieDic = dic[@"images"];
    NSString *images_medium = movieDic[@"medium"];
    
    /** 标签 */
    NSArray *genres = dic[@"genres"];
    NSString *genresflagStr = @"标签：";
    for (NSString *str in genres) {
        
        genresflagStr = [genresflagStr stringByAppendingString:[NSString stringWithFormat:@"%@/", str]];
    }
    /** 评分 */
    NSDictionary *subDic = dic[@"rating"];
    NSString *rateaverage = [NSString stringWithFormat:@"%0.1f",[subDic[@"average"] floatValue]];
    
    const char * threadName =[images_medium UTF8String];
    dispatch_queue_t asynchronousQueue = dispatch_queue_create(threadName, NULL);
    
    __block UIImage *image = [[UIImage alloc] init];
    
    dispatch_async(asynchronousQueue, ^{
        
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:images_medium] options:NSDataReadingMappedIfSafe error:&error];
        if (imageData) {
            image = [UIImage imageWithData:imageData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
         
            [_thumbView setImage:image];
        });
    });
  
    _markL.text = [NSString stringWithFormat:@"评分：%@",rateaverage];
    _mainTitleL.text = dic[@"title"];
    _flagL.text = genresflagStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
