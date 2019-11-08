//
//  SWUScrollview.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUScrollview : UIScrollView

-(void)setData:(NSArray * )data currentWeek:(NSInteger)currentWeek;

@end

NS_ASSUME_NONNULL_END
