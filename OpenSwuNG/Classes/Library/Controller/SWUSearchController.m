//
//  SWUSearchController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/14.
//

#import "SWUSearchController.h"
#import "SVProgressHUD.h"
#import "SWUBookCaseCell.h"
#import "SWUFactory.h"
#import "SWULibraryCell.h"

#import "MJRefresh.h"


@interface SWUSearchController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
@end

@implementation SWUSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    UIView *searchBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.5, self.searchTextField.frame.size.height)];
    [searchBackView addSubview:self.searchTextField];
    self.navigationItem.titleView = searchBackView;
    
    CGFloat WH = self.navigationController.navigationBar.frame.size.height * 0.8;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, WH*1.5, WH);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.5*WH, WH)];
    [view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    btn.alpha = 0.6;
    btn.layer.cornerRadius = WH * 0.5;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    [self.view addSubview:self.tableView];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark ------ UITextFieldDelegate -------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField canBecomeFirstResponder]) {
        //成为第一响应者。弹出键盘
        [textField becomeFirstResponder];
    }
    return  YES;
}

#pragma mark ------ uitabledataSource delegate  -------
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
    NSString * ID = @"search";
    SWULibraryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWULibraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark ------ 自定义方法 -------
-(void)searchBtnDidClicked {
    [self.footer setTitle:@"(∩_∩) 没有更多数据啦！" forState:MJRefreshStateNoMoreData];
    if ([self.searchTextField canResignFirstResponder]) {
        //取消第一响应者。收回键盘
        [self.searchTextField resignFirstResponder];
    }
    self.dataArray = [NSArray array];
    NSString *url = [NSString stringWithFormat:@"https://freegatty.swuosa.xenoeye.org/library/book/search/%@/%d",self.searchTextField.text,10];
    NSLog(@"%@",url);
    [SVProgressHUD showWithStatus:@"加载中。。。。。"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [self requestNewData:url];
}

-(void)requestNewData:(NSString *)url {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self) weakSelf = self;
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            weakSelf.dataArray = [SWUFactory getData:responseObject[@"data"] model:[SWUPopularModel class]];
            if (weakSelf.dataArray.count <= 0) {
                [SVProgressHUD showInfoWithStatus:@"暂无馆藏～～～"];
            }
            [self reload];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络后重试！"];
        }];
    });
}

#pragma mark ------ lazyLoad -------
//@property (nonatomic,strong) UITextField *searchTextField;
-(UITextField *)searchTextField {
    if (!_searchTextField) {
        CGFloat searchHeight = self.navigationController.navigationBar.frame.size.height * 0.7;
        CGFloat radius = searchHeight * 0.5;
        UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.5, searchHeight)];
        searchTextField.layer.borderWidth = 0.5;
        searchTextField.layer.borderColor = [UIColor orangeColor].CGColor;
        searchTextField.layer.cornerRadius = radius;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, radius, searchHeight)];
        searchTextField.leftView = leftView;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextField = searchTextField;
    }
    return _searchTextField;
}
//@property (nonatomic,strong) UITableView *tableView;
-(UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44, self.view.frame.size.width, self.view.frame.size.height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.sectionHeaderHeight = 0;
        
        self.tableView.mj_footer = self.footer;
    }
    return _tableView;
}
-(MJRefreshAutoNormalFooter *)footer {
    if (!_footer) {
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
        [self.footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [self.footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [self.footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        self.footer.stateLabel.font = [UIFont systemFontOfSize:17];
        self.footer.stateLabel.textColor = [UIColor lightGrayColor];
    }
    return _footer;
}

-(void)reload {
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];
}



@end
