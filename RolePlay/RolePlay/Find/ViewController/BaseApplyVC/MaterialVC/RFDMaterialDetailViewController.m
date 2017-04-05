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
#import "RFDDirectMaterialViewController.h"
#import "RFDDirectManualViewController.h"
#import "RFDMaterialDetailEditViewController.h"
@interface RFDMaterialDetailViewController ()
{
    NSMutableArray *_dataSrouceArr;
    NSMutableArray *_listArr;
    NSMutableArray *_valueArr;
}
@property (nonatomic, strong) UIBarButtonItem *navRightButton;
@end

@implementation RFDMaterialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物料详情";
    [self.tableView registerClass:[RFDMaterialDetailCell class] forCellReuseIdentifier:@"MaterialDetailCell"];
    [self initDataSrouce];
    [self creatHeaderView];
    [self initSubViews];
}
- (void)initSubViews
{
    // navBar 右按钮
    _navRightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
}
- (void)navRightButtonDown
{
    RFDMaterialDetailEditViewController *editCtrl = [[RFDMaterialDetailEditViewController alloc] init];
    [self.navigationController pushViewController:editCtrl animated:YES];
}
#pragma mark --初始化数据源
- (void)initDataSrouce
{
    _listArr = [NSMutableArray arrayWithArray:@[@"名称",@"分类",@"计量单位",@"审核状态",@"直接物料（2）",@"直接人工（2）",@"生产组织（6）",@"供应商（1）",@"费用（2）"]];
    _valueArr = [NSMutableArray arrayWithArray:@[@"090绒盒_KU_208",@"半成品>胶胚>合页绒盒",@"个",@"已审核",@"",@"",@"",@"",@""]];
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 5;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        RFDDirectMaterialViewController *directMaterialCtrl = [[RFDDirectMaterialViewController alloc] init];
        [self.navigationController pushViewController:directMaterialCtrl animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        RFDDirectManualViewController *directManualCtrl = [[RFDDirectManualViewController alloc] init];
        [self.navigationController pushViewController:directManualCtrl animated:YES];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFDMaterialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialDetailCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.cateLabel.text = _listArr[indexPath.row];
        cell.statusLabel.text = _valueArr[indexPath.row];
    }else{
        cell.cateLabel.text = _listArr[indexPath.row + 4];
        cell.statusLabel.text = _valueArr[indexPath.row + 4];
    }
    
    if (indexPath.row == 3 && indexPath.row == 4) {
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
