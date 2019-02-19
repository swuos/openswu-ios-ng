//
//  SWUTabBarController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/16.
//

#import "SWUTabBarController.h"
#import "SWUMainViewController.h"
#import "SWUMineViewController.h"
#import "SWUScheduleViewController.h"

@interface SWUTabBarController ()

@end

@implementation SWUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 1.0;
    
    //    1.添加子控制器
    [self setupAllChildViewController];
    
    //    2.自定义tabBar
//    [self setupTabBar];
}
-(void)setupAllChildViewController {
    //    子控制器
    //    主页
    SWUMainViewController * mainVc = [[SWUMainViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    [self setupOneChildViewController:nav image:[UIImage imageNamed:@"tabBar_home_icon"] selImage:[UIImage imageNamed:@"tabBar_home_click_icon"] title:@"主页"];
    //    课程表
    SWUScheduleViewController * scheduleVc = [[SWUScheduleViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:scheduleVc];
    [self setupOneChildViewController:nav1 image:[UIImage imageNamed:@"tabBar_schedule_icon"] selImage:[UIImage imageNamed:@"tabBar_schedule_click_icon"] title:@"课程表"];
    //    我的
    SWUMineViewController * mineVc = [[SWUMineViewController alloc] init];
//    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:mineVc];
    [self setupOneChildViewController:mineVc image:[UIImage imageNamed:@"tabBar_mine_icon"] selImage:[UIImage imageNamed:@"tabBar_mine_click_icon"] title:@"我的"];
}

//-(void)setupTabBar {
//
//
//}
//初始化一个控制器的View
-(void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title {
    [self addChildViewController:vc];
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    vc.tabBarItem.title = title;
//    [self.items addObject:vc.tabBarItem];
}
@end
