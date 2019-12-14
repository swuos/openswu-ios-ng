//
//  SWUMinePublisViewController.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AfterDeleteRefreshDataBlock)(id model);

@interface SWUMinePublisViewController : UIViewController
@property (nonatomic,copy) AfterDeleteRefreshDataBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
