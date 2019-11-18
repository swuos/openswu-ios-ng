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
#import "MJRefresh.h"


@interface SWUMainViewController ()<UITableViewDelegate,UITableViewDataSource>
/** headLabel */
@property(nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *totalDic;
@property (nonatomic,strong) NSString *currentType;
@property (nonatomic,strong) SWUMainHeaderView *headerView;
@end

@implementation SWUMainViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    设置标题
    [self setUpHead];
    
    self.currentType = @"热点新闻";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.totalDic = [NSMutableDictionary dictionary];
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNewData:self.currentType model:[SWUNewsModel class] number:[self.totalDic[self.currentType] count]+10 update:YES];
    }];
    [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.tableView.mj_footer = footer;
    
    //    定制头部的视图
    self.headerView = [[SWUMainHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, 450)];
    __weak typeof(self) weakSelf = self;
    self.headerView.alertVcBlock = ^(UIViewController * _Nonnull vc) {
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    self.headerView.pushVcBlock = ^(UIViewController * _Nonnull vc) {
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.headerView.changeVcBlock = ^(NSString * _Nonnull name) {
        weakSelf.currentType = name;
        //        热点新闻 通知公告 学术看板
        if ([name isEqualToString:@"热点新闻"]) {
            [weakSelf requestNewData:@"热点新闻" model:[SWUNewsModel class] number:[weakSelf.totalDic[name] count]+10 update:NO];
        }
        if ([name isEqualToString:@"通知公告"]) {
            [weakSelf requestNewData:@"通知公告" model:[SWUNewsModel class] number:[weakSelf.totalDic[name] count]+10 update:NO];
        }
        if ([name isEqualToString:@"学术看板"]) {
            [weakSelf requestNewData:@"学术看板" model:[SWUNewsModel class] number:[weakSelf.totalDic[name] count]+10 update:NO];
        }
    };
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = self.headerView.frame.size.height;
//    [self requestNewData:self.currentType model:[SWUNewsModel class] number:[self.totalDic[self.currentType] count] + 10  update:NO];
    
    [self.tableView layoutIfNeeded];
    
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.headerView reSetUpSchedule];
}

//请求数据
-(void)requestNewData:(NSString *)name model:(id)model number:(NSInteger)number update:(BOOL)isUpdate{
    if ([self.totalDic[name] count] > 0) {
        if (!isUpdate) {
            self.dataArray = self.totalDic[name];
            [self.tableView reloadData];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
    }
//    NSLog(@"%ld",(long)number);
    if (self.dataArray.count >= 35) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    NSDictionary *dic = @{
                          @"热点新闻":@"https://freegatty.swuosa.xenoeye.org/crawl/1/",
                          @"通知公告":@"https://freegatty.swuosa.xenoeye.org/crawl/0/",
                          @"学术看板":@"https://freegatty.swuosa.xenoeye.org/crawl/2/"
                          };
    __block NSArray *tmpArray;
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",dic[name],number]);
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager GET:[NSString stringWithFormat:@"%@%ld",dic[name],number] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            tmpArray = [SWUFactory getData:responseObject model:model];
//            NSLog(@"%@ %ld",name,tmpArray.count);
            weakSelf.totalDic[name] = tmpArray;
            weakSelf.dataArray = tmpArray;
            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"出现错误"];
        }];
    });
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

#pragma mark ------ UITableViewDelegate -------
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
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWUNewsCell *cell = (SWUNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    SWUNewsInfoController * infoVc = [[SWUNewsInfoController alloc] init];
    infoVc.newInfoBlock = ^NSDictionary * _Nonnull{
         return @{@"model":cell.model,@"name":self.currentType};
    };
    [self.navigationController pushViewController:infoVc animated:YES];
}


@end

