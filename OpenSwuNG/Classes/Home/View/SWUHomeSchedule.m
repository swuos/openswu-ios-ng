//
//  SWUHomeSchedule.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import "SWUHomeSchedule.h"
#import "SWUHomeScheduleSubview.h"
@interface SWUHomeSchedule ()
@property(nonatomic,strong) NSMutableArray* subviews;
@end

@implementation SWUHomeSchedule
+(SWUHomeSchedule*)homeScheduleWithFrame:(CGRect)frame
{
    SWUHomeSchedule* homeSchedule=[[SWUHomeSchedule alloc]initWithFrame:frame];
    homeSchedule.showsVerticalScrollIndicator=NO;
    homeSchedule.showsHorizontalScrollIndicator=NO;
    return homeSchedule;
}

-(void)setSubviews:(NSMutableArray*)subviews{
    self.contentSize=CGSizeMake(1000, 0);
    for(SWUHomeScheduleSubview* temp in subviews){
        [self addSubview:temp];
    }
}


@end
