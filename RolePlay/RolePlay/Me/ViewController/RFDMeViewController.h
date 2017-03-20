//
//  RFDMeViewController.h
//  RolePlay
//
//  Created by Refordom on 17/3/16.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewController.h"
@class RFDUserModel;
@interface RFDMeViewController : RFDTableViewController
@property (nonatomic, strong) RFDUserModel *user;
@property (nonatomic, strong) NSMutableArray *data;
@end
