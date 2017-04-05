//
//  RFDAddMaterialViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/30.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDAddMaterialViewController.h"
#import "RFDMaterialDetailCell.h"
#import "RFDSwitchCell.h"
#import "RFDTextFiledCell.h"
#import "RFDPickView.h"
#import <RSKImageCropper/RSKImageCropper.h>
#import "UIView+Eject.h"
#import "EjectView.h"
#import "RFDDirectMaterialViewController.h"
#import "RFDDirectManualViewController.h"
#define ADDPHOTO_MAXNUM     6
@interface RFDAddMaterialViewController ()<UIAlertViewDelegate,RSKImageCropViewControllerDelegate>
{
    UIView                              *_view;
}
@property (nonatomic, strong) UIBarButtonItem *saveButton;          //保存
@property (nonatomic, strong) UIBarButtonItem *abandonButton;       //放弃
@property (nonatomic, strong) NSMutableArray *dataSrouce;
@property (nonatomic, strong) NSMutableArray *titleMutArr;
@property (nonatomic, strong) NSMutableArray *selectMutArr;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation RFDAddMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增物料";
    [self initSubViews];
    _dataSrouce = [NSMutableArray arrayWithObjects:self.titleMutArr,nil];
    [self.tableView registerClass:[RFDMaterialDetailCell class] forCellReuseIdentifier:@"MaterialDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RFDSwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RFDTextFiledCell" bundle:nil] forCellReuseIdentifier:@"TextFiledCell"];
    [self setTableViewHeaderView];
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:self.scrollView];
    
    UITextField *textFeild = [[UITextField alloc] initWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 30, 50)];
    textFeild.placeholder = @"输入物料名称";
    [headerView addSubview:textFeild];
    
    [self.tableView setTableHeaderView:headerView];
}
- (NSMutableArray *)titleMutArr
{
    if (!_titleMutArr) {
        NSArray *arr = @[@"一级分类",@"二级分类",@"三级分类",@"计量单位",@"BOM",@"描述"];
        _titleMutArr = [NSMutableArray arrayWithArray:arr];
    }
    return _titleMutArr;
}
- (NSMutableArray *)selectMutArr
{
    if (!_selectMutArr) {
        NSArray *arr = @[@"请选择",@"请选择",@"请选择",@"请选择",@"NO",@""];
        _selectMutArr = [NSMutableArray arrayWithArray:arr];
    }
    return _selectMutArr;
}

- (NSMutableArray *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _imgArr;
}
#pragma mark --UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return 6;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 5) {
        return 100;
    }
    return 50;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    if (section == 1) return 50;
    return 8.0f;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (label == nil) {
        label = [[UILabel alloc] init];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    }
    if (section == 1)
    {
        [label setText:[NSString stringWithFormat:@"   %@", @"关系列表"]];
    }
    return label;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row > 3) {
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0 && indexPath.row < 4) {
            __block NSMutableArray *selectArr = _selectMutArr;
            RFDPickView *pickView = [[RFDPickView alloc] initWithFrame:SCREEN_BOUNDS];
            [pickView setSelectCateSuccessCallBack:^(NSString *cateString) {
                [selectArr replaceObjectAtIndex:indexPath.row withObject:cateString];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [KEY_WINDOW addSubview:pickView];
        }
    }
    if (indexPath.section == 1) {
        RFDDirectMaterialViewController *directMaterialCtrl = [[RFDDirectMaterialViewController alloc] init];
        [self.navigationController pushViewController:directMaterialCtrl animated:YES];
    }else if(indexPath.section == 2){
        RFDDirectManualViewController *directManualCtrl = [[RFDDirectManualViewController alloc] init];
        [self.navigationController pushViewController:directManualCtrl animated:YES];
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RFDTableViewCell *cell;
    NSArray *arr = @[@"直接物料",@"直接人工",@"生产组织",@"供应商",@"费用"];
    if (indexPath.section == 0) {
        if (indexPath.row < 4) {
            RFDMaterialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialDetailCell"];
            cell.cateLabel.text = _titleMutArr[indexPath.row];
            cell.statusLabel.text = self.selectMutArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if(indexPath.row == 4){
            cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"TextFiledCell"];
        }
    }else{
        RFDMaterialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialDetailCell"];
        cell.cateLabel.text = arr[indexPath.section - 1];
        [cell setBottomLineStyle:CellLineStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row > 3) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
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
- (void)initSubViews
{
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
    [self.navigationItem setRightBarButtonItem:_saveButton];
    _abandonButton = [[UIBarButtonItem alloc] initWithTitle:@"放弃" style:UIBarButtonItemStylePlain target:self action:@selector(_abandon:)];
    [self.navigationItem setLeftBarButtonItem:_abandonButton];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
