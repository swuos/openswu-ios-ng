//
//  SWUMinePublisViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import "SWUMinePublisViewController.h"
#import "SWULostCell.h"
#import "SVProgressHUD.h"
#import "SWULostModel.h"
#import "MJRefresh.h"
#import "Constants.h"

#import "SWUBaseData.h"
#import "SWUDataSource.h"

@interface SWUMinePublisViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger currentArrayCount;
@property (nonatomic,strong) SWUDataSource *dataSource;

@end
static NSString * const ID = @"lost";
@implementation SWUMinePublisViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的发布";
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self requestNewDataPageNumber:self.dataSource.dataArray.count/20+1 model:[SWULostModel class]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark ------delegate -------
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
        SWULostModel *model = [self.dataSource modelAtIndexPath:indexPath];
        [self deleteLostData:model];
        if (self.refreshBlock) {
            self.refreshBlock(model);
        }
    }];
    return @[deleteAction];
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleDelete;
}

#pragma mark ------ 数据请求 -------
-(void)requestNewDataPageNumber:(NSInteger)pageNumber model:(id)model{
    if (self.currentArrayCount == self.dataSource.dataArray.count && self.dataSource.dataArray.count > 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    self.currentArrayCount = self.dataSource.dataArray.count;
    
    [SWUBaseData loadDatawithMethod:@"get" url:[NSString stringWithFormat:@"queryLostFoundRecord?phoneNumber=%@&pageSize=20&pageNo=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"],pageNumber] params:@{} keyword:@"data" model:model success:^(NSArray * _Nonnull dataArray) {
        [self.dataSource addDataArray:dataArray];
        [self reload];
        [SVProgressHUD dismiss];
    } failure:^(id  _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"出现错误"];
    }];
}

-(void)deleteLostData:(SWULostModel *)lostModel {
    [SWUBaseData loadDatawithMethod:@"post" url:@"deleteLostFoundRecord" params:@{@"id":lostModel.id} keyword:@"data" model:nil success:^(NSArray * _Nonnull dataArray) {
        [self.dataSource removeData:lostModel];
        [self reload];
    } failure:^(id  _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"出现错误"];
    }];
}

#pragma mark ------ lazyLoad -------

-(UITableView *)tableView {
    if(!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.tableView.dataSource = self.dataSource;
        self.tableView.delegate = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.tableView registerClass:[SWULostCell class] forCellReuseIdentifier:ID];
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        //    刷新
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestNewDataPageNumber:self.dataSource.dataArray.count/20+1 model:[SWULostModel class]];
        }];
        [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = [UIFont systemFontOfSize:17];
        footer.stateLabel.textColor = [UIColor lightGrayColor];
        self.tableView.mj_footer = footer;
    }
    return _tableView;
}
-(SWUDataSource *)dataSource {
    if(!_dataSource){
        self.dataSource = [[SWUDataSource alloc] initWithIdentifier:ID configBloc:^(SWULostCell *cell, id  _Nullable model, NSIndexPath * _Nullable indexPath) {
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
