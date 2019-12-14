//
//  SWUBookCaseController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import "SWUBookCaseController.h"
#import "SWUBookCaseHeaderView.h"
#import "SWUFactory.h"
#import "SVProgressHUD.h"
#import "SWUBookCaseCell.h"
#import "SWULibraryHistoryModel.h"
#import "SWULibraryBorrowingModel.h"
#import "SWULibraryCollectModel.h"
#import "Constants.h"
#import "MJRefresh.h"

#import "SWUBaseData.h"
#import "SWUMainDataSource.h"

static NSString *const ID = @"Bookcase";

@interface SWUBookCaseController ()<UITableViewDelegate,UITableViewDataSource>
/** 存放数据的数组  */
@property (nonatomic,strong) NSUserDefaults *userDefault;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *currentType;
@property (nonatomic,strong) NSString *cookieName;
@property (nonatomic,strong) SWUBookCaseHeaderView *headerView;

@property (nonatomic,strong) SWUMainDataSource *dataSource;
@end

@implementation SWUBookCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我的书架";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *classDic = @{
                               @"借阅历史":@"SWULibraryHistoryModel",
                               @"收藏书籍":@"SWULibraryCollectModel",
                               @"在借书籍":@"SWULibraryBorrowingModel"
                               };
    //    添加头部按钮
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    __weak typeof (self) weakSelf = self;
    self.headerView.changeVcBlock = ^(NSString * _Nonnull type) {
        [weakSelf requestNewData:type model:NSClassFromString(classDic[type])];
    };
    
    //    登陆
    dispatch_queue_t queue = dispatch_queue_create("bookCaseQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        NSDictionary * dic = @{
                               @"username":[self.userDefault objectForKey:@"cardNumber"],
                               @"password":[self.userDefault objectForKey:@"cardNumberPwd"]
                               };
        [SVProgressHUD showWithStatus:@"图书馆登陆中。。。。"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [manager POST:@"https://freegatty.swuosa.xenoeye.org/library/login/doLogin" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic1 = responseObject[@"data"];
            self.cookieName = dic1[@"cookieName"];
            [SVProgressHUD dismiss];
            [self requestNewData:@"借阅历史" model:NSClassFromString(classDic[@"借阅历史"])];
            [self.tableView layoutIfNeeded];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络后重试！"];
        }];
    });
}

#pragma mark ------ 自定义方法 -------

//请求数据
-(void)requestNewData:(NSString *)type model:(id)model{
    if ( [[self.dataSource getCurrentTypeData:type] count] > 0 ) {
        [self.dataSource loadExistTypeData:type];
        [self.tableView.mj_footer endRefreshing];
        [self reload];
        return;
    }
    NSDictionary *dic = @{
                          @"借阅历史":@"library/user/history/0",
                          @"收藏书籍":@"library/user/collect/0",
                          @"在借书籍":@"library/user/borrowing/0"
                          };
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    [SWUBaseData loadDatawithMethod:@"get" url:dic[type] params:@{@"cookieName":self.cookieName} keyword:@"data" model:model success:^(NSArray * _Nonnull dataArray) {
        if (dataArray.count <= 0) {
            [SVProgressHUD showProgress:1.5 status:@"暂无数据～～～"];
        }
        [self.dataSource addDataArray:dataArray currentType:type];
        [self reload];
        [SVProgressHUD dismiss];
    } failure:^(id  _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"请求出现错误"];
    }];
}

#pragma mark ------ lazyLoad -------
-(SWUBookCaseHeaderView *)headerView {
    if (!_headerView) {
        self.headerView= [[SWUBookCaseHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, self.view.frame.size.width, 30)];
    }
    return _headerView;
}
-(UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.headerView.frame.origin.y+self.headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self.dataSource;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[SWUBookCaseCell class] forCellReuseIdentifier:ID];
        self.tableView.sectionHeaderHeight = 0;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
        [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = [UIFont systemFontOfSize:17];
        footer.stateLabel.textColor = [UIColor lightGrayColor];
        self.tableView.mj_footer = footer;
    }
    return _tableView;
}
-(SWUMainDataSource *)dataSource {
    if (!_dataSource) {
        self.dataSource = [[SWUMainDataSource alloc] initWithIdentifier:ID configBloc:^(SWUBookCaseCell *cell, id  _Nullable model, NSIndexPath * _Nullable indexPath) {
            cell.model = model;
        }];
    }
    return _dataSource;
}

-(void)reload {
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];
}



@end
