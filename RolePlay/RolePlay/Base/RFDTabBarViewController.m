//
//  RFDTabBarViewController.m
//  RolePlay
//
//  Created by Refordom on 17/3/16.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTabBarViewController.h"
#import "RFDNaviViewController.h"
#import "RFDMeViewController.h"
#import "RFDFindViewController.h"
#import "RFDMessageViewController.h"
#import "RFDAddressBookViewController.h"
@interface RFDTabBarViewController ()

@end

@implementation RFDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundColor:DEFAULT_SEARCHBAR_COLOR];
    [self.tabBar setTintColor:DEFAULT_GREEN_COLOR];
    
    [self createControllers];
    
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   RGBACOLOR(219, 219, 219, 1).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    view.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:view atIndex:0];
    
}
//创建控制器
-(void)createControllers
{
    // 添加子控制器
    [self addChildVc:[[RFDMessageViewController alloc] init] title:@"消息" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    [self addChildVc:[[RFDAddressBookViewController alloc] init] title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    [self addChildVc:[[RFDFindViewController alloc] init] title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    [self addChildVc:[[RFDMeViewController alloc] init] title:@"我" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBACOLOR(123, 123, 123,1)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : DEFAULT_GREEN_COLOR} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    RFDNaviViewController *navigationVc = [[RFDNaviViewController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    
    [self addChildViewController:navigationVc];
}

- (void) initChildViewControllers
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    RFDMessageViewController *conversationVC = [[RFDMessageViewController alloc] init];
    [conversationVC.tabBarItem setTitle:@"消息"];
    [conversationVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_mainframe"]];
    [conversationVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    RFDNaviViewController *convNavC = [[RFDNaviViewController alloc] initWithRootViewController:conversationVC];
    [childVCArray addObject:convNavC];
    
    RFDAddressBookViewController *friendsVC = [[RFDAddressBookViewController alloc] init];
    [friendsVC.tabBarItem setTitle:@"通讯录"];
    [friendsVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [friendsVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    RFDNaviViewController *friendNavC = [[RFDNaviViewController alloc] initWithRootViewController:friendsVC];
    [childVCArray addObject:friendNavC];
    
    RFDFindViewController *discoverVC = [[RFDFindViewController alloc] init];
    [discoverVC.tabBarItem setTitle:@"发现"];
    [discoverVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_discover"]];
    [discoverVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    RFDNaviViewController *discoverNavC = [[RFDNaviViewController alloc] initWithRootViewController:discoverVC];
    [childVCArray addObject:discoverNavC];
    
    RFDMeViewController *mineVC = [[RFDMeViewController alloc] init];
    [mineVC.tabBarItem setTitle:@"我"];
    [mineVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_me"]];
    [mineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_meHL"]];
    RFDNaviViewController *mineNavC = [[RFDNaviViewController alloc] initWithRootViewController:mineVC];
    [childVCArray addObject:mineNavC];
    
    [self setViewControllers:childVCArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
