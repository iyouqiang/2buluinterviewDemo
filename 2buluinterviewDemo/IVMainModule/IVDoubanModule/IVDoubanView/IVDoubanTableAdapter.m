//
//  IVDoubanTableAdapter.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVDoubanTableAdapter.h"
#import "IVDetailTableViewCell.h"
#import "IVSimpleTableViewCell.h"
#import "IVDefinitionMacro.h"

@interface IVDoubanTableAdapter ()


@end

@implementation IVDoubanTableAdapter

/** 使用适配器模式进行模块区分，兼容差异化样式和功能 */
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - baseAdapter delegate

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        
        return  [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
        
    }else {
        
        NSString *cellIdentifier;
        Class cellClass;
        
        NSDictionary *tempDic = _dataArray[indexPath.row];
        NSInteger ratetrail   = [self requireratetail:indexPath];
        
        switch (ratetrail%2) {
            case 0:
                {
                    cellClass = [IVDetailTableViewCell class];
                }
                break;
            case 1:
                {
                    cellClass = [IVSimpleTableViewCell class];
                }
                break;
            }
    
        cellIdentifier = NSStringFromClass(cellClass);
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            
            if ([cellIdentifier isEqualToString:@"IVDetailTableViewCell"]) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"IVDetailTableViewCell" owner:nil options:nil] lastObject];
            }else if ([cellIdentifier isEqualToString:@"IVSimpleTableViewCell"]) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"IVSimpleTableViewCell" owner:nil options:nil] lastObject];
            }else {
                
                cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
    
        /** 配置数据 */
        [cell performSelector:@selector(configureCellInfo:) withObject:tempDic];
        
        return cell;
    }
}

- (NSInteger)requireratetail:(NSIndexPath *)indexPath
{
    NSDictionary *tempDic = _dataArray[indexPath.row];
    NSDictionary *subDic = tempDic[@"rating"];
    NSString *rateaverage = [NSString stringWithFormat:@"%2f",[subDic[@"average"] floatValue] * 10];
    
    return  [rateaverage integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    NSInteger rateTail = [self requireratetail:indexPath];
    
    return rateTail%2==0? kSCREENASPECT(140) : 80;
}

//实现代理方法(实现协议)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
