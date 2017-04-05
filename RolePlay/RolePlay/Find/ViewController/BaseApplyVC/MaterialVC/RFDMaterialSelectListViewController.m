//
//  RFDMaterialSelectListViewController.m
//  RolePlay
//
//  Created by Refordom on 17/4/5.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDMaterialSelectListViewController.h"
#import "RFDMaterialSelectCell.h"
#import "RFDSiftView.h"
@interface RFDMaterialSelectListViewController ()
{
    
    UIButton            *_secondTempButton;    //二级条件筛选的临时button
    UIButton            *_tempButton1;         //二级条件下的临时button
}
@property (nonatomic, strong) UIBarButtonItem *navRightButton;
@property (nonatomic, weak) UIView *secondSelectView;
@end

@implementation RFDMaterialSelectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物料选择列表";
    [self initSubViews];
    [self.tableView registerClass:[RFDMaterialSelectCell class] forCellReuseIdentifier:@"MaterialSelectCell"];
}
- (void)initSubViews
{
    // navBar 右按钮
    _navRightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
}
- (void)navRightButtonDown
{
    
}
#pragma mark --delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    NSArray *titleName = @[@"物料名称",@"分类"];
    for (NSInteger i = 0; i < titleName.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 * (i + 1) + (SCREEN_WIDTH - 75) / 4 * i, 10, (SCREEN_WIDTH - 75) / 4, 30) ;
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
    
    UIButton *siftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    siftButton.frame = CGRectMake(SCREEN_WIDTH - 55, 10, 40, 30);
    [siftButton setTitle:@"筛选" forState:UIControlStateNormal];
    [siftButton setTitleColor:DEFAULT_TEXT_GRAY_COLOR forState:UIControlStateNormal];
    [siftButton addTarget:self action:@selector(sift:) forControlEvents:UIControlEventTouchUpInside];
    siftButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [headerView addSubview:siftButton];
    
    UILabel *lineLabelButtom = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    lineLabelButtom.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [headerView addSubview:lineLabelButtom];
    return headerView;
}
- (void)sift:(UIButton *)button
{
    RFDSiftView *siftView = [[RFDSiftView alloc] initWithFrame:SCREEN_BOUNDS];
    [KEY_WINDOW addSubview:siftView];
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
    
    button.backgroundColor = RGBACOLOR(217, 220, 226, 1);
    _secondTempButton = button;
    [self.view addSubview:self.secondSelectView];
}
#pragma mark --二级条件选择下的视图
-(UIView *)secondSelectView
{
    if (!_secondSelectView) {
        NSDictionary *dict = @{@"0":@[@"名称升序",@"名称降序"],
                               @"1":@[@"产成品",@"半成品",@"原料",@"备品"],
                               };
        NSString *tagString = [NSString stringWithFormat:@"%ld",_secondTempButton.tag - 100];
        NSArray *titleArr = dict[tagString];
        UIView *secondSelectView = [[UIView alloc] initWithFrame:CGRectMake(_secondTempButton.x, 38, _secondTempButton.width, _secondTempButton.height * titleArr.count)];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RFDMaterialSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialSelectCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
