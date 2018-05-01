//
//  IVSimpleTableViewCell.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/29.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVSimpleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTitleL;
@property (weak, nonatomic) IBOutlet UILabel *markL;
@property (weak, nonatomic) IBOutlet UILabel *flagL;
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;

- (void)configureCellInfo:(NSDictionary *)dic;

@end
