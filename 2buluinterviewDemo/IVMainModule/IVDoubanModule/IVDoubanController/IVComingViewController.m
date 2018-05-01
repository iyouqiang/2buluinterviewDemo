//
//  IVComingViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVComingViewController.h"
#import "IVDoubanTableAdapter.h"

@interface IVComingViewController ()

@property (nonatomic, strong) IVBaseTableView *comingTable;
@property (nonatomic, strong) IVDoubanTableAdapter *adapter;

@end

@implementation IVComingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"即将上映";
    
    IVDoubanTableAdapter *adapter = [[IVDoubanTableAdapter alloc] init];
    adapter.delegate = self;
    _adapter = adapter;
    
    _comingTable = [[IVBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _comingTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _comingTable.showsVerticalScrollIndicator = NO;
    _comingTable.separatorColor = Color_BluishViolet;
    _comingTable.delegate   = adapter;
    _comingTable.dataSource = adapter;
    [self.view addSubview:_comingTable];
    
    IVWeakSelf(self);
    [self addrightNavigationItemtitle:@"刷新" textColor:Color_BluishViolet clickCallBack:^{
        IVStrongSelf(self);
        
        [self.adapter.dataArray removeAllObjects];
        [self requestComingData];
    }];
    
    _comingTable.LoadMoreBlock = ^{
        IVStrongSelf(self);
        [self requestComingData];
    };
    
    [self requestComingData];
}

- (void)requestComingData
{
    IVWeakSelf(self);
    [IVHttpRequestData request_comingstart:_adapter.dataArray.count/15 count:15 completeHandle:^(id resultValue, NSString *errorInfo) {
       
        IVStrongSelf(self);
        
        if (errorInfo) {
            
            NSLog(@"获取数据失败");
            return ;
        }
        
        NSDictionary *resultDic = resultValue;
        [self.adapter.dataArray addObjectsFromArray:resultDic[@"subjects"]];
        NSString *total = resultDic[@"total"];
        
        NSString *loadStr = [NSString stringWithFormat:@"点击加载15条数据(%lu条已加载)",(unsigned long)self.adapter.dataArray.count];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.adapter.dataArray.count == [total integerValue]) {
                
                self.comingTable.footerL.text = @"没有更多数据";
                return;
            }
            
            self.comingTable.footerL.text = loadStr;
            [self.comingTable reloadData];
        });
    }];
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
