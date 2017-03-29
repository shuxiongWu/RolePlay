//
//  RFDMaterialDetailViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/29.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialDetailViewController.h"
#import <SDCycleScrollView.h>
#import "RFDMaterialDetailCell.h"
@interface RFDMaterialDetailViewController ()
{
    NSMutableArray *_dataSrouceArr;
}
@end

@implementation RFDMaterialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物料详情";
    [self.tableView registerClass:[RFDMaterialDetailCell class] forCellReuseIdentifier:@"MaterialDetailCell"];
    [self initDataSrouce];
    [self creatHeaderView];
}
#pragma mark --初始化数据源
- (void)initDataSrouce
{
    NSArray *arr = @[@{@"名称":@"090绒盒_KU_208",
                       @"分类":@"半成品>胶胚>合页绒盒",
                       @"计量单位":@"个",
                       @"审核状态":@"已审核"},
                     @{@"直接物料（2）":@"",
                       @"直接人工（2）":@"",
                       @"生产组织（6）":@"",
                       @"供应商（1）":@"",
                       @"费用（2）":@""}];
    _dataSrouceArr = [NSMutableArray arrayWithArray:arr];
}
#pragma mark --创建头部视图
- (void)creatHeaderView
{
    [self.tableView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    NSArray *imgArr = @[@"example.jpg",@"example.jpg",@"example.jpg"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) imageNamesGroup:imgArr];
    cycleScrollView.autoScroll = NO;
    [self.tableView setTableHeaderView:cycleScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSrouceArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = _dataSrouceArr[section];
    return dict.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (label == nil) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    }
    [label setText:[NSString stringWithFormat:@"    %@", @"关系列表"]];
    return label;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDMaterialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialDetailCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dict = _dataSrouceArr[indexPath.section];
    NSArray *keyArr = [dict allKeys];
    NSArray *valueArr = [dict allValues];
    cell.cateLabel.text = keyArr[indexPath.row];
    cell.statusLabel.text = valueArr[indexPath.row];
    if (indexPath.row == keyArr.count - 1) {
        [cell setBottomLineStyle:CellLineStyleFill];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [cell setTopLineStyle:CellLineStyleFill];
    }else{
        [cell setTopLineStyle:CellLineStyleNone];
    }
    return cell;
}
@end
