//
//  SWUAlertViewController.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import <UIKit/UIKit.h>
@class SWULabel;

NS_ASSUME_NONNULL_BEGIN

@interface SWUAlertViewController : UIAlertController

//+(instancetype)alertControllerWithSWULabel:(SWULabel *)swulabel Gesture:(UIGestureRecognizer *)gesture;
+(instancetype)alertControllerWithSWULabel:(SWULabel *)swulabel;
@end

NS_ASSUME_NONNULL_END
