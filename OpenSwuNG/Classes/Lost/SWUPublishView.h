//
//  SWUPublishView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PublishBtnDidClickedBlock) (void);

@interface SWUPublishView : UIView
@property (nonatomic,strong) UITextView *inputInfoTextView;
@property (nonatomic,strong) UILabel *stringLenghLabel;
@property (nonatomic,copy) PublishBtnDidClickedBlock publishBlock;
@end

NS_ASSUME_NONNULL_END
