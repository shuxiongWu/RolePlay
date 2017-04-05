//
//  RFDDirectMaterialCell.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDDirectMaterialCell.h"
@interface RFDDirectMaterialCell()
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleButton;
@end
@implementation RFDDirectMaterialCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_editButton];
        _deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleButton];
    }
    return self;
}
-(void)layoutSubviews
{
    self.leftFreeSpace = 5;
    [super layoutSubviews];
    
    self.statusLabel.text = @"数量 10";
    _editButton.frame = CGRectMake(SCREEN_WIDTH - 55, 10, 40, 40);
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
    
    _deleButton.frame = CGRectMake(SCREEN_WIDTH - 55, _editButton.frameBottom + 20, 40, 40);
    [_deleButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
}


@end
