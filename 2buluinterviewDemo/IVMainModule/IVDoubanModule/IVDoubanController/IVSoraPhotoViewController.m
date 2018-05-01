//
//  IVSoraPhotoViewController.m
//  2buluinterviewDemo
//
//  Created by Yochi·Kung on 2018/4/28.
//  Copyright © 2018年 gongyouqiang. All rights reserved.
//

#import "IVSoraPhotoViewController.h"
#import "UIImageView+IVLoadURLImage.h"
@interface IVSoraPhotoViewController ()

@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *imageurlArray;
@end

@implementation IVSoraPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"苍老师相册";
    
    NSArray *sorapicArray = @[
                              @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike180%2C5%2C5%2C180%2C60/sign=24fcaed30c0828387c00d446d9f0c264/472309f790529822718d3c0fdcca7bcb0b46d4bb.jpg",
                              @"https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike220%2C5%2C5%2C220%2C73/sign=b501aead04b30f242197e451a9fcba26/728da9773912b31b7ed9c8e58d18367adbb4e141.jpg",
                              @"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=e0ad791125738bd4d02cba63c0e2ecb3/4a36acaf2edda3cc46c0beec0ae93901203f92d1.jpg"];
    
    _imageurlArray = [NSMutableArray arrayWithArray:sorapicArray];
    _imageViewArray = [NSMutableArray array];
    
    UILabel *descriptionL = [[UILabel alloc] initWithFrame:CGRectMake(0,  kNAVIGATIONHEIGHT, kSCREENWIDTH, 40.0)];
    descriptionL.textAlignment = NSTextAlignmentCenter;
    descriptionL.font = Font_Normal(18);
    descriptionL.textColor = Color_Green;
    descriptionL.text = @"我的私密照";
    [self.view addSubview:descriptionL];
    
    CGFloat rowNumber = 2;
    CGFloat gapWidth  = 20;
    CGFloat imgWidth = (kSCREENWIDTH-gapWidth*(rowNumber+1))/rowNumber;
    CGFloat imgHeight = (kSCREENHEIGHT-kNAVIGATIONHEIGHT-100)/2.0f;
    
    /** 界面布局 */
    for (int i = 0, j = 0, h = 0;i<sorapicArray.count;i++, j++) {
    
        UIImage *image = [UIImage imageNamed:@"placeHolderImage.jpg"];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        imgView.backgroundColor = Color_ImgFillColor;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imgView];
        [_imageViewArray addObject:imgView];
    
        if (i%2==0&&i!=0) {
            j = 0;
            h++;
        }
        imgView.frame = CGRectMake(gapWidth*(1+j)+j*imgWidth , CGRectGetMaxY(descriptionL.frame)+h*(imgHeight+gapWidth), imgWidth, imgHeight);
    
        if (sorapicArray.count%2!=0 && sorapicArray.count-1==i) {
            
            imgView.frame = CGRectMake(gapWidth*(1+j)+j*imgWidth , CGRectGetMaxY(descriptionL.frame)+h*(imgHeight+gapWidth), kSCREENWIDTH-40, imgHeight);
        }
    }
    /** 加载网络图片 */
    [self loadsorImg];
}

- (void)loadsorImg
{
    [_imageurlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSString *iconurl = obj;
        const char * threadName =[iconurl UTF8String];
        dispatch_queue_t asynchronousQueue = dispatch_queue_create(threadName, NULL);
        
        __block UIImage *image = [[UIImage alloc] init];
        
        dispatch_async(asynchronousQueue, ^{
        
            NSError *error;
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl] options:NSDataReadingMappedIfSafe error:&error];
            if (imageData) {
                image = [UIImage imageWithData:imageData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{

                UIImageView *imageView = _imageViewArray[idx];
                imageView.backgroundColor = [UIColor whiteColor];
                imageView.image = image;
            });
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
