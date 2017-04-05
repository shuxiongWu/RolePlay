//
//  RFDDirectMaterialViewController.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDDirectMaterialViewController.h"
#import "RFDDirectMaterialCell.h"
#import "RFDMaterialSelectListViewController.h"
@interface RFDDirectMaterialViewController ()
@property (nonatomic, strong) UIBarButtonItem *navRightButton;
@end

@implementation RFDDirectMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直接物料";
    [self initSubViews];
    [self.tableView registerClass:[RFDDirectMaterialCell class] forCellReuseIdentifier:@"DirectMaterialCell"];
}
- (void)initSubViews
{
    // navBar 右按钮
    _navRightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
}
- (void)navRightButtonDown
{
    RFDMaterialSelectListViewController *listCtrl = [[RFDMaterialSelectListViewController alloc] init];
    [self.navigationController pushViewController:listCtrl animated:YES];
}
#pragma mark --Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDDirectMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DirectMaterialCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
