//
//  SWUNavTitleView.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWULabel;

@interface SWUNavTitleView : UIView
/** 设置标题  */
@property (nonatomic,strong) SWULabel * titleLabel;
/** 向下的图片  */
@property (nonatomic,strong) UIImageView * weekDeirView;

@end

NS_ASSUME_NONNULL_END
