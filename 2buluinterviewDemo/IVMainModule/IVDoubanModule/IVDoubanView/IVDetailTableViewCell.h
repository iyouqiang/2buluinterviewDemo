//
//  IVDetailTableViewCell.h
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/29.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainPicView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleL;
@property (weak, nonatomic) IBOutlet UILabel *detailL;
@property (weak, nonatomic) IBOutlet UIImageView *leadingRoleView;
@property (weak, nonatomic) IBOutlet UIImageView *role2View;
@property (weak, nonatomic) IBOutlet UIImageView *role3View;
@property (weak, nonatomic) IBOutlet UIImageView *role4View;
@property (weak, nonatomic) IBOutlet UILabel *markL;

- (void)configureCellInfo:(NSDictionary *)dic;
@end
