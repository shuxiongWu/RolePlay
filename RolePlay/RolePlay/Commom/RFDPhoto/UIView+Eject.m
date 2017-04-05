//
//  UIView+Eject.m
//  图片弹出框
//
//  Created by yangyu on 16/9/7.
//  Copyright © 2016年 Wuheyou. All rights reserved.
//

#import "UIView+Eject.h"
#import "EjectView.h"

@implementation UIView (Eject)
//显示弹出框
-(void)showCategoryEjectView
{

    [self addSubview:[EjectView shareEjectView]];
    [[EjectView shareEjectView] showEjectView];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        
        [EjectView shareEjectView].frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 255, [UIScreen mainScreen].bounds.size.width, 191);
        
    }];
    
    
}
-(void)hideCategoryEjectView
{
    [[EjectView shareEjectView] removeFromSuperview];
}
@end
