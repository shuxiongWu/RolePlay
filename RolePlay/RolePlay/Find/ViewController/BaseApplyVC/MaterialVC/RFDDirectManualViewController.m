//
//  RFDDirectManualViewController.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDDirectManualViewController.h"
#import "RFDDirectManualListViewController.h"
#import "RFDDirectManualCell.h"
@interface RFDDirectManualViewController ()
@property (nonatomic, strong) UIBarButtonItem *navRightButton;
@end

@implementation RFDDirectManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直接人工";
    [self initSubViews];
    [self.tableView registerClass:[RFDDirectManualCell class] forCellReuseIdentifier:@"DirectManualCell"];
}
- (void)initSubViews
{
    // navBar 右按钮
    _navRightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
}
- (void)navRightButtonDown
{
    RFDDirectManualListViewController *listCtrl = [[RFDDirectManualListViewController alloc] init];
    [self.navigationController pushViewController:listCtrl animated:YES];
}
#pragma mark --delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDDirectManualCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DirectManualCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
