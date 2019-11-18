//
//  SWUMinePublisViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import "SWUMinePublisViewController.h"
#import "SWULostCell.h"
#import "SVProgressHUD.h"
#import "SWUFactory.h"
#import "SWULostModel.h"
#import "MJRefresh.h"
#import "SWULibraryPlaceHoldCell.h"
#import "Constants.h"


@interface SWUMinePublisViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger currentArrayCount;
@end

@implementation SWUMinePublisViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的发布";
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.tableView];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    //    刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNewDataPageNumber:self.dataArray.count/20+1 model:[SWULostModel class]];
    }];
    [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.tableView.mj_footer = footer;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self requestNewDataPageNumber:self.dataArray.count/20+1 model:[SWULostModel class]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark ------ dataSource delegate -------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count > 0 ? self.dataArray.count:1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count <= 0) {
        self.tableView.mj_footer = nil;
        SWULibraryPlaceHoldCell *cell = [[SWULibraryPlaceHoldCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        return cell;
    }
    NSString * ID = @"MineLost";
    SWULostCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWULostCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        SWULostModel *model = self.dataArray[indexPath.row];
        NSLog(@"%@",model.id);
        [self deleteLostData:model];
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    }];
//    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"点击了编辑");
//    }];
//    editAction.backgroundColor = [UIColor grayColor];
    
//    return @[deleteAction, editAction];
    return @[deleteAction];
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleDelete;
}

//// 修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}


//ios11
//-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //删除
//    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        [self.titleArr removeObjectAtIndex:indexPath.row];
//        completionHandler (YES);
//        [self.tableView reloadData];
//    }];
//    deleteRowAction.image = [UIImage imageNamed:@"删除"];
//    deleteRowAction.backgroundColor = [UIColor redColor];
//
//    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
//    return config;
//}
#pragma mark ------ 数据请求 -------
-(void)requestNewDataPageNumber:(NSInteger)pageNumber model:(id)model{
    if (self.currentArrayCount == self.dataArray.count && self.dataArray.count > 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    self.currentArrayCount = self.dataArray.count;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
//        NSString *url = [NSString stringWithFormat:@"https://freegatty.swuosa.xenoeye.org/queryLostFoundRecord?pageSize=20&pageNo=%ld",pageNumber];
                NSString *url = [NSString stringWithFormat:@"https://freegatty.swuosa.xenoeye.org/queryLostFoundRecord?phoneNumber=%@&pageSize=20&pageNo=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"],pageNumber];
        //        NSLog(@"%@",url);
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.tableView.mj_footer endRefreshing];
            NSArray *tempArray = [self convertToArray:responseObject[@"data"]];
            tempArray = [SWUFactory getData:tempArray model:model];
            [self.dataArray addObjectsFromArray:tempArray];
//            NSLog(@"%ld",self.dataArray.count);
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"出现错误"];
        }];
    });
}

-(void)deleteLostData:(SWULostModel *)lostModel {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        NSString *url = @"https://freegatty.swuosa.xenoeye.org/deleteLostFoundRecord";
        [manager POST:url parameters:@{@"id":lostModel.id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.dataArray removeObject:lostModel];
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"出现错误"];
        }];
    });
}

-(NSArray *)convertToArray:(NSDictionary *)Dic {
    NSMutableArray *dataArr = [NSMutableArray array];
    NSDictionary *dic = [NSDictionary dictionary];
    for (int i = 1; i < 21; i++) {
        dic = Dic[[NSString stringWithFormat:@"%d",i]];
        //        最后返回的不是20个
        if (dic == nil) {
            return dataArr;
        }
        [dataArr addObject:dic];
    }
    return dataArr;
}

@end
