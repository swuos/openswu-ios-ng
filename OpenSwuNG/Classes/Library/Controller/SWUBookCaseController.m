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
#import "MJRefresh.h"


@interface SWUBookCaseController ()<UITableViewDelegate,UITableViewDataSource>
/** 存放数据的数组  */
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSUserDefaults *userDefault;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *totalDic;
@property (nonatomic,strong) NSString *currentType;
@end

@implementation SWUBookCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我的书架";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userDefault = [NSUserDefaults standardUserDefaults];
    
    self.totalDic = [NSMutableDictionary dictionary];
    
    NSDictionary *classDic = @{
                               @"借阅历史":@"SWULibraryHistoryModel",
                               @"收藏书籍":@"SWULibraryCollectModel",
                               @"在借书籍":@"SWULibraryBorrowingModel"
                               };
    //    添加头部按钮
    SWUBookCaseHeaderView *headerView = [[SWUBookCaseHeaderView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, self.view.frame.size.width, 30)];
    [self.view addSubview:headerView];
    headerView.changeVcBlock = ^(NSString * _Nonnull name) {
        [self requestNewData:name model:NSClassFromString(classDic[name])];
    };
    
    //    添加tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.frame.origin.y+headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    //    登陆
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        NSDictionary * dic = @{
                               @"username":[self.userDefault objectForKey:@"cardNumber"],
                               @"password":[self.userDefault objectForKey:@"cardNumberPwd"]
                               };
        [SVProgressHUD showWithStatus:@"图书馆登陆中。。。。"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [manager POST:@"https://freegatty.swuosa.xenoeye.org/library/login/doLogin" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic1 = responseObject[@"data"];
            [self.userDefault setObject:dic1[@"cookieName"] forKey:@"cookieName"];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络后重试！"];
        }];
    });
    [self requestNewData:@"借阅历史" model:NSClassFromString(classDic[@"借阅历史"])];
    [self.tableView layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray != nil) {
        return self.dataArray.count > 0 ? self.dataArray.count:1;
    }
    return 0;
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

#pragma mark ------ 自定义方法 -------

//请求数据
-(void)requestNewData:(NSString *)name model:(id)model{
    if ([self.totalDic[name] count] > 0) {
        self.dataArray = self.totalDic[name];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        return;
    }
    NSDictionary *dic = @{
                          @"借阅历史":@"https://freegatty.swuosa.xenoeye.org/library/user/history/0",
                          @"收藏书籍":@"https://freegatty.swuosa.xenoeye.org/library/user/collect/0",
                          @"在借书籍":@"https://freegatty.swuosa.xenoeye.org/library/user/borrowing/0"
                          };
    __block NSArray *tmpArray;
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookieName"] forHTTPHeaderField:@"cookieName"];
        [manager GET:dic[name] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@ %@",model,name);
//            NSLog(@"%@",responseObject);
            tmpArray = [SWUFactory getData:responseObject[@"data"] model:model];
            weakSelf.totalDic[name] = tmpArray;
            weakSelf.dataArray = tmpArray;
            if (weakSelf.dataArray.count <= 0) {
                [SVProgressHUD showProgress:1 status:@"暂无数据～～～"];
            }
//            NSLog(@"%ld",tmpArray.count);
            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"出现错误"];
        }];
    });
}




@end
