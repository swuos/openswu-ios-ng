////
////  SWUHomeView.m
////  OpenSwuNG
////
////  Created by 501 on 2019/2/23.
////
//
//
//#import <Foundation/Foundation.h>
//#import "SWUMainButton.h"
//#import "SWUHomeView.h"
//#import "Constants.h"
//#import "Masonry.h"
//#import "SWUHomeSchedule.h"
//#import "SWUHomeScheduleSubview.h"
//#import "SWUHomeBanner.h"
//@interface SWUHomeView ()
//@property(nonatomic,strong)UILabel* head;
//@property(nonatomic,strong)UILabel* scheduleHead;
//@property(nonatomic,strong)SWUHomeSchedule *schedule;
//@property(nonatomic,strong)UILabel* newsHead;
//@property(nonatomic,strong)UITableView *news;
//@end
//
//@implementation SWUHomeView
//-(instancetype)initWithFrame:(CGRect)frame{
//    if(self=[super initWithFrame:frame]){
//        self.backgroundColor=[UIColor whiteColor];
//        self.frame=frame;
////        [self setBanner];
////        [self setButtons];
////        [self setSchedule];
////        [self setNews];
//    }
//    return self;
//}
//
////#pragma mark - head
////-(void)setHead{
////
////
////    self.head=[[UILabel alloc]init];
////    self.head.text=@"西大助手";
////    self.head.font=[UIFont boldSystemFontOfSize:16];
////    self.head.numberOfLines = 0;
////    [self addSubview:self.head];
////    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.height.mas_equalTo(15);
////        make.width.mas_equalTo(100);
////        make.top.mas_equalTo(self.mas_safeAreaLayoutGuideTop).offset(15.5);
////        make.left.mas_equalTo(self.mas_safeAreaLayoutGuideLeft).offset(16);
////    }];
////}
//
//#pragma mark - Banner
////-(void)setBanner{
//////    [self layoutIfNeeded];
//////    _banner=[SWUHomeBanner bannerWithFrame:CGRectMake(15, CGRectGetMaxY(_head.frame)+14, SCREEN_WIDTH-15.0*2, (SCREEN_WIDTH-15.0*2)*160.0/345.0) ];
////    [self addSubview:_banner];
////}
//
////-(void)setBannerDelegate:(UIViewController <UIScrollViewDelegate>*)controller{
////    _banner.delegate=controller;
////}
////
////-(void)stopBannerTimer{
////    [_banner stopTimer];
////}
////
////-(void)startBannerTimer{
////    [_banner startTimer];
////}
//
//#pragma mark - buttons
//-(void)setButtons{
//   
//}
//
//
//#pragma mark - news
////-(void)setNews{
////    [self setNewsHead];
////    _news=[[UITableView alloc]init];
////    _news.backgroundColor=[UIColor redColor];
////    [self addSubview:_news];
////    [_news mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.newsHead.mas_bottom).offset(5);
////        make.left.mas_equalTo(self.newsHead.mas_left);
////        make.right.mas_equalTo(self).offset(-16);
////        make.bottom.mas_equalTo(self);
////    }];
////}
//
////-(void)setNewsHead{
////    _newsHead=[[UILabel alloc]init];
////    _newsHead.text=@"失物招领";
////    _newsHead.textColor=[UIColor blackColor];
////    _newsHead.font=[UIFont boldSystemFontOfSize:16];
////    _newsHead.numberOfLines=0;
////    [self addSubview:_newsHead];
////    [_newsHead mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.schedule.mas_bottom).offset(19);
////        make.left.mas_equalTo(self.head.mas_left);
////        make.right.mas_equalTo(self.head.mas_right);
////        make.height.mas_equalTo(15);
////    }];
////}
//
//#pragma mark- schedule
//-(void)setSchedule{
////    [self setScheduleHead];
//    [self layoutIfNeeded];
//    _schedule=[SWUHomeSchedule homeScheduleWithFrame:CGRectMake(0, CGRectGetMaxY(_scheduleHead.frame)+_schedule.frame.size.height+13, SCREEN_WIDTH, SCREEN_HEIGHT/10.0)];
//    SWUHomeScheduleSubview *sub=[SWUHomeScheduleSubview initWithFrame:CGRectMake(15, 0, _schedule.frame.size.height*140.0/65.0, _schedule.frame.size.height) Title:@"会计学" Content:@"第1-2节 | 3教 507"];
//    NSMutableArray* temp=[NSMutableArray arrayWithObject:sub];
//    [_schedule setSubviews:temp];
//    [self addSubview:self.schedule];
//}
//
////-(void)setScheduleHead{
////    _scheduleHead=[[UILabel alloc]init];
////    _scheduleHead.text=@"今日课表";
////    _scheduleHead.textColor=[UIColor blackColor];
////    _scheduleHead.font=[UIFont boldSystemFontOfSize:16];
////    _scheduleHead.numberOfLines=0;
////    [self addSubview:_scheduleHead];
////    [_scheduleHead mas_makeConstraints:^(MASConstraintMaker *make) {
////        UIButton* button=self.buttons[0];
////        make.top.mas_equalTo(button.mas_bottom).offset(33);
////        make.left.mas_equalTo(self.head.mas_left);
////        make.right.mas_equalTo(self.head.mas_right);
////        make.height.mas_equalTo(15);
////    }];
////}
//
//#pragma mark - NSTimer
////-(void)startTimer{
////    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
////    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
////}
////
////-(void)stopTimer{
////    [self.timer invalidate];
////}
////
////-(void)nextPage{
////    if(_page==2){
////        [self toPage:0];
////    }
////    else
////        [self toPage:_page+1];
////}
////
////-(void)toPage:(NSInteger)page{
////    _page=page;
////    [_banner setContentOffset:CGPointMake(_bannerWidth*page, 0) animated:YES];
////}
//
//@end
