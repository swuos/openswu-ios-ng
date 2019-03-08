//
//  AppDelegate.m
//  OpenSwuNG
//
//  Created by KK on 4/Sep/18.
//

#import "AppDelegate.h"
#import "SWUTabBarController.h"
#import "SWUNavigationController.h"
#import "SWULoginViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    if (![self isUserLogin]) {
        SWULoginViewController * loginVc = [[SWULoginViewController alloc] init];
        SWUNavigationController * nav = [[SWUNavigationController alloc] initWithRootViewController:loginVc];
        [self.window setRootViewController:nav];
//        [tabBarVc presentViewController:nav animated:YES completion:nil];
    }else {
        SWUTabBarController * tabBarVc = [[SWUTabBarController alloc] init];
        [self.window setRootViewController:tabBarVc];
    }
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(BOOL)isUserLogin {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"0" forKey:@"USER_ID"];
    NSString * userId = [userDefaults objectForKey:@"USER_ID"];
    if (userId != nil && [userId integerValue] > 0) {
        return YES;
    }
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//禁止屏幕旋转
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return  UIInterfaceOrientationMaskPortrait;
}

@end
