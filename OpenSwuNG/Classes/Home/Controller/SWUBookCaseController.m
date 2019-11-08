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
#import "SWULibraryPlaceHoldCell.h"
#import "Constants.h"


@interface SWUBookCaseController ()<UITableViewDelegate,UITableViewDataSource>
/** 存放数据的数组  */
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSUserDefaults *userDefault;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SWUBookCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我的书架";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userDefault = [NSUserDefaults standardUserDefaults];
    __block NSArray *historyArr;
    __block NSArray *boworringArr;
    __block NSArray *collectArr;
    //    添加头部按钮
    SWUBookCaseHeaderView *headerView = [[SWUBookCaseHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, self.view.frame.size.width, 30)];
    [self.view addSubview:headerView];
    headerView.changeVcBlock = ^(NSString * _Nonnull name) {
        if ([name isEqualToString:@"借阅历史"]) {
            if (historyArr) {
                self.dataArray = historyArr;
                [self.tableView reloadData];
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookieName"] forHTTPHeaderField:@"cookieName"];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/library/user/history/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    historyArr = [SWUFactory getData:responseObject[@"data"] model:[SWULibraryHistoryModel class]];
                    weakSelf.dataArray = historyArr;
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
        if ([name isEqualToString:@"在借书籍"]) {
            if (boworringArr) {
                self.dataArray = boworringArr;
                [self.tableView reloadData];
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookieName"] forHTTPHeaderField:@"cookieName"];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/library/user/borrowing/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    boworringArr = [SWUFactory getData:responseObject[@"data"] model:[SWULibraryBorrowingModel class]];
                    weakSelf.dataArray = boworringArr;
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
        if ([name isEqualToString:@"收藏书籍"]) {
            if (collectArr) {
                self.dataArray = collectArr;
                [self.tableView reloadData];
                return ;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                __weak typeof(self) weakSelf = self;
                AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookieName"] forHTTPHeaderField:@"cookieName"];
                [manager GET:@"https://freegatty.swuosa.xenoeye.org/library/user/collect/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    collectArr = [SWUFactory getData:responseObject[@"data"] model:[SWULibraryCollectModel class]];
                    weakSelf.dataArray = collectArr;
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
            });
        }
        
    };
    
    //    添加tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.frame.origin.y+headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        NSDictionary * dic = @{
                               @"username":[self.userDefault objectForKey:@"cardNumber"],
                               @"password":[self.userDefault objectForKey:@"cardNumberPwd"]
                               };
        [manager POST:@"https://freegatty.swuosa.xenoeye.org/library/login/doLogin" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic1 = responseObject[@"data"];
            [self->_userDefault setObject:dic1[@"cookieName"] forKey:@"cookieName"];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络后重试！"];
        }];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookieName"] forHTTPHeaderField:@"cookieName"];
        [manager GET:@"https://freegatty.swuosa.xenoeye.org/library/user/history/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            historyArr = [SWUFactory getData:responseObject[@"data"] model:[SWULibraryHistoryModel class]];
            weakSelf.dataArray = historyArr;
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    });
    [self.tableView layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count > 0) {
        return self.dataArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"Bookcase";
    if (self.dataArray.count <= 0) {
        SWULibraryPlaceHoldCell *cell = [[SWULibraryPlaceHoldCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        return cell;
    }
    SWUBookCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWUBookCaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}




@end
