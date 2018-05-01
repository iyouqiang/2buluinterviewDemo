//
//  ViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 定义一个数组，存放加载图片的事件 */

@property (nonatomic,strong) NSMutableArray *tasks;

/** 最大任务数，因为我们一个屏幕可能就显示20张图片，这个数不确定，看你自己设置cell的高度了，如果你一个cell上放2个图片，一个屏幕上就能看到2个cell，那你的最大数就是4 */

@property(assign,nonatomic)NSUInteger max;

/**添加一个timer，可以一直让runloop处于唤醒状态，并且处于NSDefaultRunLoopMode模式，这样就可以不断绘制图片*/

@property(nonatomic,strong)NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
