//
//  NSDate+PickerView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import "NSDate+PickerView.h"
#import "NSDate+DistanceOfTimes.h"

@implementation NSDate (PickerView)

+(NSArray *)getPickerViewDataArray {
    NSDateComponents * comp = [NSDate getDateComponents];
    NSMutableArray * dateArr = [NSMutableArray array];
//    for (int i = 2005; i <= comp.year; i++) {
//        [dateArr addObject:[NSString stringWithFormat:@"%d学年",i]];
//    }
    for (NSInteger i = comp.year; i >= 2005 ; i--) {
        [dateArr addObject:[NSString stringWithFormat:@"%ld学年",i]];
    }
    NSArray * dataArray = [NSArray arrayWithObjects:dateArr,@[@"第1学期",@"第2学期",@"第3学期"], nil];
    return dataArray;
}


@end
