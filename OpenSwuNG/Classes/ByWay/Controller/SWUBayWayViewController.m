//
//  SWUBayWayViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/15.
//

#import "SWUBayWayViewController.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "SWUFactory.h"
#import "SWUByWayHeaderView.h"
#import "SWUByWayScrollView.h"
#import "SWUByWayModel.h"



@interface SWUBayWayViewController ()
@property (nonatomic,strong) SWUByWayScrollView *scrollView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation SWUBayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"轻轨查询";
    
    [self setUI];
}


-(void)setUI {
    SWUByWayHeaderView *backView = [[SWUByWayHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:backView];
    backView.searchBtnBlock = ^(NSString * _Nonnull start, NSString * _Nonnull end, CGFloat positionY) {
    //https://www.cqmetro.cn/Front/html/TakeLine!queryYsTakeLine.action?entity.startStaName=%25E9%2587%258D%25E5%25BA%2586%25E5%259B%25BE%25E4%25B9%25A6%25E9%25A6%2586&entity.endStaName=%25E6%25B2%2599%25E5%259D%25AA%25E5%259D%259D
        [SVProgressHUD showWithStatus:@"查询中。。。。。"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        //    https://nshipster.cn/nscharacterset/
        NSString *url = [NSString stringWithFormat:@"https://www.cqmetro.cn/Front/html/TakeLine!queryYsTakeLine.action?entity.startStaName=%@&entity.endStaName=%@",start,end];
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@",url);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
            [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.dataArray = [SWUFactory getData:responseObject[@"result"] model:[SWUByWayModel class]];
//                NSLog(@"%ld",self.dataArray.count);
                [self addByWayScrollView:positionY];
                [SVProgressHUD dismiss];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"出现错误,请重试！"];
            }];
        });
    };
    
    backView.selectStationBlock = ^(UIView * _Nonnull picker) {
        [self.view addSubview:picker];
    };
    
    
    
}
-(void)addByWayScrollView:(CGFloat)positionY {
    if (_scrollView) {
        [self.scrollView removeFromSuperview];
    }
        self.scrollView = [[SWUByWayScrollView alloc] initWithFrame:CGRectMake(100,300, self.view.frame.size.width, self.view.frame.size.height) dataArray:self.dataArray];
        [self.view addSubview:self.scrollView];
        self.scrollView.layer.cornerRadius = 3;
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.view).offset(positionY);
            make.bottom.equalTo(self.view).offset(0);
        }];
//    }
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}






@end
