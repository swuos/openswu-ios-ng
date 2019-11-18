//
//  SWULibraryPlaceHoldCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import "SWULibraryPlaceHoldCell.h"

@implementation SWULibraryPlaceHoldCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        UILabel *tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
        tipLable.text = @"暂无数据";
        tipLable.textAlignment = NSTextAlignmentCenter;
//        tipLable.backgroundColor = [UIColor lightGrayColor];
        tipLable.alpha = 0.5;
//        tipLable.center = self.center;
        [self addSubview:tipLable];
    }
    return self;
}



@end
