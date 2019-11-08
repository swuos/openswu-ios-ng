//
//  SWUBookCaseHeaderView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^changeVC)(NSString* name);
@interface SWUBookCaseHeaderView : UIView
@property (nonatomic,copy) changeVC changeVcBlock;
@end

NS_ASSUME_NONNULL_END
