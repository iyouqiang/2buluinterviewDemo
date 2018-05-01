//
//  IVDoubanView.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVDoubanView.h"
#import "IVDefinitionMacro.h"

@interface IVDoubanView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *pushArray;

@end

@implementation IVDoubanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:self.bounds];
        mainTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        [self addSubview:mainTableView];
        
        _dataArray = @[
                       @{@"movie":@[@"top250", @"正在热映", @"即将上映"]},
                       @{@"other":@[@"苍老师主页", @"苍老师相册", @"测试VC", @"城市列表"]}
                       ];
    }

    return self;
}

#pragma mark - TableView delegate/datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentify];
        cell.textLabel.font = Font_Normal(17);
        cell.detailTextLabel.font = Font_Normal(13);
        
        if (indexPath.section == 0) {
        
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = Color_Green;
            cell.tintColor = Color_BackgroundColor;
        }else {
        
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
            cell.tintColor = Color_Green;
            cell.textLabel.textColor = Color_BluishViolet;
        }
    }
    
    NSDictionary *tempDic = _dataArray[indexPath.section];
    NSArray *temparray = nil;
    
    if (indexPath.section == 0) {
        temparray = tempDic[@"movie"];
        cell.imageView.image = [UIImage imageNamed:@"favicon_32x32.png"];
    }else {
        temparray = tempDic[@"other"];
        cell.detailTextLabel.text = indexPath.row % 2 == 0 ? @"Present vc" : @"Push vc";
        cell.imageView.image = nil;
    }
    
    cell.textLabel.text = temparray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isPresent = (indexPath.section == 1) && (indexPath.row % 2 == 0) ? YES:NO;
    
    NSInteger index = indexPath.section == 0 ? indexPath.row : [tableView numberOfRowsInSection:0] + indexPath.row;
    
    if (self.touchBlcok) {
        self.touchBlcok(index, isPresent);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 30.0f)];
    headerView.backgroundColor = Color_BackgroundColor;
    
    UILabel *headerL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kSCREENWIDTH-30, CGRectGetHeight(headerView.frame))];
    headerL.font = Font_Normal(16);
    [headerView addSubview:headerL];
    
    if (section == 0) {
        
        headerL.text = @"豆瓣电影";
    }else {
        
        headerL.text = @"其它";
    }
    
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *temDic = _dataArray[section];
    NSArray *temparray = nil;
    
    if (section == 0) {
        temparray = temDic[@"movie"];
        
    }else {
        temparray = temDic[@"other"];
    }
    
    return temparray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }else {
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
