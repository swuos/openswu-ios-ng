//
//  SWUMainViewController.m
//  OpenSwuNG
//
//  Created by 501 on 2019/2/16.
//

#import "SWUMainViewController.h"
#import "Constants.h"
#import "SWUMainHeaderView.h"
#import "SVProgressHUD.h"
#import "SWUNewsModel.h"
#import "SWUNewsCell.h"
#import "SWUNewsInfoController.h"
#import "MJRefresh.h"

#import "SWUBaseData.h"
//#import "SWUDataSource.h"
#import "SWUMainDataSource.h"

static NSString * const ID = @"Main";

@interface SWUMainViewController ()<UITableViewDelegate,UITableViewDataSource>
/** headLabel */
@property(nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *currentType;
@property (nonatomic,strong) SWUMainHeaderView *headerView;
@property (nonatomic,assign) BOOL isLoad;
@property (nonatomic,strong) SWUMainDataSource *dataSource;
@end

@implementation SWUMainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.headerView reSetUpSchedule];
}
#pragma mark ------ 私有方法 -------
-(void)setupUI {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isLoad = false;
    
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    self.headLabel.text = @"西大助手";
    self.headLabel.textColor = [UIColor blackColor];
    self.headLabel.font = [UIFont boldSystemFontOfSize:16];
    self.headLabel.numberOfLines = 0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headLabel];
    
    self.currentType = @"热点新闻";
    
    self.tableView.tableHeaderView.frame = self.headerView.frame;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.sectionHeaderHeight = self.headerView.frame.size.height;
    
    [self requestNewData:self.currentType model:[SWUNewsModel class] number:[[self.dataSource getCurrentTypeData:_currentType] count] + 10  update:NO];
    
    [self.tableView layoutIfNeeded];
    [self.view addSubview:self.tableView];
}
//请求数据
-(void)requestNewData:(NSString *)type model:(id)model number:(NSInteger)number update:(BOOL)isUpdate{
    NSInteger count = [[self.dataSource getCurrentTypeData:_currentType] count] ;
    if (count > 0) {
        [self.headerView hideLoadImage];
        //        是否需要刷新数据
        if (!isUpdate) {
            [self.dataSource loadExistTypeData:type];
            [self.tableView reloadData];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
    }else {
        NSLog(@"%@",self.dataSource.dataArray);
        self.dataSource.dataArray = nil;
        [self.tableView reloadData];
    }
    //    正在加载 没必要重新加载
    if (self.isLoad) {
        return;
    }
    if (count >= 25) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    self.isLoad = true;
    
    NSDictionary *dic = @{
                          @"热点新闻":@"crawl/1/",
                          @"通知公告":@"crawl/0/",
                          @"学术看板":@"crawl/2/"
                          };
    
    [SWUBaseData loadDatawithMethod:@"get" url:[NSString stringWithFormat:@"%@%ld",dic[type],number] params:@{} keyword:@"" model:model success:^(NSArray * _Nonnull dataArray) {
        [self.dataSource addDataArray:dataArray currentType:type];
        [self.tableView reloadData];
        [self.headerView hideLoadImage];
        [SVProgressHUD dismiss];
        self.isLoad = false;
    } failure:^(id  _Nonnull error) {
        NSLog(@"%@",error);
        [self.headerView hideLoadImage];
        self.isLoad = true;
    }];
}

#pragma mark ------ UITableViewDelegate -------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SWUNewsModel *model = [self.dataSource modelAtIndexPath:indexPath];
    
    SWUNewsInfoController * infoVc = [[SWUNewsInfoController alloc] init];
    infoVc.newInfoBlock = ^NSDictionary * _Nonnull{
        return @{@"model":model,@"type":self.currentType};
    };
    [self.navigationController pushViewController:infoVc animated:YES];
}

#pragma mark ------ lazyLoad -------
-(UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY)];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self.dataSource;
        
        self.tableView.rowHeight = 80;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerClass:[SWUNewsCell class] forCellReuseIdentifier:ID];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestNewData:self.currentType model:[SWUNewsModel class] number:[[self.dataSource getCurrentTypeData:self.currentType] count]+10 update:YES];
        }];
        
        [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = [UIFont systemFontOfSize:17];
        footer.stateLabel.textColor = [UIColor lightGrayColor];
        self.tableView.mj_footer = footer;
    }
    return _tableView;
}
-(SWUMainHeaderView *)headerView {
    if (!_headerView) {
        self.headerView = [[SWUMainHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, 420)];
        __weak typeof(self) weakSelf = self;
        self.headerView.alertVcBlock = ^(UIViewController * _Nonnull vc) {
            [weakSelf presentViewController:vc animated:YES completion:nil];
        };
        self.headerView.pushVcBlock = ^(UIViewController * _Nonnull vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        self.headerView.changeVcBlock = ^(NSString * _Nonnull type) {
            weakSelf.isLoad = false;
            weakSelf.currentType = type;
            //        热点新闻 通知公告 学术看板
            if ([type isEqualToString:@"热点新闻"]) {
                [weakSelf requestNewData:@"热点新闻" model:[SWUNewsModel class] number:[[weakSelf.dataSource getCurrentTypeData:self.currentType] count]+10 update:NO];
            }
            if ([type isEqualToString:@"通知公告"]) {
                [weakSelf requestNewData:@"通知公告" model:[SWUNewsModel class] number:[[weakSelf.dataSource getCurrentTypeData:self.currentType] count]+10 update:NO];
            }
            if ([type isEqualToString:@"学术看板"]) {
                [weakSelf requestNewData:@"学术看板" model:[SWUNewsModel class] number:[[weakSelf.dataSource getCurrentTypeData:self.currentType] count]+10 update:NO];
            }
        };
    }
    return _headerView;
}
-(SWUMainDataSource *)dataSource {
    if (!_dataSource) {
        self.dataSource = [[SWUMainDataSource alloc] initWithIdentifier:ID configBloc:^(SWUNewsCell *cell, id  _Nullable model, NSIndexPath * _Nullable indexPath) {
            cell.model = model;
        }];
    }
    return _dataSource;
}

#pragma mark ------ rewrite -------
//-(void)reload {
//    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }
//    [self.tableView reloadData];
//}
@end

