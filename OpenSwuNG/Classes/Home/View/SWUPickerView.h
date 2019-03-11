//
//  SWUPickerView.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SWUPickerViewDelegate <NSObject>
-(void)SWUPickerViewDidSelected:(NSMutableDictionary *)paraDic;
@end

@interface SWUPickerView : UIView
/** 代理  */
@property (nonatomic,strong) id<SWUPickerViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
