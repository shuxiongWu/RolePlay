//
//  EjectView.m
//  图片弹出框
//
//  Created by yangyu on 16/9/7.
//  Copyright © 2016年 Wuheyou. All rights reserved.
//

#import "EjectView.h"
@interface EjectView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) UIViewController *vc;

@property(nonatomic, strong) void (^resultBlock)(UIImage *image);
@property(nonatomic, strong) void (^cancelBlock)(NSInteger);
@property (nonatomic,strong) UIImageView *imgView;

@end
@implementation EjectView



+ (EjectView *)shareEjectView;
{
    static EjectView * shareEjectView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareEjectView = [[EjectView alloc] init];
    });
    return shareEjectView;
}

//显示弹出框
-(void)showEjectView
{
    
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 191);
    self.backgroundColor = [UIColor grayColor];

    [self createButton];
}
//创建按钮
- (void)createButton
{
    NSArray *arr = @[@"拍照",@"从手机相册选择",@"取消"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, self.frame.size.width,60);
        if (i == 1) {
           btn.frame = CGRectMake(0, 61, self.frame.size.width, 60);
        }
        if (i == 2) {
            btn.frame = CGRectMake(0, 131, self.frame.size.width, 60);
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(btnClicket:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self addSubview:btn];

    }

}

//点击事件
-(void)btnClicket: (UIButton *)button
{
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (button.tag == 102) {
            
            self.cancelBlock (_index);
        }else if (button.tag == 100){
            [self createPhotoVC];
            self.cancelBlock (_index ++);
        }else
        {
            [self createPhoto];
            self.cancelBlock (_index ++);
        }
    });
    [button setBackgroundColor:[UIColor grayColor]];
    
    
}


- (void)cameraSheetInController:(UIViewController *)vc
                        handler:(void (^)(UIImage *image ))block cancelHandler:(void (^)(NSInteger index))cancelBlock
{
    
    self.vc = vc;
    self.resultBlock = block;
    self.cancelBlock = cancelBlock;
    
    
}
-(void)createPhotoVC
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //设置是相机
        UIImagePickerController *pickImageVC = [[UIImagePickerController alloc] init];
        pickImageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickImageVC.delegate = self;
        [self.vc presentViewController:pickImageVC animated:YES completion:nil];
    }else
    {
        NSLog(@"无摄像头");
    }
}
-(void)createPhoto
{
    //设置是相册
    UIImagePickerController *pickImageVC = [[UIImagePickerController alloc] init];
    pickImageVC.delegate = self;
    [self.vc presentViewController:pickImageVC animated:YES completion:nil];
}

//相机的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    self.resultBlock(img);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
