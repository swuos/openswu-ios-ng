//
//  SWUMainButton.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/3.
//

#import "SWUMainButton.h"

@implementation SWUMainButton
+(instancetype)mainButtonWithFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                          Title:(NSString *)title {
    SWUMainButton *mainBtn = [[SWUMainButton alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0, 0, mainBtn.frame.size.width, mainBtn.frame.size.width);
    [mainBtn addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), mainBtn.frame.size.width, mainBtn.frame.size.height - mainBtn.frame.size.width)];
    label.text = title;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [mainBtn addSubview:label];
    return mainBtn;
}

@end
