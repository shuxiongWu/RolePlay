//
//  RFDMessageTableViewCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"
#import "RFDMessageModel.h"
@interface RFDMessageTableViewCell : RFDTableViewCell
@property (nonatomic, strong) RFDMessageModel *messageModel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@end
