//
//  SWUScoreViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import "SWUScoreViewController.h"
#import "Constants.h"
#import "SWUPointView.h"
#import "SWUTotalScoreView.h"
#import "SWUScrollerBackView.h"
#import "SWUScoreModel.h"
#import "MJExtension.h"
#import "SWUScoreHeaderView.h"
#import "SWUScoreCell.h"
#import "SWUPickerView.h"
#import "SWUAFN.h"
#import "SWULabel.h"
#import "SVProgressHUD.h"


@interface SWUScoreViewController ()<UITableViewDelegate,UITableViewDataSource,SWUPickerViewDelegate>
/** 时间选择器  */
@property (nonatomic,strong) SWUPickerView *picker;
/** data  */
@property (nonatomic,strong) NSArray *dataArray;
/** 成绩显示的视图  */
@property (nonatomic,strong) SWUScrollerBackView *scrollerBackView;
/** 显示课程成绩的详细信息  */
@property (nonatomic,strong) UITableView *gradeDetailView;
@end

@implementation SWUScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBaseUI];
}
-(void)setUpBaseUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"成绩查询";
    //    添加右边的时钟
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"searchGrade_change"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGradeTime)];
    [imageView addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    SWULabel * titleLabel = [[SWULabel alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY)];
    titleLabel.backgroundColor = SWUCOLOR(143, 119, 181);
    titleLabel.text = @"点击右上角选择学年和学期";
    titleLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:titleLabel];
    
}
-(void)setUpUI:(NSMutableDictionary *)paraDic {
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    //    添加view视图（绩点显示+日期）
    SWUPointView * pointBackView = [SWUPointView swuPointViewWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, 70) DataArray:self.dataArray ParaDic:paraDic];
    [self.view addSubview:pointBackView];
    
    
    //    添加绩点下面的图片
    UIImageView * waterView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"searchGrade_picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    waterView.frame = CGRectMake(0, CGRectGetMaxY(pointBackView.frame), SCREEN_WIDTH, 50);
    [self.view addSubview:waterView];
    
    
    //    总学分数
    SWUTotalScoreView * scoreView = [SWUTotalScoreView swuTotalScoreViewWithFrame:CGRectMake(0, CGRectGetMaxY(waterView.frame), SCREEN_WIDTH, 50) DataArray:self.dataArray];
    [self.view addSubview:scoreView];
    
    //    scrollerview滚动显示成绩的柱状图
    self.scrollerBackView = [SWUScrollerBackView swuScrollerBackViewWithFrame:CGRectMake(0, CGRectGetMaxY(scoreView.frame), SCREEN_WIDTH, 220) DataArray:self.dataArray];
    self.scrollerBackView.center = CGPointMake(self.view.center.x, self.scrollerBackView.center.y);
    [self.view addSubview:_scrollerBackView];
    
    
    //    tableview显示成绩的详细信息
    self.gradeDetailView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollerBackView.frame)+5, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_scrollerBackView.frame)) style:UITableViewStylePlain];
    [self.view addSubview:_gradeDetailView];
    self.gradeDetailView.delegate = self;
    self.gradeDetailView.dataSource = self;
    self.gradeDetailView.showsVerticalScrollIndicator = NO;
    [self.gradeDetailView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.gradeDetailView.separatorColor = [UIColor lightGrayColor];
    self.gradeDetailView.separatorInset = UIEdgeInsetsMake(7, 15, 7, 15);
}

//选择日期
-(void)selectGradeTime {
    self.picker = [[SWUPickerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT/2-125, SCREEN_WIDTH*0.8, 250)];
    self.picker.delegate = self;
    [self.view addSubview:_picker];
}

#pragma mark ------ UITableViewDataSource ------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.gradeDetailView.contentOffset.y < 0) {
        [self.gradeDetailView setContentOffset:CGPointMake(0, 0)];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"score";
    SWUScoreCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWUScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWUScoreHeaderView * view = [[SWUScoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, _gradeDetailView.frame.size.width, 15)];
    return view;
}
#pragma mark ------ SWUPickerViewDelegate ------
-(void)SWUPickerViewDidSelected:(NSMutableDictionary *)paraDic {
    [SVProgressHUD showWithStatus:@"请稍后..."];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [paraDic setObject:[userDefaults objectForKey:@"cardNumber"] forKey:@"swuid"];
    AFHTTPSessionManager * manager = [SWUAFN swuAfnManage];
    [manager.requestSerializer setValue:[userDefaults objectForKey:@"acToken"] forHTTPHeaderField:@"acToken"];
    [manager GET:@"https://freegatty.swuosa.xenoeye.org/api/grade/search" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * success = responseObject[@"success"];
        if (success.integerValue == 0) {
            [SVProgressHUD showErrorWithStatus:@"系统繁忙，发生错误"];
            return ;
        }
        NSDictionary * dic = responseObject[@"result"];
        [self setDataArray:[SWUScoreModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
        if (self.dataArray.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择正确的学年"];
            return;
        }
        [self setUpUI:paraDic];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请选择正确的学年和学期"];
    }];
}



@end
