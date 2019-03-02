//
//  SWUTextField.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUTextField : UITextField

+(SWUTextField *)SWUTextFieldWithFrame:(CGRect)frame
                              LeftView:(UIView *)leftView
                                  Text:(NSString *)text
                          KeyBoardType:(UIKeyboardType)type;

-(void)setLineViewLength:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
