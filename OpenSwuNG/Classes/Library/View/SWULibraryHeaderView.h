//
//  SWULibraryHeaderView.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^changeVC)(void);
@interface SWULibraryHeaderView : UIView
@property (nonatomic,copy) changeVC changeVcBlock;
@end

NS_ASSUME_NONNULL_END
