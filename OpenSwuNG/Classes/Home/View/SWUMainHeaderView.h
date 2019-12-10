//
//  SWUMainHeaderView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^pushViewController) (UIViewController *vc);
typedef void(^alertViewController) (UIViewController *vc);
typedef void(^changeVC)(NSString* name);

@interface SWUMainHeaderView : UIView
@property (nonatomic,copy) pushViewController pushVcBlock;
@property (nonatomic,copy) alertViewController alertVcBlock;
@property (nonatomic,copy) changeVC changeVcBlock;

-(void)reSetUpSchedule;
-(void)hideLoadImage;
@end

NS_ASSUME_NONNULL_END
