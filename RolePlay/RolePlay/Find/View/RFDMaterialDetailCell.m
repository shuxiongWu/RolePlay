//
//  RFDMaterialDetailCell.m
//  RolePlay
//
//  Created by Refordom on 17/3/29.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialDetailCell.h"
@interface RFDMaterialDetailCell ()

@end
@implementation RFDMaterialDetailCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cateLabel = [[UILabel alloc] init];
        [self addSubview:_cateLabel];
        _statusLabel = [[UILabel alloc] init];
        [self addSubview:_statusLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    self.leftFreeSpace = 15;
    [super layoutSubviews];
    
    _cateLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH, self.height);
    _statusLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH - 35, self.height);
    _statusLabel.textAlignment = NSTextAlignmentRight;
}

@end
