//
//  RFDAddressBookTableViewCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"
#import "RFDUserModel.h"
@interface RFDAddressBookTableViewCell : RFDTableViewCell
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) RFDUserModel *user;
@end
