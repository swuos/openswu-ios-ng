//
//  SWUHomeBanner.h
//  OpenSwuNG
//
//  Created by 501 on 2019/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUHomeBanner : UIScrollView
+(instancetype)bannerWithFrame:(CGRect)frame;
-(void)startTimer;
-(void)stopTimer;
@end

NS_ASSUME_NONNULL_END
