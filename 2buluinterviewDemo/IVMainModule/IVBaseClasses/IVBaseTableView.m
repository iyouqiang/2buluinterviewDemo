//
//  IVBaseTableView.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/30.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVBaseTableView.h"
#import "IVDefinitionMacro.h"

@implementation IVBaseTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadfooterView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        [self loadfooterView];
        _isLoadAnimation = YES;
    }
    
    return self;
}

- (void)loadCellAnimation
{
    for (UITableViewCell *cell in self.visibleCells) {
        cell.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    }
    
    for (int i = 0; i<self.visibleCells.count; i++) {
        UITableViewCell *cell = self.visibleCells[i];
        CGFloat cellDelay = 0.05 *i;
        
        [UIView animateWithDuration:0.5 delay:cellDelay usingSpringWithDamping:0.95 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)reloadData
{
    [super reloadData];
    
    if (_isLoadAnimation) {
     
        [self loadCellAnimation];
    }
}

- (void)loadfooterView
{
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44.0f)];
    _footerL = [[UILabel alloc] initWithFrame:_footerView.bounds];
    _footerL.font = Font_Bold(16);
    _footerL.textColor = Color_Green;
    _footerL.textAlignment = NSTextAlignmentCenter;
    _footerL.text = @"正在加载数据...";
    [_footerView addSubview:_footerL];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMoreData)];
    [_footerView addGestureRecognizer:tap];
    
    self.tableFooterView = _footerView;
}

- (void)loadMoreData
{
    if (_LoadMoreBlock) {
        
        _LoadMoreBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
