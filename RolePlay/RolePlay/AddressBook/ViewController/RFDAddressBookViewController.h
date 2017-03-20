//
//  RFDAddressBookViewController.h
//  RolePlay
//
//  Created by Refordom on 17/3/16.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewController.h"

@interface RFDAddressBookViewController : RFDTableViewController

@property (nonatomic, strong) NSMutableArray *friendsArray;     // 好友列表数据
@property (nonatomic, strong) NSMutableArray *data;             // 格式化的好友列表数据
@property (nonatomic, strong) NSMutableArray *functionData;     // 功能列表
@property (nonatomic, strong) NSMutableArray *section;          // 拼音首字母列表


@end
