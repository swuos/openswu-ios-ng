//
//  SWUMainHeaderView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import "SWUMainHeaderView.h"
#import "SWUHomeBanner.h"
#import "Constants.h"
#import "SWUMainButton.h"
#import "SWUScoreViewController.h"
#import "SWUHomeSchedule.h"
#import "SWUHomeScheduleSubview.h"
#import "Weekitem.h"
#import "MJExtension.h"
#import "SWUFactory.h"
#import "SVProgressHUD.h"
#import "SWULibraryViewController.h"
#import "Masonry.h"
#import "NSDate+DistanceOfTimes.h"
#import "SWUFactory.h"


@interface SWUMainHeaderView()<UIScrollViewDelegate>
/** banner */
@property(nonatomic,strong)SWUHomeBanner *banner;
/** 4个button的数组*/
@property(nonatomic,strong)NSMutableArray *buttons;
/** scheduleHead */
@property(nonatomic,strong)UILabel *scheduleHeadLabel;
/** schedule */
@property(nonatomic,strong)SWUHomeSchedule *schedule;
/** newsHead */
@property(nonatomic,strong)UILabel *newsHeadLabel;
/** userDefaults  */
@property(nonatomic,strong)NSUserDefaults *userDefaults;
/** 存储课程信息的dataArray  */
@property(nonatomic,copy)NSArray *dataArray;
@property (nonatomic,strong) UIButton *selectbtn;
@property (nonatomic,strong) UIView *scrollLineView;
@end

@implementation SWUMainHeaderView
-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [SWUFactory getScheduleData];
    }
    return _dataArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self setUpBanner];
    [self setUpButton];
    //    设置课表的显示
    [self setUpSchedule];
    [self setUpNewsHead];
    
}
#pragma mark - banner
-(void)setUpBanner{
    [self layoutIfNeeded];
    self.banner = [SWUHomeBanner bannerWithFrame:CGRectMake(15,5, SCREEN_WIDTH-15.0*2, (SCREEN_WIDTH-15.0*2)*160.0/345.0) ];
    [self.banner setCenter:CGPointMake(self.center.x, 5+self.banner.frame.size.height/2.0)];
    [self.banner setDelegate:self];
    [self addSubview:self.banner];
}
#pragma mark - buttons
-(void)setUpButton{
    self.buttons = [NSMutableArray arrayWithCapacity:4];
    //图片和标题
    NSArray *titles = @[@"成绩查询",@"我的钱包",@"水费查询",@"图书查询"];
    NSArray *images = @[@"main_grade",@"main_wallet",@"main_water",@"main_library"];
    CGFloat padding = 0;
    CGFloat cellWidth = 0;
    if([[UIDevice currentDevice].model isEqualToString:@"iPad"]){
        padding = (SCREEN_WIDTH*(4.2/25.0))/2.0;
        cellWidth = (SCREEN_WIDTH-8*padding)/4.0;
    }
    else{
        padding = (SCREEN_WIDTH*(3.0/25.0))/2.0;
        cellWidth = (SCREEN_WIDTH-8*padding)/4.0;
    }
    [self layoutIfNeeded];
    for(int i=0;i<4;i++){
        SWUMainButton *mainButton = [SWUMainButton mainButtonWithFrame:CGRectMake(padding+(cellWidth+2*padding)*i, CGRectGetMaxY(_banner.frame)+SCREEN_HEIGHT*(12.0/667.0), cellWidth, cellWidth+20)
                                                             imageName:images[i]
                                                                 Title:titles[i]];
        mainButton.userInteractionEnabled = YES;
        [self addSubview:mainButton];
        [self.buttons addObject:mainButton];
    }
    
    UITapGestureRecognizer *tapGestureOfGrades = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfGrades)];
    UITapGestureRecognizer *tapGestureOfWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfWallet)];
    UITapGestureRecognizer *tapGestureOfOther1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfWaterElectricFare)];
    UITapGestureRecognizer *tapGestureOfOther2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapOfLibrary)];
    [self.buttons[0] addGestureRecognizer:tapGestureOfGrades];
    [self.buttons[1] addGestureRecognizer:tapGestureOfWallet];
    [self.buttons[2] addGestureRecognizer:tapGestureOfOther1];
    [self.buttons[3] addGestureRecognizer:tapGestureOfOther2];
}

#pragma mark - 主页4个按钮事件
//查询成绩
-(void)buttonTapOfGrades{
    NSString *cardNumber = [self.userDefaults objectForKey:@"cardNumber"];
    if (cardNumber.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先绑定校园卡..."];
        return;
    }
    SWUScoreViewController *scoreVc = [[SWUScoreViewController alloc] init];
    self.pushVcBlock(scoreVc);
}
// 查询钱包
-(void)buttonTapOfWallet{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:@"暂未开通" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // 弹出对话框
    self.alertVcBlock(alert);
}
//
-(void)buttonTapOfWaterElectricFare{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:@"暂未开通" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    // 弹出对话框
    self.alertVcBlock(alert);
}
-(void)buttonTapOfLibrary{
    SWULibraryViewController * libraryVc = [[SWULibraryViewController alloc] init];
    self.pushVcBlock(libraryVc);
}

#pragma mark - schedule
-(void)setUpScheduleHead{
    self.scheduleHeadLabel = [[UILabel alloc]init];
    self.scheduleHeadLabel.text = @"今日课表";
    self.scheduleHeadLabel.textColor = [UIColor blackColor];
    self.scheduleHeadLabel.font = [UIFont boldSystemFontOfSize:16];
    self.scheduleHeadLabel.numberOfLines = 0;
    [self addSubview:_scheduleHeadLabel];
    [self.scheduleHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        SWUMainButton *button = self.buttons[0];
        make.top.mas_equalTo(button.mas_bottom).offset(SCREEN_HEIGHT*(20.0/667.0));
        make.left.mas_equalTo(self).offset(16);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
}

-(void)setUpSchedule{
    [self setUpScheduleHead];
    [self layoutIfNeeded];
    self.schedule = [SWUHomeSchedule homeScheduleWithFrame:CGRectMake(0, CGRectGetMaxY(_scheduleHeadLabel.frame)+_schedule.frame.size.height+13, SCREEN_WIDTH, SCREEN_HEIGHT/10.0)];
    if ([[self.userDefaults objectForKey:@"cardNumber"] length] != 0){
        [self loadScheduleSubviews];
    }
    [self addSubview:self.schedule];
}

-(void)loadScheduleSubviews{
    //计算当前日期
    NSDateComponents *date = [NSDate getDateComponents];
    //当前周数
    NSInteger currentWeek = ceil([NSDate distanceFromOneDayToNow:@"2019-09-01 00:00:00"]/7.0);
    [self.schedule loadSubviews:currentWeek dataArr:self.dataArray date:date];
}

#pragma mark - news
-(void)setUpNewsHead{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.schedule.frame), self.frame.size.width-30, 30)];
    backView.userInteractionEnabled = YES;
//    backView.backgroundColor = [UIColor orangeColor];
    [self addSubview:backView];
    
    CGFloat lineSperator = 1;
    CGFloat width = (self.frame.size.width - 2*lineSperator-30)/3.0;
    NSArray *nameArr = @[@"热点新闻",@"通知公告",@"学术看板"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [self creatBtnName:nameArr[i] frame:CGRectMake(i * (width+lineSperator), 0, width, backView.frame.size.height-2)];
        btn.tag = i+20;
        [backView addSubview:btn];
    }
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_schedule.mas_bottom).offset(2);
        make.left.right.equalTo(self->_banner);
        make.height.equalTo(@30);
    }];
    self.scrollLineView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 2, width - 20, 2)];
    CGFloat x = lineSperator + width/2.0;
    _scrollLineView.center = CGPointMake(x, _scrollLineView.center.y);
    _scrollLineView.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_scrollLineView];
    self.selectbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectbtn = [self viewWithTag:20];
    self.selectbtn.tintColor = [UIColor orangeColor];
}
-(UIButton *)creatBtnName:(NSString *)name frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.tintColor = [UIColor blackColor];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn.imageView removeFromSuperview];
    [btn addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)changeVc:(UIButton *)btn {
//    NSLog(@"%@  %@",btn,btn.titleLabel.text);
    [UIView animateWithDuration:0.3 animations:^{
        self->_selectbtn.tintColor = [UIColor blackColor];
        btn.tintColor = [UIColor orangeColor];
        self->_selectbtn = btn;
        self->_scrollLineView.center = CGPointMake(btn.center.x, self->_scrollLineView.center.y);
    }];
    self.changeVcBlock(btn.titleLabel.text);
}
//展开按钮事件
-(void)moreNewsTouchDown{
    UITableViewController *moreNews = [[UITableViewController alloc]init];
    moreNews.title = @"失物招领";
    self.pushVcBlock(moreNews);
}
#pragma mark - UISrollerViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.banner stopTimer];
}

- (void)scrollViewDidEndDragging:(SWUHomeBanner *)scrollView
                  willDecelerate:(BOOL)decelerate{
    if(!decelerate){
        [self.banner startTimer];
    }
}

-(void)scrollViewDidEndDecelerating:(SWUHomeBanner *)scrollView{
    [self.banner startTimer];
}

@end
