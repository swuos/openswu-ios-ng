//
//  NSDate+DistanceOfTimes.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DistanceOfTimes)
+(int)distanceFromOneDayToNow:(NSString * )dateString;
+(NSDateComponents *)getDateComponents;
//获取课程表
+(void)getSchedule;
@end

NS_ASSUME_NONNULL_END
