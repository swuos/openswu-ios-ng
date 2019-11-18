//
//  SWUScrollerBackView.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUScrollerBackView : UIView
+(SWUScrollerBackView *)swuScrollerBackViewWithFrame:(CGRect)frame
                                           DataArray:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
