//
//  RFDMaterialDetailEditViewController.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialDetailEditViewController.h"
#import "RFDMaterialDetailCell.h"
#import "RFDDirectMaterialViewController.h"
#import "RFDDirectManualViewController.h"
#import "UIView+Eject.h"
#import "EjectView.h"
#define ADDPHOTO_MAXNUM     6
@interface RFDMaterialDetailEditViewController ()
{
    NSMutableArray                      *_dataSrouceArr;
    NSMutableArray                      *_listArr;
    NSMutableArray                      *_valueArr;
    UIView                              *_view;
}
@property (nonatomic, strong) UIBarButtonItem *saveButton;          //保存
@property (nonatomic, strong) UIBarButtonItem *abandonButton;       //放弃
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation RFDMaterialDetailEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物料详情";
    [self.tableView registerClass:[RFDMaterialDetailCell class] forCellReuseIdentifier:@"MaterialDetailCell"];
    [self initDataSrouce];
    [self initSubViews];
    [self setTableViewHeaderView];
}
- (NSMutableArray *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _imgArr;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        if (_imgArr.count < ADDPHOTO_MAXNUM) {
            if (![self.imgArr containsObject:[UIImage imageNamed:@"common_addphoto"]]) {
                [_imgArr addObject:[UIImage imageNamed:@"common_addphoto"]];
            }
            for (NSInteger i = 0; i < _imgArr.count; i ++) {
                if (_imgArr.count == 1) {
                    UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
                    addImgView.image = _imgArr[i];
                    addImgView.center = _scrollView.center;
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoImage:)];
                    addImgView.userInteractionEnabled = YES;
                    [addImgView addGestureRecognizer:tap];
                    
                    [_scrollView addSubview:addImgView];
                }else{
                    UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 105 * i, 10, 90, 90)];
                    addImgView.image = _imgArr[i];
                    [_scrollView addSubview:addImgView];
                    if (i == _imgArr.count - 1) {
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoImage:)];
                        addImgView.userInteractionEnabled = YES;
                        [addImgView addGestureRecognizer:tap];
                    }else{
                        UIButton *deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [deleButton setBackgroundImage:[UIImage imageNamed:@"common_delete"] forState:UIControlStateNormal];
                        deleButton.frame = CGRectMake(0, 0, 20, 20);
                        deleButton.tag = 300 + i;
                        deleButton.center = CGPointMake(addImgView.frameRight, addImgView.y);
                        [deleButton addTarget:self action:@selector(delePhoto:) forControlEvents:UIControlEventTouchUpInside];
                        [_scrollView addSubview:deleButton];
                    }
                }
            }
        }else{
            for (NSInteger i = 0; i < _imgArr.count; i ++) {
                UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 105 * i, 10, 90, 90)];
                addImgView.image = _imgArr[i];
                
                UIButton *deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [deleButton setBackgroundImage:[UIImage imageNamed:@"common_delete"] forState:UIControlStateNormal];
                deleButton.frame = CGRectMake(0, 0, 20, 20);
                deleButton.tag = 300 + i;
                deleButton.center = CGPointMake(addImgView.frameRight, addImgView.y);
                [deleButton addTarget:self action:@selector(delePhoto:) forControlEvents:UIControlEventTouchUpInside];
                
                [_scrollView addSubview:deleButton];
                [_scrollView addSubview:addImgView];
            }
        }
        _scrollView.contentSize = CGSizeMake(5 + 105 * self.imgArr.count, 0);
    }
    return _scrollView;
}
#pragma mark --删除照片
- (void)delePhoto:(UIButton *)button
{
    [_imgArr removeObjectAtIndex:button.tag - 300];
    _scrollView = nil;
    [self setTableViewHeaderView];
}
#pragma mark --添加照片
- (void)addPhotoImage:(UIGestureRecognizer *)ges
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    _view = view;
    [self.view addSubview:view];
    [self.view showCategoryEjectView];
    [[EjectView shareEjectView] cameraSheetInController:self handler:^(UIImage *image) {
        if (image) {
            [_imgArr insertObject:image atIndex:_imgArr.count - 1];
            _scrollView = nil;
            [self setTableViewHeaderView];
        };
        
    } cancelHandler:^(NSInteger index) {
        
        [self.view hideCategoryEjectView];
        [_view removeFromSuperview];
    }];
    
}
#pragma mark --设置tableview的头部
- (void)setTableViewHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:self.scrollView];
    [self.tableView setTableHeaderView:headerView];
}
- (void)initSubViews
{
    // navBar 右按钮
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    [self.navigationItem setRightBarButtonItem:_saveButton];
    
    _abandonButton = [[UIBarButtonItem alloc] initWithTitle:@"放弃" style:UIBarButtonItemStylePlain target:self action:@selector(_abandon:)];
    [self.navigationItem setLeftBarButtonItem:_abandonButton];
}
#pragma mark --保存
- (void)saveAction:(UIBarButtonItem *)barButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --放弃
- (void)_abandon:(UIBarButtonItem *)barButton
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要放弃已编辑的内容吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --初始化数据源
- (void)initDataSrouce
{
    _listArr = [NSMutableArray arrayWithArray:@[@"名称",@"分类",@"计量单位",@"审核状态",@"直接物料（2）",@"直接人工（2）",@"生产组织（6）",@"供应商（1）",@"费用（2）"]];
    _valueArr = [NSMutableArray arrayWithArray:@[@"090绒盒_KU_208",@"半成品>胶胚>合页绒盒",@"个",@"已审核",@"",@"",@"",@"",@""]];
    [self.imgArr addObject:[UIImage imageNamed:@"10.jpeg"]];
    [self.imgArr addObject:[UIImage imageNamed:@"10.jpeg"]];
    [self.imgArr addObject:[UIImage imageNamed:@"10.jpeg"]];
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
}@end
