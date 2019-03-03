//
//  SWULoginLabel.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/2.
//

#import "SWULoginLabel.h"
#import "Constants.h"

@implementation SWULoginLabel
+(SWULoginLabel *)SWULoginLabelwithText:(NSString *)text {
    SWULoginLabel * label = [[SWULoginLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.2, WEEK_SCROLLERVIEW_HEIGHT)];
    label.textAlignment = NSTextAlignmentRight;
    label.text = text;
    return label;
}

@end
