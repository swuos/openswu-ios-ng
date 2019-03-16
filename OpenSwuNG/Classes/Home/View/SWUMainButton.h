//
//  SWUMainButton.h
//  OpenSwuNG
//
//  Created by 501 on 2019/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUMainButton : UIView

+(instancetype)mainButtonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                          Title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
