//
//  SWUPublishViewController.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^RefreshDataBlock)(void);
@interface SWUPublishViewController : UIViewController
@property (nonatomic,copy) RefreshDataBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
