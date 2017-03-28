//
//  RFDSiftView.m
//  RolePlay
//
//  Created by Refordom on 17/3/28.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDSiftView.h"
@interface RFDSiftView()
{
    UIView *_showView;
}
@end
@implementation RFDSiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(193, 193, 193, 0.3);
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    [self addGes];
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH - 120, SCREEN_HEIGHT)];
    showView.backgroundColor = [UIColor whiteColor];
    _showView = showView;
    [self addSubview:showView];
    [UIView animateWithDuration:0.3 animations:^{
        showView.x = 120;
    }];
    
    UIButton *replaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replaceButton.frame = CGRectMake(0, SCREEN_HEIGHT - 50, showView.width / 2, 50);
    replaceButton.backgroundColor = RGBACOLOR(204, 204, 204, 1);
    [replaceButton addTarget:self action:@selector(replace:) forControlEvents:UIControlEventTouchUpInside];
    [replaceButton setTitle:@"重置" forState:UIControlStateNormal];
    [showView addSubview:replaceButton];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(showView.width / 2, SCREEN_HEIGHT - 50, showView.width / 2, 50);
    finishButton.backgroundColor = RGBACOLOR(105, 155, 202, 1);
    [finishButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [showView addSubview:finishButton];
    
}
- (void)replace:(UIButton *)buttton
{
    
}
- (void)finish:(UIButton *)button
{
    [self removeSelf];
}
- (void)addGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}
-(void)tap:(UIGestureRecognizer *)ges
{
    [self removeSelf];
}
- (void)removeSelf
{
    [UIView animateWithDuration:0.3 animations:^{
        _showView.x = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
