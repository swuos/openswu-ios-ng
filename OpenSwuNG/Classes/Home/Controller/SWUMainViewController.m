//
//  SWUMainViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/16.
//

#import "SWUMainViewController.h"
#import "SWUScoreViewController.h"
#import "../View/SWUHomeBanner.h"
#import "../View/SWUMainButton.h"
#import "../View//SWUHomeSchedule.h"
#import "../View/SWUHomeScheduleSubview.h"
#import "../../Constants.h"
#import "Masonry.h"
#import "SWUAFN.h"
#import "SVProgressHUD.h"
#import "NSDate+DistanceOfTimes.h"
#import "Data.h"
#import "Weekitem.h"
#import "MJExtension.h"


@interface SWUMainViewController () <UIScrollViewDelegate>
/** headLabel */
@property(nonatomic,strong)UILabel * headLabel;
/** banner */
@property(nonatomic,strong)SWUHomeBanner* banner;
/** 4个button的数组*/
@property(nonatomic,strong)NSMutableArray* buttons;
/** scheduleHead */
@property(nonatomic,strong)UILabel* scheduleHeadLabel;
/** schedule */
@property(nonatomic,strong)SWUHomeSchedule *schedule;
/** newsHead */
@property(nonatomic,strong)UILabel* newsHeadLabel;
/** news */
@property(nonatomic,strong)UITableView *news;
/** userDefaults  */
@property (nonatomic,strong) NSUserDefaults * userDefaults;
/** 存储课程信息的dataArray  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUMainViewController
-(NSArray *)dataArray {
    if (!_dataArray) {
        [Data mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"weekitem":[Weekitem class]};
        }];
        _dataArray = [Data mj_objectArrayWithFile:CACHE_PATH(@"schedule.plist")];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setUpUi];
}


-(void)setUpUi{
    self.view.backgroundColor = [UIColor whiteColor];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self setHead];
    [self setBanner];
    [self setButton];
    [self setSchedule];
    [self setNews];
}

#pragma mark - “西大助手”Label
-(void)setHead{
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];    _headLabel.text = @"西大助手";
    _headLabel.textColor = [UIColor blackColor];
    _headLabel.font = [UIFont boldSystemFontOfSize:16];
    _headLabel.numberOfLines = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_headLabel];
}

#pragma mark - banner
-(void)setBanner{
    [self.view layoutIfNeeded];
    _banner=[SWUHomeBanner bannerWithFrame:CGRectMake(15,NAVA_MAXY+5, SCREEN_WIDTH-15.0*2, (SCREEN_WIDTH-15.0*2)*160.0/345.0) ];
    [_banner setDelegate:self];
    [self.view addSubview:_banner];
}

#pragma mark - buttons
-(void)setButton{
    _buttons = [NSMutableArray arrayWithCapacity:4];
    //图片和标题
    NSArray* titles = @[@"成绩查询",@"我的钱包",@"水费查询",@"图书查询"];
    NSArray* images = @[@"main_grade",@"main_wallet",@"main_water",@"main_library"];
    CGFloat padding = 22;
    CGFloat cellHW = (SCREEN_WIDTH-8*padding)/4.0;
    [self.view layoutIfNeeded];
    for(int i=0;i<4;i++){
        SWUMainButton * btn = [SWUMainButton initWithFrame:CGRectMake(padding+(cellHW +2*padding)*i, CGRectGetMaxY(_banner.frame)+12, cellHW, cellHW+20) imageName:images[i] Title:titles[i]];
        btn.userInteractionEnabled = YES;
        [self.view addSubview:btn];
        [_buttons addObject:btn];
    }
    UITapGestureRecognizer * tapGestureOfGrades = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfGrades)];
    UITapGestureRecognizer * tapGestureOfWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfWallet)];
    UITapGestureRecognizer * tapGestureOfOther1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfOther)];
    UITapGestureRecognizer * tapGestureOfOther2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfOther)];
    [_buttons[0] addGestureRecognizer:tapGestureOfGrades];
    [_buttons[1] addGestureRecognizer:tapGestureOfWallet];
    [_buttons[2] addGestureRecognizer:tapGestureOfOther1];
    [_buttons[3] addGestureRecognizer:tapGestureOfOther2];
}

#pragma mark - 主页4个按钮事件
-(void)buttonTapOfGrades{
    NSString * cardNumber = [_userDefaults objectForKey:@"cardNumber"];
    if (cardNumber.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先绑定校园卡..."];
        return;
    }
    SWUScoreViewController * scoreVc = [[SWUScoreViewController alloc] init];
    [self.navigationController pushViewController:scoreVc animated:YES];
}

-(void)buttonTapOfWallet{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NULL message:@"暂未开通" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancelAction];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

-(void)buttonTapOfOther{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NULL message:@"暂未开通" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancelAction];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - schedule
-(void)setScheduleHead{
    _scheduleHeadLabel = [[UILabel alloc]init];
    _scheduleHeadLabel.text = @"今日课表";
    _scheduleHeadLabel.textColor = [UIColor blackColor];
    _scheduleHeadLabel.font = [UIFont boldSystemFontOfSize:16];
    _scheduleHeadLabel.numberOfLines = 0;
    [self.view addSubview:_scheduleHeadLabel];
    [_scheduleHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        SWUMainButton* button = self.buttons[0];
        make.top.mas_equalTo(button.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(16);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
}

-(void)setSchedule{
    [self setScheduleHead];
    [self.view layoutIfNeeded];
    _schedule = [SWUHomeSchedule homeScheduleWithFrame:CGRectMake(0, CGRectGetMaxY(_scheduleHeadLabel.frame)+_schedule.frame.size.height+13, SCREEN_WIDTH, SCREEN_HEIGHT/10.0)];
    //计算当前日期
    NSDateComponents* date = [NSDate getDateComponents];
    //当前周数
    NSInteger currentWeek = ceil([NSDate distanceFromOneDayToNow:@"2019-02-25 00:00:00"]/7.0);
    //取出存放这周课表的NSArray对象
    Data * dataModel = self.dataArray[currentWeek-1];
    NSArray * classOfWeek = dataModel.weekitem;
    //取出今天的课表，存入数组arr
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
    NSArray* trans=@[@7,@1,@2,@3,@4,@5,@6];
    for(Weekitem * weekItemModel in classOfWeek){
        if (weekItemModel.day.intValue == [trans[date.weekday-1] integerValue]) {
            [arr addObject:weekItemModel];
        }
    }
    //调用函数，传入arr，生成schedule今日课表
    [_schedule setSubviews:arr];
    [self.view addSubview:_schedule];
}

#pragma mark - news
-(void)setNewsHead{
    _newsHeadLabel = [[UILabel alloc]init];
    _newsHeadLabel.text = @"失物招领";
    _newsHeadLabel.textColor = [UIColor blackColor];
    _newsHeadLabel.font = [UIFont boldSystemFontOfSize:16];
    _newsHeadLabel.numberOfLines = 0;
    [self.view addSubview:_newsHeadLabel];
    [_newsHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schedule.mas_bottom).offset(19);
        make.left.mas_equalTo(self.scheduleHeadLabel.mas_left);
        make.right.mas_equalTo(self.scheduleHeadLabel.mas_right);
        make.height.mas_equalTo(15);
    }];
    //添加展开按钮
    UIButton* moreNews = [[UIButton alloc]init];
    [moreNews setTitle:@"展开" forState:0];
    moreNews.titleLabel.font = [UIFont systemFontOfSize:16];
    moreNews.titleLabel.numberOfLines = 0;
    [moreNews setTitleColor:[UIColor colorWithRed:0/255.0 green:124/255.0 blue:247/255.0 alpha:1] forState:0];
    [moreNews addTarget:self action:@selector(moreNewsTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:moreNews];
    [moreNews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schedule.mas_bottom).offset(19);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(self.newsHeadLabel.mas_height);
        make.width.mas_equalTo(35);
    }];
}

//展开按钮事件
-(void)moreNewsTouchDown{
    UITableViewController* moreNews = [[UITableViewController alloc]init];
    moreNews.title = @"失物招领";
   [self.navigationController pushViewController:moreNews animated:YES];
}



-(void)setNews{
    [self setNewsHead];
    [self setNewsHead];
    _news=[[UITableView alloc]init];
    _news.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_news];
    [_news mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newsHeadLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - UISrollerViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.banner stopTimer];
}

- (void)scrollViewDidEndDragging:(SWUHomeBanner *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate)
        [self.banner startTimer];
}

-(void)scrollViewDidEndDecelerating:(SWUHomeBanner *)scrollView{
    [self.banner startTimer];
}


@end

