//
//  SWUNewsInfoController.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/8.
//

#import <UIKit/UIKit.h>
@class SWUNewsModel;
NS_ASSUME_NONNULL_BEGIN
typedef SWUNewsModel *_Nonnull(^showNewsInfoBlock) (void);
@interface SWUNewsInfoController : UIViewController

@property (nonatomic,copy) showNewsInfoBlock newInfoBlock;
@end

NS_ASSUME_NONNULL_END
