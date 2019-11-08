//
//  SWUMainViewController.m
//  OpenSwuNG
//
//  Created by 501 on 2019/2/16.
//

#import "SWUMainViewController.h"
#import "Constants.h"
#import "SWUMainHeaderView.h"
#import "SWUFactory.h"
#import "SVProgressHUD.h"
#import "SWUNewsModel.h"
#import "SWUNewsCell.h"
#import "SWUNewsInfoController.h"

@interface SWUMainViewController ()<UITableViewDelegate,UITableViewDataSource>
/** headLabel */
@property(nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation SWUMainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //     self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    设置标题
    [self setUpHead];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __block NSArray *hotNewsArr;
    __block NSArray *notificationArr;
    __block NSArray *lectureArr;
    
    SWUMainHeaderView *headerView = [[SWUMainHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, 450)];
    headerView.alertVcBlock = ^(UIViewController * _Nonnull vc) {
        [self presentViewController:vc animated:YES completion:nil];
    };
    headerView.pushVcBlock = ^(UIViewController * _Nonnull vc) {
        [self.navigationController pushViewController:vc animated:YES];
    };
    headerView.changeVcBlock = ^(NSString * _Nonnull name) {
//        热点新闻 通知公告 学术看板
        if ([name isEqualToString:@"热点新闻"]) {
            if (hotNewsArr) {
                self.dataArray = hotNewsArr;
                [self.tableView reloadData];
               
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/crawl/1/10" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    hotNewsArr = [SWUFactory getData:responseObject model:[SWUNewsModel class]];
                    weakSelf.dataArray = hotNewsArr;
                    [self.tableView reloadData];
                   
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
        if ([name isEqualToString:@"通知公告"]) {
            if (notificationArr) {
                self.dataArray = notificationArr;
                [self.tableView reloadData];
               
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/crawl/0/10" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    notificationArr = [SWUFactory getData:responseObject model:[SWUNewsModel class]];
                    weakSelf.dataArray = notificationArr;
                    [self.tableView reloadData];
                   
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
        if ([name isEqualToString:@"学术看板"]) {
            if (lectureArr) {
                self.dataArray = lectureArr;
                [self.tableView reloadData];
               
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/crawl/2/10" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    lectureArr = [SWUFactory getData:responseObject model:[SWUNewsModel class]];
                    weakSelf.dataArray = lectureArr;
                    [self.tableView reloadData];
                   
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
    };
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.sectionHeaderHeight = headerView.frame.size.height;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager GET:@"https://freegatty.swuosa.xenoeye.org/crawl/1/10" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            hotNewsArr = [SWUFactory getData:responseObject model:[SWUNewsModel class]];
            weakSelf.dataArray = hotNewsArr;
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    });
    [self.tableView layoutIfNeeded];
    [self.view addSubview:self.tableView];
}
#pragma mark - “西大助手”Label
-(void)setUpHead{
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    self.headLabel.text = @"西大助手";
    self.headLabel.textColor = [UIColor blackColor];
    self.headLabel.font = [UIFont boldSystemFontOfSize:16];
    self.headLabel.numberOfLines = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headLabel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(SWUNewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * ID = @"Main";
    SWUNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWUNewsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
//    cell.backgroundColor = [UIColor blueColor];
//    if (indexPath.row %2 == 0) {
//        cell.backgroundColor = [UIColor redColor];
//    }
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWUNewsCell *cell = (SWUNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    SWUNewsInfoController * infoVc = [[SWUNewsInfoController alloc] init];
    infoVc.newInfoBlock = ^SWUNewsModel * _Nonnull{
        return cell.model;
    };
//    [infoVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoVc animated:YES];
}








@end

