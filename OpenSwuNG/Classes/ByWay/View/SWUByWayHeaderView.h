//
//  SWUByWayHeaderView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/17.
//

#import <UIKit/UIKit.h>

@class  SWUByWayPickerView;
NS_ASSUME_NONNULL_BEGIN
typedef void(^SearchBtnClickedBlock)(NSString *start,NSString *end,CGFloat positionY);
//typedef void(^SelectStationBlock)(SWUByWayPickerView *picker);
typedef void(^SelectStationBlock)(UIView *picker);
@interface SWUByWayHeaderView : UIView
@property (nonatomic,copy) SearchBtnClickedBlock searchBtnBlock;
@property (nonatomic,copy) SelectStationBlock selectStationBlock;
@end

NS_ASSUME_NONNULL_END
