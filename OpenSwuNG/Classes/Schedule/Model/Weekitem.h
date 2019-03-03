//
//  Weekitem.h
//  课程表scrollerview
//
//  Created by 张俊 on 2019/2/26.
//  Copyright © 2019年 zhangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weekitem : NSObject
/** campus  */
@property (nonatomic,copy) NSString * campus;
/** classRoom  */
@property (nonatomic,copy) NSString * classRoom;
/** day  */
@property (nonatomic,copy) NSString * day;
/** endTime  */
@property (nonatomic,copy) NSString * endTime;
/** startTime  */
@property (nonatomic,copy) NSString * startTime;
/** teacher  */
@property (nonatomic,copy) NSString * teacher;
/** lessonName  */
@property (nonatomic,copy) NSString * lessonName;
/** week  */
@property (nonatomic,copy) NSString * week;
/** ScrollerViewcount  */
@property (nonatomic,assign) NSInteger  scrollerViewCount;
/** campus  */
//@property (nonatomic,strong) NSString * campus;
///** classRoom  */
//@property (nonatomic,strong) NSString * classRoom;
///** day  */
//@property (nonatomic,strong) NSString * day;
///** endTime  */
//@property (nonatomic,strong) NSString * endTime;
///** startTime  */
//@property (nonatomic,strong) NSString * startTime;
///** teacher  */
//@property (nonatomic,strong) NSString * teacher;
///** lessonName  */
//@property (nonatomic,strong) NSString * lessonName;
///** week  */
//@property (nonatomic,strong) NSString * week;
@end

NS_ASSUME_NONNULL_END
