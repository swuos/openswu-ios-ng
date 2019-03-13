//
//  NSDate+DistanceOfTimes.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import "NSDate+DistanceOfTimes.h"
#import "SWUAFN.h"
#import "SWUScheduleModel.h"
#import "MJExtension.h"
#import "Constants.h"

@implementation NSDate (DistanceOfTimes)


+(int)distanceFromOneDayToNow:(NSString * )dateString {
    NSDate * nowDate = [NSDate date];
    
    NSDate * stringDate = [NSDate StringTODate:dateString];
    NSTimeInterval time = [nowDate timeIntervalSinceDate:stringDate];
    int days = ((int)time)/(3600*24);
    return days+1;
}

//字符串转日期
+(NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}

+(NSDateComponents *)getDateComponents {
    //    获取当前时间
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * date = [NSDate date];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitWeekday | NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond |
    NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal;
    return [calendar components:unitFlags fromDate:date];
}


+(void)getSchedule {
    NSDateComponents * comp = [NSDate getDateComponents];
    AFHTTPSessionManager * manager = [SWUAFN swuAfnManage];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [manager.requestSerializer setValue:[userDefaults objectForKey:@"acToken"] forHTTPHeaderField:@"acToken"];
    
    NSDictionary * paraDic = @{
                               @"swuid":[userDefaults objectForKey:@"cardNumber"],
                               @"academicYear":[NSString stringWithFormat:@"%ld",(comp.year-1)],
                               @"term":[NSString stringWithFormat:@"%d",(comp.month >= 2 && comp.month < 9 ? 2:1)]
                               };
    [manager GET:@"https://freegatty.swuosa.xenoeye.org/api/schedule/search" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        进行数据解析
        SWUScheduleModel * scheduleModel = [SWUScheduleModel mj_objectWithKeyValues:responseObject];
        //        如果不存在那么重新写入
        [scheduleModel.result[@"data"] writeToFile:CACHE_PATH(@"schedule.plist") atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end
