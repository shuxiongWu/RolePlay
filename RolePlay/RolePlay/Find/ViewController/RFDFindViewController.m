//
//  RFDFindViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/16.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDFindViewController.h"
#import "RFDWebViewController.h"
#import "RFDFindCell.h"
@interface RFDFindViewController ()
@property (nonatomic, strong) RFDWebViewController *webVC;
@end

@implementation RFDFindViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationItem setTitle:@"发现"];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[RFDFindCell class] forCellReuseIdentifier:@"FunctionCell"];
    
    [self initTestData];
}

#pragma mark - UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_data objectAtIndex:section];
    return array.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FotterView"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"FotterView"];
        [view setBackgroundView:[UIView new]];
    }
    return view;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDFindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionCell"];
    NSArray *array = [_data objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    [cell setImageName:[dic objectForKey:@"image"]];
    [cell setTitle:[dic objectForKey:@"title"]];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell setUserInteractionEnabled:YES];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if (indexPath.row == 0) {
        [cell setTopLineStyle:CellLineStyleFill];
    }
    else {
        [cell setTopLineStyle:CellLineStyleNone];
    }
    if (indexPath.row == array.count - 1) {
        [cell setBottomLineStyle:CellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15.0f;
    }
    return 20.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [_data objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    
    [self setHidesBottomBarWhenPushed:YES];
    if ([title isEqualToString:@"购物"]) {
        [self.webVC setUrlString:@"https://wq.jd.com"];
        [self.navigationController pushViewController:self.webVC animated:YES];
    }
    [self setHidesBottomBarWhenPushed:NO];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (RFDWebViewController *) webVC
{
    if (_webVC == nil) {
        _webVC = [[RFDWebViewController alloc] init];
    }
    return _webVC;
}

#pragma mark - 初始化
- (void) initTestData
{
    NSDictionary *dic = @{@"title" : @"朋友圈",
                          @"image" : @"ff_IconShowAlbum"};
    NSDictionary *dic1 = @{@"title" : @"扫一扫",
                           @"image" : @"ff_IconQRCode"};
    NSDictionary *dic2 = @{@"title" : @"摇一摇",
                           @"image" : @"ff_IconShake"};
    NSDictionary *dic3 = @{@"title" : @"附近的人",
                           @"image" : @"ff_IconLocationService"};
    NSDictionary *dic4 = @{@"title" : @"漂流瓶",
                           @"image" : @"ff_IconBottle"};
    NSDictionary *dic5 = @{@"title" : @"购物",
                           @"image" : @"CreditCard_ShoppingBag"};
    NSDictionary *dic6 = @{@"title" : @"游戏",
                           @"image" : @"MoreGame"};
    _data = [[NSMutableArray alloc] initWithObjects:@[], @[dic], @[dic1, dic2], @[dic3, dic4], @[dic5, dic6], nil];
    
    [self.tableView reloadData];
}


@end
