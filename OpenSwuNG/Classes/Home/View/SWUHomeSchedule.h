//
//  SWUHomeSchedule.h
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SWUHomeSchedule : UIScrollView
+(SWUHomeSchedule*)homeScheduleWithFrame:(CGRect)frame;
-(void)setSubviews:(NSMutableArray*)subviews;
@end

NS_ASSUME_NONNULL_END
