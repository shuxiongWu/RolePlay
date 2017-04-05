//
//  EjectView.h
//  图片弹出框
//
//  Created by yangyu on 16/9/7.
//  Copyright © 2016年 Wuheyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EjectView : UIView 

typedef void (^pickImageVC)(NSInteger tag);

@property (nonatomic,strong)    pickImageVC VCblock;
@property (nonatomic,assign)    NSInteger   index;
+ (EjectView *)shareEjectView;

-(void)showEjectView;

- (void)cameraSheetInController:(UIViewController *)vc
                        handler:(void (^)(UIImage *image ))block cancelHandler:(void (^)(NSInteger index))cancelBlock
                  ;

@end
