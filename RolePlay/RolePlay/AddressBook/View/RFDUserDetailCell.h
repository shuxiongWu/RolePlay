//
//  RFDUserDetailCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"
#import "RFDUserModel.h"

typedef NS_ENUM(NSInteger, UserDetailCellType) {
    UserDetailCellTypeFriends,
    UserDetailCellTypeMine,
};
@interface RFDUserDetailCell : RFDTableViewCell
@property (nonatomic, assign) UserDetailCellType cellType;

@property (nonatomic, strong) RFDUserModel *user;
@end
