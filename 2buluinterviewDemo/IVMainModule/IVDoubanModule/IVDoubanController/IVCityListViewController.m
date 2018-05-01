//
//  IVCityListViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVCityListViewController.h"
#import "IVDoubanTableAdapter.h"

@interface IVCityListViewController ()

@property (nonatomic, strong) IVBaseTableView *cityListTable;
@property (nonatomic, strong) IVDoubanTableAdapter *adapter;

@end

@implementation IVCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"城市列表";
    
    IVDoubanTableAdapter *adapter = [[IVDoubanTableAdapter alloc] init];
    adapter.delegate = self;
    _adapter = adapter;
    
    _cityListTable = [[IVBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _cityListTable.isLoadAnimation = NO;
    _cityListTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _cityListTable.showsVerticalScrollIndicator = NO;
    _cityListTable.separatorColor = Color_Green;
    _cityListTable.delegate   = adapter;
    _cityListTable.dataSource = adapter;
    [self.view addSubview:_cityListTable];
    
    IVWeakSelf(self);
    [self addrightNavigationItemtitle:@"刷新" textColor:Color_BluishViolet clickCallBack:^{
        IVStrongSelf(self);
        
        [self.adapter.dataArray removeAllObjects];
        [self requestcityListData];
    }];
    
    _cityListTable.LoadMoreBlock = ^{
        IVStrongSelf(self);
        [self requestcityListData];
    };
    
    [self requestcityListData];
}

- (void)requestcityListData
{
    IVWeakSelf(self);
    [IVHttpRequestData request_cityListstart:_adapter.dataArray.count/17 count:17 completeHandle:^(id resultValue, NSString *errorInfo) {
        
        IVStrongSelf(self);
        
        if (errorInfo) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.cityListTable.footerL.text = @"未获取到数据";
            });
            
            return ;
        }
        
        NSDictionary *resultDic = resultValue;
        [self.adapter.dataArray addObjectsFromArray:resultDic[@"locs"]];
        NSString *total = resultDic[@"total"];
        
        NSString *loadStr = [NSString stringWithFormat:@"点击加载17条数据(%lu条已加载)",(unsigned long)self.adapter.dataArray.count];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.adapter.dataArray.count == [total integerValue]) {
                
                self.cityListTable.footerL.text = @"没有更多数据";
                return;
            }
            
            self.cityListTable.footerL.text = loadStr;
            [self.cityListTable reloadData];
        });
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = Font_Normal(17);
        cell.detailTextLabel.font = Font_Normal(13);
        cell.textLabel.textColor  = Color_Green;
    }
    
    NSDictionary *tempDic = self.adapter.dataArray[indexPath.row];
    cell.textLabel.text   = tempDic[@"name"];
    cell.detailTextLabel.text = tempDic[@"uid"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
