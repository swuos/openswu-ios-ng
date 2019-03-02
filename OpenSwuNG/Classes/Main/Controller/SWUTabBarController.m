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
#import "SWUNavigationController.h"

@interface SWUTabBarController ()

@end

@implementation SWUTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 1.0;
    
    //    1.添加子控制器
    [self setupAllChildViewController];
//    解决返回时 tabbar的卡顿问题
    [UITabBar appearance].translucent = NO;
    
    
}
-(void)setupAllChildViewController {
    //    子控制器
    //    主页
    SWUMainViewController * mainVc = [[SWUMainViewController alloc] init];
    SWUNavigationController * nav = [[SWUNavigationController alloc] initWithRootViewController:mainVc];
    [self setupOneChildViewController:nav image:[UIImage imageNamed:@"tabBar_home_icon"] selImage:[UIImage imageNamed:@"tabBar_home_click_icon"] title:@"主页"];
    //    课程表
    SWUScheduleViewController * scheduleVc = [[SWUScheduleViewController alloc] init];
    SWUNavigationController * nav1 = [[SWUNavigationController alloc] initWithRootViewController:scheduleVc];
    [self setupOneChildViewController:nav1 image:[UIImage imageNamed:@"tabBar_schedule_icon"] selImage:[UIImage imageNamed:@"tabBar_schedule_click_icon"] title:@"课程表"];
    //    我的
    SWUMineViewController * mineVc = [[SWUMineViewController alloc] init];
    SWUNavigationController * nav2 = [[SWUNavigationController alloc] initWithRootViewController:mineVc];
    [self setupOneChildViewController:nav2 image:[UIImage imageNamed:@"tabBar_mine_icon"] selImage:[UIImage imageNamed:@"tabBar_mine_click_icon"] title:@"我的"];
}

//初始化一个控制器的View
-(void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title {
    [self addChildViewController:vc];
    vc.tabBarItem.image = image;
//    防止tabbar进行渲染
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImage;
    vc.tabBarItem.title = title;
}
@end
