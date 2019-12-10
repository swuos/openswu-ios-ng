//
//  SWULostViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/15.
//

#import "SWULostViewController.h"
#import "SWULostCell.h"
#import "SVProgressHUD.h"
#import "SWULostModel.h"
#import "SWUPublishViewController.h"
#import "SWUMinePublisViewController.h"
#import "MJRefresh.h"
#import "Constants.h"

#import "SWUDataSource.h"
#import "SWUBaseData.h"

#define WHBtn 60
#define leftPadding 70
#define bottom 150
@interface SWULostViewController ()<UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL isChanged;//悬浮按钮
@property (nonatomic,strong) UIButton *publishBtn;
@property (nonatomic,strong) UIButton *minePublishBtn;
@property (nonatomic,strong) UIView *hideView;
@property (nonatomic,strong) UIButton *floatBtn;
@property (nonatomic,assign) NSInteger currentArrayCount;

@property (nonatomic,strong) SWUDataSource *dataSource;

@end
static NSString * const ID = @"Lost";
@implementation SWULostViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"失物招领";
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.isChanged = NO;
    //    添加悬浮按钮
    [self.view addSubview:self.publishBtn];
    [self.view addSubview:self.minePublishBtn];
    [self.view addSubview:self.hideView];
    [self.view addSubview:self.floatBtn];
    [self requestNewDataPageNumber:self.dataSource.dataArray.count/20+1 model:[SWULostModel class]];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


#pragma mark ------ delegate -------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    
    [SWUBaseData loadDatawithMethod:@"get" url:[NSString stringWithFormat:@"queryLostFoundRecord?pageSize=20&pageNo=%ld",pageNumber] params:nil keyword:@"data" model:model success:^(NSArray * _Nonnull dataArray) {
        [self.tableView.mj_footer endRefreshing];
        [self.dataSource addDataArray:dataArray];
        [self reload];
        [SVProgressHUD dismiss];
    } failure:^(id  _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"出现错误"];
    }];
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
#pragma mark ------ 悬浮按钮方法 -------
-(void)addBtnClicked:(UIButton *)btn {
    if (!_isChanged) {
        _isChanged = YES;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.05 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.publishBtn.transform = CGAffineTransformMakeTranslation(-70,-70);
            self.minePublishBtn.transform = CGAffineTransformMakeTranslation(70,-70);
        } completion:nil];
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformRotate(btn.transform, M_PI_2);
        }];
    }else {
        _isChanged = NO;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.05 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.publishBtn.transform = CGAffineTransformIdentity;
            self.minePublishBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }
    
    
}
-(void)moveByTouch:(UIPanGestureRecognizer *)pan {
    UIButton *btn = (UIButton *)pan.view;
    CGFloat HEIGHT=btn.frame.size.height;
    CGFloat WIDTH=btn.frame.size.width;
    BOOL isOver = NO;

    CGPoint translatePoint = [pan translationInView:self.view];
    
    [pan setTranslation:CGPointZero inView:self.view];
    
    if(pan.state == UIGestureRecognizerStateChanged){
        btn.center = CGPointMake(btn.center.x + translatePoint.x, btn.center.y + translatePoint.y);
        self.hideView.center = btn.center;
        self.publishBtn.center = btn.center;
        self.minePublishBtn.center = btn.center;
    }
    else if(pan.state == UIGestureRecognizerStateEnded){
        CGPoint endCenter = btn.center;
        if (endCenter.x + WIDTH*0.5 + 70 > self.view.frame.size.width) {
            endCenter.x = self.view.frame.size.width - WIDTH*0.5 - 70;
            isOver = YES;
        } else if (endCenter.y + HEIGHT > self.view.frame.size.height) {
            endCenter.y = self.view.frame.size.height - HEIGHT*0.5;
            isOver = YES;
        } else if(endCenter.x - WIDTH / 2.0 -70 < 0) {
            endCenter.x = WIDTH / 2.0 +70;
            isOver = YES;
        } else if(endCenter.y - HEIGHT / 2 < 0) {
            endCenter.y = HEIGHT / 2.0;
            isOver = YES;
        }
        if (isOver) {
            [UIView animateWithDuration:0.3 animations:^{
                btn.center = endCenter;
                self.hideView.center = btn.center;
                self.publishBtn.center = btn.center;
                self.minePublishBtn.center = btn.center;
            }];
        }
    }
}

-(void)minePublishBtnClicked:(UIButton *)btn {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"cardNumber"] length] <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先绑定校园卡..."];
        return ;
    }
    SWUMinePublisViewController *minePublishVc = [[SWUMinePublisViewController alloc] init];
    minePublishVc.refreshBlock = ^(SWULostModel *model) {
        [self.dataSource.dataArray removeAllObjects];
        [self reload];
        [self requestNewDataPageNumber:1 model:[SWULostModel class]];
    };
    [self.navigationController pushViewController:minePublishVc animated:YES];
}

-(void)PublishBtnClicked:(UIButton *)btn {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"cardNumber"] length] <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先绑定校园卡..."];
        return ;
    }
    SWUPublishViewController *publishVc = [[SWUPublishViewController alloc] init];
    
    publishVc.refreshBlock = ^{
        [self requestNewDataPageNumber:1 model:[SWULostModel class]];
    };
    [self.navigationController pushViewController:publishVc animated:YES];
}

#pragma mark ------ lazyLoad -------
-(UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.tableView.dataSource = self.dataSource;
        self.tableView.delegate = self;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        self.tableView.separatorColor = [UIColor lightGrayColor];
        [self.tableView registerClass:[SWULostCell class] forCellReuseIdentifier:ID];
        
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
    if (!_dataSource) {
        self.dataSource = [[SWUDataSource alloc] initWithIdentifier:ID configBloc:^(SWULostCell *cell, id  _Nullable model, NSIndexPath * _Nullable indexPath) {
            cell.model = model;
        }];
    }
    return _dataSource;
}
//@property (nonatomic,strong) UIButton *publishBtn;
-(UIButton *)publishBtn {
    if (!_publishBtn) {
        self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.publishBtn.frame = self.floatBtn.frame;
        [self.publishBtn setTitle:@"发" forState:UIControlStateNormal];
        self.publishBtn.tintColor = [UIColor whiteColor];
        self.publishBtn.layer.cornerRadius = WHBtn * 0.5;
        [self.publishBtn addTarget:self action:@selector(PublishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.publishBtn.backgroundColor = [UIColor colorWithRed:254/255.0 green:148/255.0 blue:23/255.0 alpha:1.0];
    }
    return _publishBtn;
}
//@property (nonatomic,strong) UIButton *minePublishBtn;
-(UIButton *)minePublishBtn {
    if (!_minePublishBtn) {
        self.minePublishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minePublishBtn.frame = self.floatBtn.frame;
        [self.minePublishBtn setTitle:@"我" forState:UIControlStateNormal];
        [self.minePublishBtn addTarget:self action:@selector(minePublishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.minePublishBtn.backgroundColor = [UIColor colorWithRed:52/255.0 green:170/255.0 blue:245/255.0 alpha:1.0];
        self.minePublishBtn.layer.cornerRadius = WHBtn * 0.5;
    }
    return _minePublishBtn;
}
-(UIButton *)floatBtn {
    if (!_floatBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width-WHBtn-leftPadding,self.tableView.frame.size.height -2*bottom, WHBtn, WHBtn);
        btn.alpha = 1.0;
        btn.layer.cornerRadius = WHBtn * 0.5;
        [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveByTouch:)];
        [btn addGestureRecognizer:drag];
        self.floatBtn = btn;
    }
    return _floatBtn;
}
//@property (nonatomic,strong) UIView *hideView;
-(UIView *)hideView {
    if (!_hideView) {
        UIView *hideView = [[UIView alloc] initWithFrame:self.floatBtn.frame];
        hideView.backgroundColor = [UIColor whiteColor];
        self.hideView = hideView;
        self.hideView.layer.cornerRadius = self.floatBtn.layer.cornerRadius;
    }
    return _hideView;
}

#pragma mark ------ privateMethod -------

-(void)reload {
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];
}

@end

