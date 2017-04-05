//
//  RFDMaterialCell.m
//  RolePlay
//
//  Created by Refordom on 17/3/27.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialCell.h"
@interface RFDMaterialCell()


@end
@implementation RFDMaterialCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _mainImageView = [[UIImageView alloc] init];
        [self addSubview:_mainImageView];
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self addSubview:_titleLabel];
        _catalogueLabel = [[UILabel alloc] init];
        [self addSubview:_catalogueLabel];
        _statusLabel = [[UILabel alloc] init];
        [self addSubview:_statusLabel];
        _unitLabel = [[UILabel alloc] init];
        [self addSubview:_unitLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    self.leftFreeSpace = 5;
    [super layoutSubviews];

    _mainImageView.frame = CGRectMake(5, 5, 110, 110);
    _mainImageView.image = [UIImage imageNamed:@"example.jpg"];
    _titleLabel.frame = CGRectMake(_mainImageView.frameRight + 10, 10, SCREEN_WIDTH - _mainImageView.width - 15, 18);
    _titleLabel.text = @"090绒盒_KU_208";
    _catalogueLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.frameBottom + 20, _titleLabel.width, 15);
    _catalogueLabel.text = @"分类>半成品>胶胚>合页绒盒";
    _unitLabel.frame = CGRectMake(_titleLabel.x, _catalogueLabel.frameBottom + 10, 100, 15);
    _unitLabel.text = @"计量单位:个";
    _statusLabel.frame = CGRectMake(_unitLabel.frameRight + 5, _unitLabel.y, 150, 15);
    _statusLabel.text = @"审核状态:未审核";
}

@end
