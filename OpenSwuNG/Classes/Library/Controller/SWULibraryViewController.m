//
//  SWULibraryViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import "SWULibraryViewController.h"
#import "SWULibraryCell.h"
#import "SWULibraryHeaderView.h"
#import "Constants.h"
#import "SWUBookCaseController.h"
#import "SWUFactory.h"
#import "SVProgressHUD.h"
#import "SWUPopularModel.h"
#import "SWUSearchController.h"



@interface SWULibraryViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 存放数据的数组  */
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SWULibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图书馆";
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat WH = self.navigationController.navigationBar.frame.size.height * 0.6;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, WH, WH);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WH, WH)];
    [view addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
//    加载热门图书
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager GET:@"https://freegatty.swuosa.xenoeye.org/library/book/popular" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            weakSelf.dataArray = [SWUFactory getData:responseObject[@"data"] model:[SWUPopularModel class]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络后重试！"];
        }];
    });
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(SWULibraryCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * ID = @"Library";
    SWULibraryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWULibraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWULibraryHeaderView * view = [[SWULibraryHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    SWUBookCaseController *bookcaseVc  =[[SWUBookCaseController alloc] init];
    view.changeVcBlock = ^{
//        进入我的书架
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"cardNumber"] length] <= 0) {
            [SVProgressHUD showInfoWithStatus:@"请先绑定校园卡..."];
            return ;
        }
        [self.navigationController pushViewController:bookcaseVc animated:YES];
    };
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)searchBtnDidClicked {
    SWUSearchController *seachVc = [[SWUSearchController alloc] init];
    [self.navigationController pushViewController:seachVc animated:YES];
}

@end
