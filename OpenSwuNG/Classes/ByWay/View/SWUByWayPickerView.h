//
//  SWUByWayPickerView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol SWUByWayPickerViewDelegate <NSObject>
//-(void)SWUByWayPickerViewDidSelected:(NSString *)start;
//@end
typedef void(^StationSelectFinishedBlock) (NSString *station);
@interface SWUByWayPickerView : UIView
/** 代理  */
//@property (nonatomic,weak) id<SWUByWayPickerViewDelegate> delegate;
@property (nonatomic,copy) StationSelectFinishedBlock block;
@end

NS_ASSUME_NONNULL_END
