//
//  RFDDirectManualCell.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDDirectManualCell.h"

@implementation RFDDirectManualCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _billtype = [[UILabel alloc] init];
        [self addSubview:_billtype];
        _organize = [[UILabel alloc] init];
        [self addSubview:_organize];
        _labourCost = [[UILabel alloc] init];
        [self addSubview:_labourCost];
        _number = [[UILabel alloc] init];
        [self addSubview:_number];
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_editButton];
        _deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_deleButton];
    }
    return self;
}
-(void)layoutSubviews
{
    self.leftFreeSpace = 15;
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 0, 200, 50);
    _titleLabel.text = @"合页—吹风";
    
    _billtype.frame = CGRectMake(15, _titleLabel.frameBottom - 10, 150, 40);
    _billtype.text = @"计费类型";
    _billtype.textColor = DEFAULT_TEXT_GRAY_COLOR;
    
    _organize.frame = CGRectMake(_billtype.frameRight, _billtype.y, _billtype.width, _billtype.height);
    _organize.text = @"组织:合页部";
    _organize.textColor = DEFAULT_TEXT_GRAY_COLOR;
    
    _labourCost.frame = CGRectMake(_billtype.x,_billtype.frameBottom - 10, _billtype.width, _billtype.height);
    _labourCost.text = @"工价:10";
    _labourCost.textColor = DEFAULT_TEXT_GRAY_COLOR;
    
    _number.frame = CGRectMake(_billtype.frameRight, _labourCost.y, _billtype.width, _billtype.height);
    _number.text = @"数量 10";
    _number.textColor = DEFAULT_TEXT_GRAY_COLOR;
    
    _editButton.frame = CGRectMake(SCREEN_WIDTH - 55, 10, 40, 40);
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
    
    _deleButton.frame = CGRectMake(SCREEN_WIDTH - 55, _editButton.frameBottom + 20, 40, 40);
    [_deleButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
}
@end
