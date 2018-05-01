//
//  IVTop250ViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVTop250ViewController.h"
#import "IVDoubanTableAdapter.h"

@interface IVTop250ViewController ()

@property (nonatomic, strong) IVBaseTableView *top250Table;
@property (nonatomic, strong) IVDoubanTableAdapter *adapter;

@end

@implementation IVTop250ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"top250";

    IVDoubanTableAdapter *adapter = [[IVDoubanTableAdapter alloc] init];
    adapter.delegate = self;
    _adapter = adapter;
    
    _top250Table = [[IVBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _top250Table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _top250Table.showsVerticalScrollIndicator = NO;
    _top250Table.separatorColor = Color_Green;
    _top250Table.delegate   = adapter;
    _top250Table.dataSource = adapter;
    [self.view addSubview:_top250Table];
    
    IVWeakSelf(self);
    [self addrightNavigationItemtitle:@"刷新" textColor:Color_BluishViolet clickCallBack:^{
        IVStrongSelf(self);
        
        [self.adapter.dataArray removeAllObjects];
        [self request250Data];
    }];
    
    _top250Table.LoadMoreBlock = ^{
        IVStrongSelf(self);
        [self request250Data];
    };
    
    [self request250Data];
}

- (void)request250Data
{
    IVWeakSelf(self);
    [IVHttpRequestData request_top250start:_adapter.dataArray.count/15 count:15 completeHandle:^(id resultValue, NSString *errorInfo) {
        
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
                
                self.top250Table.footerL.text = @"没有更多数据";
                return;
            }
           
            self.top250Table.footerL.text = loadStr;
            [self.top250Table reloadData];
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
