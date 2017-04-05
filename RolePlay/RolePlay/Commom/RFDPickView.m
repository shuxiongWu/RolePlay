//
//  RFDPickView.m
//  RolePlay
//
//  Created by Refordom on 17/3/30.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDPickView.h"
@interface RFDPickView()<UIPickerViewDelegate>
{
    NSArray         *_dataSrouce;
    UILabel         *_lineLabel;
    UIButton        *_certainButton;
    UIPickerView    *_pickView;
    UIView          *_showView;
    NSString        *_cateString;
}

@end
@implementation RFDPickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + 50, SCREEN_WIDTH, 230)];
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        _pickView = pickerView;
        self.backgroundColor = RGBACOLOR(193, 193, 193, 0.3);
        _dataSrouce = @[@"商品",@"半成品",@"产成品",@"原料",@"备品"];
        [self addSubview:pickerView];
        
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 50)];
        showView.backgroundColor = [UIColor whiteColor];
        _showView = showView;
        [self addSubview:showView];
        
        _lineLabel = [[UILabel alloc] init];
        [showView addSubview:_lineLabel];
        
        _certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [showView addSubview:_certainButton];
    }
    return self;
}

-(void)layoutSubviews
{
    _lineLabel.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
    _lineLabel.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    
    _certainButton.frame = CGRectMake(SCREEN_WIDTH - 65, 0, 50, 50);
    [_certainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_certainButton setTitle:@"确定" forState:UIControlStateNormal];
    [_certainButton addTarget:self action:@selector(removePickView:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    [_pickView selectRow:(_dataSrouce.count - 1) / 2 inComponent:0 animated:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickView.y = SCREEN_HEIGHT - 230;
        _showView.y = SCREEN_HEIGHT - 280;
    }];
    
}
- (void)removePickView:(UIButton *)button
{
    if (_selectCateSuccessCallBack) {
        _selectCateSuccessCallBack(_cateString);
    }
    [self removePickViwe];
}
- (void)tap:(UIGestureRecognizer *)ges
{
    [self removePickViwe];
    
}
- (void)removePickViwe
{
    [UIView animateWithDuration:0.3 animations:^{
        _pickView.y = SCREEN_HEIGHT + 50;
        _showView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataSrouce.count;
}
- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    _cateString = _dataSrouce[row];
    return _cateString;
}
@end
