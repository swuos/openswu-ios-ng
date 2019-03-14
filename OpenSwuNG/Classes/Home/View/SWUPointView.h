//
//  SWUPointView.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUPointView : UIView
+(SWUPointView *)swuPointViewWithFrame:(CGRect)frame
                             DataArray:(NSArray *)dataArray
                               ParaDic:(NSMutableDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
