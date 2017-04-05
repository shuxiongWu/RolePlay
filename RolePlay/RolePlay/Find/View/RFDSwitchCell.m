//
//  RFDSwitchCell.m
//  RolePlay
//
//  Created by Refordom on 17/3/30.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDSwitchCell.h"

@implementation RFDSwitchCell

- (void)layoutSubviews{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.topLineStyle = CellLineStyleNone;
    self.bottomLineStyle = CellLineStyleDefault;
    [super layoutSubviews];
}

@end
