//
//  SWUHomeScheduleSubview.h
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUHomeScheduleSubview : UIImageView
+(SWUHomeScheduleSubview*)initWithFrame:(CGRect)frame
                                  Title:(NSString*)titleText
                                Content:(NSString*)contenText
                                 number:(NSInteger)number;
@end

NS_ASSUME_NONNULL_END
