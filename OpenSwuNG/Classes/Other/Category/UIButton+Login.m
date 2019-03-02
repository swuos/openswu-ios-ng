//
//  UIButton+Login.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/28.
//

#import "UIButton+Login.h"

@implementation UIButton (Login)
+(UIButton *)ButtonWithTitle:(NSString *)title
                       Frame:(CGRect )frame
                   Alignment:(UIControlContentHorizontalAlignment)alignment
                  titleColor:(UIColor *)color{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn.imageView removeFromSuperview];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.frame = frame;
    btn.layer.cornerRadius = 3;
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.contentHorizontalAlignment = alignment;
    return btn;
}
@end
