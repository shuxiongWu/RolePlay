//
//  RFDMessageViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/16.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMessageViewController.h"
#import "RFDMessageTableViewCell.h"
#import "RFDFriendSearchViewController.h"
#import "RFDMaterialViewController.h"
#import <AFNetworking.h>
@interface RFDMessageViewController ()
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) RFDFriendSearchViewController *searchVC;
@property (nonatomic, strong) UIBarButtonItem *navRightButton;
@end

@implementation RFDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"消息"];
    [self setHidesBottomBarWhenPushed:NO];
    
    [self.tableView registerClass:[RFDMessageTableViewCell class] forCellReuseIdentifier:@"MessageCell"];
    
    [self initSubViews];
    _data = [self getTestData];
    
//    NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
//    [RFDNetworkManager openLog];
//    [RFDNetworkManager GET:@"http://api.budejie.com/api/api_open.php" parameters:para responseCache:^(id responseCache) {
//        NSLog(@"%@",(NSData *)responseCache);
//    } success:^(id responseObject) {
//        //NSMutableDictionary * baseDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *) getTestData
{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:20];
    
    RFDMessageModel *item1 = [[RFDMessageModel alloc] init];
    item1.from = [NSString stringWithFormat:@"李秀莲"];
    item1.message = @"开饭了！！";
    item1.avatarURL = [NSURL URLWithString:@"8.jpg"];
    item1.messageCount = 3;
    item1.date = [NSDate date];
    [models addObject:item1];
    
    return models;
}

- (void) navRightButtonDown
{
    RFDMaterialViewController *materialCtrl = [[RFDMaterialViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:materialCtrl animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    [cell setMessageModel:_data[indexPath.row]];
    [cell setTopLineStyle:CellLineStyleNone];
    if (indexPath.row == _data.count - 1) {
        [cell setBottomLineStyle:CellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
//
//- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_data removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}
#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

/**
 *  初始化子视图
 */
- (void) initSubViews
{
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    
    // 搜索
    _searchVC = [[RFDFriendSearchViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    [_searchController setSearchResultsUpdater: _searchVC];
    [_searchController.searchBar setPlaceholder:@"搜索"];
    [_searchController.searchBar setBarTintColor:DEFAULT_SEARCHBAR_COLOR];
    [_searchController.searchBar sizeToFit];
    [_searchController.searchBar setDelegate:self];
    [_searchController.searchBar.layer setBorderWidth:0.5f];
    [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
    [self.tableView setTableHeaderView:_searchController.searchBar];
    
    // navBar 右按钮
    _navRightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
}

@end
