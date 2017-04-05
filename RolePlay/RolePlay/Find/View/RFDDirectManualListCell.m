//
//  RFDDirectManualListCell.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDDirectManualListCell.h"

@implementation RFDDirectManualListCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_selectButton];
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _billtype = [[UILabel alloc] init];
        [self addSubview:_billtype];
        _organize = [[UILabel alloc] init];
        [self addSubview:_organize];
     }
    return self;
}
-(void)layoutSubviews
{
    self.leftFreeSpace = 15;
    [super layoutSubviews];
    
    _selectButton.frame = CGRectMake(0, 15, 50, 50);
    [_selectButton setBackgroundImage:[UIImage imageNamed:@"common_notselect"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel.frame = CGRectMake(_selectButton.frameRight, 0, 200, 50);
    _titleLabel.text = @"合页—吹风";
    
    _billtype.frame = CGRectMake(_selectButton.frameRight, _titleLabel.frameBottom - 15, 150, 40);
    _billtype.text = @"计费类型";
    _billtype.textColor = DEFAULT_TEXT_GRAY_COLOR;
    
    _organize.frame = CGRectMake(_billtype.frameRight, _billtype.y, _billtype.width, _billtype.height);
    _organize.text = @"组织:合页部";
    _organize.textColor = DEFAULT_TEXT_GRAY_COLOR;
}
- (void)edit:(UIButton *)button
{
    _selectButton.selected = !_selectButton.selected;
    if (_selectButton.selected) {
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"common_select"] forState:UIControlStateNormal];
    }else{
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"common_notselect"] forState:UIControlStateNormal];
    }
}

@end
