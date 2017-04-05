//
//  RFDMaterialViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/27.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialViewController.h"
#import "RFDMaterialCell.h"
#import "RFDFriendSearchViewController.h"
#import "RFDSiftView.h"
#import "RFDMaterialEditCell.h"
#import "RFDMaterialDetailViewController.h"
#import "RFDAddMaterialViewController.h"
@interface RFDMaterialViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
{
    UIView              *_headerView;
    NSInteger           _lastRow;
    BOOL                _isTouch;
    UILabel             *_statusLabel;
    UIButton            *_tempButton;          //一级条件下的临时button
    UIButton            *_secondTempButton;    //二级条件筛选的临时button,即"物料名称”，“审核状态”，“修改时间”
    UIButton            *_selectButton;        //即“我的待办”
    UIButton            *_tempButton1;         //二级条件下的临时button
    NSInteger           _tempTag;
    BOOL                _isEditing;
    BOOL                _isNavigationBarStatus;
}
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *addbutton;
@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, weak) UIView *secondSelectView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) RFDFriendSearchViewController *searchVC;
@end

@implementation RFDMaterialViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = _isNavigationBarStatus;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物料";
    [self.myTableView registerClass:[RFDMaterialCell class] forCellReuseIdentifier:@"MaterialCell"];
    [self.myTableView registerClass:[RFDMaterialEditCell class] forCellReuseIdentifier:@"RFDMaterialEditCell"];
    [self creatHeaderView];
    [self.view addSubview:self.myTableView];
    [self initSubViews];
}
#pragma mark --创建头部视图
- (void)creatHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 144)];
    headerView.backgroundColor = [UIColor whiteColor];
    _headerView = headerView;
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setFrame:CGRectMake(0, 44, SCREEN_WIDTH, 50)];
    [selectButton setTitle:@"我的待办" forState:UIControlStateNormal];
    [selectButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectButton = selectButton;
    [headerView addSubview:selectButton];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [headerView addSubview:lineLabel];
    
    NSArray *titleName = @[@"物料名称",@"审核状态",@"修改时间",@"筛选"];
    for (NSInteger i = 0; i < titleName.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 * (i + 1) + (SCREEN_WIDTH - 75) / 4 * i, 104, (SCREEN_WIDTH - 75) / 4, 30) ;
        button.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        button.tag = 100 + i;
        [button setTitle:titleName[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(secondSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [button setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
        [headerView addSubview:button];
    }
    
    UILabel *lineLabelButtom = [[UILabel alloc] initWithFrame:CGRectMake(0, 143.5, SCREEN_WIDTH, 0.5)];
    lineLabelButtom.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [headerView addSubview:lineLabelButtom];
    
    [self.view addSubview:headerView];
}
#pragma mark --二级筛选条件
- (void)secondSelectAction:(UIButton *)button
{
    button.selected = !button.selected;
    if ([_secondTempButton isEqual:button]) {
        if (!button.selected) {
            button.backgroundColor = DEFAULT_BACKGROUND_COLOR;
            [_secondSelectView removeFromSuperview];
            _secondSelectView = nil;
            return;
        }
    }else{
        _secondTempButton.selected = NO;
        [_secondSelectView removeFromSuperview];
        _secondSelectView = nil;
    }
    _secondTempButton.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    if (button.tag == 103) {//筛选
        RFDSiftView *siftView = [[RFDSiftView alloc] initWithFrame:SCREEN_BOUNDS];
        [KEY_WINDOW addSubview:siftView];
    }else{
        button.backgroundColor = RGBACOLOR(217, 220, 226, 1);
        _secondTempButton = button;
        [self.view addSubview:self.secondSelectView];
    }
}
#pragma mark --二级条件选择下的视图
-(UIView *)secondSelectView
{
    if (!_secondSelectView) {
        NSDictionary *dict = @{@"0":@[@"名称升序",@"名称降序"],
                               @"1":@[@"已审核",@"未审核"],
                               @"2":@[@"更新修改"]
                               };
        NSString *tagString = [NSString stringWithFormat:@"%ld",_secondTempButton.tag - 100];
        NSArray *titleArr = dict[tagString];
        UIView *secondSelectView = [[UIView alloc] initWithFrame:CGRectMake(_secondTempButton.x, _selectView.y + _headerView.y + _secondTempButton.frameBottom - 2, _secondTempButton.width, _secondTempButton.height * titleArr.count)];
        _secondSelectView = secondSelectView;
         secondSelectView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:secondSelectView];
        
        for (NSInteger i = 0; i < titleArr.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, _secondTempButton.height * i, _secondTempButton.width, _secondTempButton.height);
           
            button.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [button addTarget:self action:@selector(secondSelectCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:titleArr[i] forState:UIControlStateNormal];
            [secondSelectView addSubview:button];
        }
        
    }
    return _secondSelectView;
}
#pragma mark --选择对应的二级级条件视图筛选
- (void)secondSelectCurrentAction:(UIButton *)button
{
   _tempButton1.backgroundColor = [UIColor clearColor];
    button.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    _tempButton1 = button;
    [_secondTempButton setTitle:button.currentTitle forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_secondSelectView removeFromSuperview];
        _secondSelectView = nil;
    });
    _secondTempButton.selected = NO;
    _secondTempButton.backgroundColor = DEFAULT_BACKGROUND_COLOR;
}
#pragma mark --待办事件的选择
- (void)selectAction:(UIButton *)button
{
    self.selectView.hidden = button.selected;
    button.selected = !button.selected;
    if (!button.selected) {
        [_selectView removeFromSuperview];
        _selectView = nil;
    }
}
#pragma mark --创建待办事件选择器
-(UIView *)selectView
{
    if (!_selectView) {
        NSArray *selectName = @[@"我的已办",@"所有待办",@"所有已办",@"已审核",@"待审核",@"产成品与备品"];
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.y + 94.5, SCREEN_WIDTH, 30 * selectName.count)];
        _selectView = selectView;
        _selectView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:selectView];
        for (NSInteger i = 0; i < selectName.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, i * 30, SCREEN_WIDTH, 30);
            [button setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
            [button setTitle:selectName[i] forState:UIControlStateNormal];
            button.tag = 200 + i;
            [button addTarget:self action:@selector(selectCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
            [selectView addSubview:button];
            if (i == _tempTag) {
                button.backgroundColor = RGBACOLOR(235, 235, 235, 1);
            }
            
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30 * (i + 1), SCREEN_WIDTH, 0.5)];
            lineLabel.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
            [selectView addSubview:lineLabel];
        }
    }
    return _selectView;
}
#pragma mark --选择对应的一级条件视图筛选
- (void)selectCurrentAction:(UIButton *)button
{
    _tempTag = button.tag - 200;
    _tempButton.backgroundColor = [UIColor clearColor];
    button.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    _tempButton = button;
    [_selectButton setTitle:button.currentTitle forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_selectView removeFromSuperview];
        _selectView = nil;
        _selectButton.selected = NO;
    });
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 208, SCREEN_WIDTH, SCREEN_HEIGHT - 208) style:UITableViewStylePlain];
        tabelView.delegate = self;
        tabelView.dataSource = self;
        tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tabelView];
        _myTableView = tabelView;
    }
    return _myTableView;
}

/**
 *  初始化子视图
 */
- (void) initSubViews
{
    // 搜索
    _searchVC = [[RFDFriendSearchViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    [_searchController setSearchResultsUpdater: _searchVC];
    [_searchController.searchBar setPlaceholder:@"请输入搜索内容"];
    [_searchController.searchBar setBarTintColor:DEFAULT_SEARCHBAR_COLOR];
    [_searchController.searchBar sizeToFit];
    _searchController.delegate = self;
    [_searchController.searchBar setDelegate:self];
    [_searchController.searchBar.layer setBorderWidth:0.5f];
    [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
    [_headerView addSubview:_searchController.searchBar];
    
    //状态栏的背景色
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, SCREEN_WIDTH, 20)];
    statusLabel.backgroundColor = DEFAULT_NAVBAR_COLOR;
    statusLabel.hidden = YES;
    _statusLabel = statusLabel;
    [_headerView addSubview:statusLabel];
    
    _editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    _addbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self.navigationItem setRightBarButtonItems:@[_addbutton,_editButton]];

}

#pragma mark --编辑
- (void)editAction:(UIBarButtonItem *)barButton
{
    _isEditing = !_isEditing;
    _isTouch = NO;
    [self.myTableView reloadData];
}
#pragma mark --新增物料
- (void)addAction:(UIBarButtonItem *)barButton
{
    RFDAddMaterialViewController *addMaterialCtrl = [[RFDAddMaterialViewController alloc] init];
    [self.navigationController pushViewController:addMaterialCtrl animated:YES];
}
#pragma mark --点击搜索栏的时候做对应的移动
- (void)willPresentSearchController:(UISearchController *)searchController
{
    _myTableView.height = SCREEN_HEIGHT - 100;
    [UIView animateWithDuration:0.3 animations:^{
        _headerView.y = 20;
        _myTableView.y = _headerView.frameBottom;
        self.navigationController.navigationBar.hidden = YES;
    }];
    
}
-(void)willDismissSearchController:(UISearchController *)searchController
{
    _myTableView.height = SCREEN_HEIGHT - 208;
    [UIView animateWithDuration:0.3 animations:^{
        _headerView.y = 64;
        _myTableView.y = _headerView.frameBottom;
        self.navigationController.navigationBar.hidden = NO;
    }];
    
}
#pragma mark --UITableViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isTouch = YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RFDMaterialDetailViewController *detailCtrl = [[RFDMaterialDetailViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailCtrl animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isTouch) {
        [_headerView bringSubviewToFront:_statusLabel];
        if (indexPath.row - _lastRow > 0) {
            _myTableView.height = SCREEN_HEIGHT - 100;
            [UIView animateWithDuration:.05 animations:^{
                _headerView.y = -24;
                _isNavigationBarStatus = YES;
                self.navigationController.navigationBar.hidden = YES;
                _statusLabel.hidden = NO;
            }];
        }else{
            _myTableView.height = SCREEN_HEIGHT - 208;
            
            [UIView animateWithDuration:.05 animations:^{
                _headerView.y = 64;
                _isNavigationBarStatus = NO;
                self.navigationController.navigationBar.hidden = NO;
                _statusLabel.hidden = YES;
            }];
        }
        _myTableView.y = _headerView.frameBottom;
    }
    _lastRow = indexPath.row;
    RFDTableViewCell *cell;
    if (_isEditing) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RFDMaterialEditCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialCell"];
    }
    
    if (indexPath.row == 19) {
        [cell setBottomLineStyle:CellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
