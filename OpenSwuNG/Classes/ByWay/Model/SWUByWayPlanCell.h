//
//  SWUByWayPlanCell.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/18.
//

#import <UIKit/UIKit.h>

@class SWUByWayModel;
NS_ASSUME_NONNULL_BEGIN
//typedef void(^SizeToFitFrameBlock) (CGFloat height);
@interface SWUByWayPlanCell : UIView
//@property (nonatomic,copy) SizeToFitFrameBlock block;
-(CGFloat)getSize;
-(instancetype)initWithFrame:(CGRect)frame model:(SWUByWayModel *)model;
@end

NS_ASSUME_NONNULL_END
