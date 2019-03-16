//
//  SWUHomeSchedule.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import "SWUHomeSchedule.h"
#import "SWUHomeScheduleSubview.h"
#import "Weekitem.h"

@interface SWUHomeSchedule ()
@end

@implementation SWUHomeSchedule
+(instancetype)homeScheduleWithFrame:(CGRect)frame{
    SWUHomeSchedule *homeSchedule = [[SWUHomeSchedule alloc]initWithFrame:frame];
    homeSchedule.showsVerticalScrollIndicator = NO;
    homeSchedule.showsHorizontalScrollIndicator = NO;
    return homeSchedule;
}

-(void)initSubviews:(NSMutableArray*)subviews{
    self.contentSize = CGSizeMake(subviews.count*(self.frame.size.height*140.0/65.0+15)+15, 0);
    for(int i = 0;i<subviews.count;i++){
        Weekitem *temp = subviews[i];
        SWUHomeScheduleSubview *sub = 
        [SWUHomeScheduleSubview scheduleSubviewWithFrame:CGRectMake(i*(15+self.frame.size.height*140.0/65.0)+15,0,   self.frame.size.height*140.0/65.0,self.frame.size.height)
                                        Title:temp.lessonName
                                      Content:[NSString stringWithFormat:@"第%@-%@节 | %@",temp.startTime,temp.endTime,temp.classRoom] number:i];
        [self addSubview:sub];
    }
}


@end
