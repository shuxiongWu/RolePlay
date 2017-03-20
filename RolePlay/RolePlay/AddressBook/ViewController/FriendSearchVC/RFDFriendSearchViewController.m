//
//  RFDFriendSearchViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDFriendSearchViewController.h"

@interface RFDFriendSearchViewController ()

@end

@implementation RFDFriendSearchViewController

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSLog(@"%@", searchText);
}
@end
