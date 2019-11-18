//
//  SWUHomeSchedule.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import "SWUHomeSchedule.h"
#import "SWUHomeScheduleSubview.h"
#import "Weekitem.h"
#import "Constants.h"

@interface SWUHomeSchedule ()
@property (nonatomic,strong) NSDictionary * datedic;
@end

@implementation SWUHomeSchedule
-(NSDictionary *)datedic{
    if (!_datedic) {
        _datedic = @{
                     @"星期一":@"1",
                     @"星期二":@"2",
                     @"星期三":@"3",
                     @"星期四":@"4",
                     @"星期五":@"5",
                     @"星期六":@"6",
                     @"星期日":@"7"
                     };
    }
    return _datedic;
}
+(instancetype)homeScheduleWithFrame:(CGRect)frame{
    SWUHomeSchedule *homeSchedule = [[SWUHomeSchedule alloc]initWithFrame:frame];
    homeSchedule.showsVerticalScrollIndicator = NO;
    homeSchedule.showsHorizontalScrollIndicator = NO;
    return homeSchedule;
}

-(void)loadSubviews:(NSInteger)currentWeek dataArr:(NSArray *)data date:(NSDateComponents *)date{
    UILabel *tipLable;
    Weekitem * weekitem = [[Weekitem alloc] init];
    NSArray *trans = @[@7,@1,@2,@3,@4,@5,@6];
    NSString * day = [NSString string];
    NSMutableArray *todayData = [NSMutableArray array];
    for (int i = 0;i < data.count;i++) {
        weekitem = data[i];
        NSArray * arr = [weekitem.weekTime componentsSeparatedByString:@","];
        if (![arr containsObject:[NSString stringWithFormat:@"%ld",currentWeek]]) {
            continue;
        }
        
        day = self.datedic[weekitem.week];
        if (day.intValue != [trans[date.weekday-1] integerValue]) {
            continue;
        }
        [todayData addObject:weekitem];
    }

//    按照开始的节数进行排序
    [todayData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Weekitem *w1 = (Weekitem *)obj1;
        Weekitem *w2 = (Weekitem *)obj2;
        return w1.startTime.integerValue > w2.startTime.integerValue;
    }];
    
//    今日没课
    if (todayData.count <= 0) {
        tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-15)];
        tipLable.text = @"～～～今日无课，放松下吧～～～";
        tipLable.textAlignment = NSTextAlignmentCenter;
        tipLable.alpha = 0.5;
        tipLable.textColor = [UIColor grayColor];
        self.contentSize = tipLable.frame.size;
        [self addSubview:tipLable];
        return;
    }
    if (tipLable.superview == self) {
        [tipLable removeFromSuperview];
    }
    self.contentSize = CGSizeMake(todayData.count*(self.frame.size.height*140.0/65.0+15)+15, 0);
    for(int i = 0;i<todayData.count;i++){
        Weekitem *temp = todayData[i];
        SWUHomeScheduleSubview *sub = [SWUHomeScheduleSubview scheduleSubviewWithFrame:CGRectMake(i*(15+self.frame.size.height*140.0/65.0)+15,0,   self.frame.size.height*140.0/65.0,self.frame.size.height) Title:temp.lessonName Content:[NSString stringWithFormat:@"第%@-%@节 | %@",temp.startTime,temp.endTime,temp.classRoom] number:i];
        [self addSubview:sub];
    }
}


@end
