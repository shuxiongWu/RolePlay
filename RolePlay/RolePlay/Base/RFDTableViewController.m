//
//  RFDTableViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewController.h"

@interface RFDTableViewController ()

@end

@implementation RFDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[UIView new]];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [self.tableView setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
