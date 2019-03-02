//
//  UIButton+Login.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Login)
+(UIButton *)ButtonWithTitle:(NSString *)title
                       Frame:(CGRect )frame
                   Alignment:(UIControlContentHorizontalAlignment)alignment
                  titleColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
