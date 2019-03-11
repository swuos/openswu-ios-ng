//
//  SWUMainViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/16.
//

#import "SWUMainViewController.h"
#import "SWUScoreViewController.h"


@interface SWUMainViewController ()

@end

@implementation SWUMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 200, 200);
    [btn setTitle:@"成绩查询" forState:UIControlStateNormal];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(showGradeScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)showGradeScore {
    SWUScoreViewController * scoreVc = [[SWUScoreViewController alloc] init];
    [self.navigationController pushViewController:scoreVc animated:YES];
    
}





@end
