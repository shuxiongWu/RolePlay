//
//  RFDMaterialEditCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/29.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"

@interface RFDMaterialEditCell : RFDTableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *catalogueLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIButton *selectButton;
@end
