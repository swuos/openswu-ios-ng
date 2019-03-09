//
//  SWULabel.m
//  课程表scrollerview
//
//  Created by 张俊 on 2019/2/26.
//  Copyright © 2019年 zhangjun. All rights reserved.
//

#import "SWULabel.h"
#import "Weekitem.h"
#import "Constants.h"

@implementation SWULabel
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.numberOfLines = 0;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setWeekitem:(Weekitem *)weekitem {
    _weekitem = weekitem;
    self.text = [NSString stringWithFormat:@"%@ \n@%@",weekitem.lessonName,weekitem.classRoom];
    NSArray * colors = @[
                         SWUCOLOR(250, 192, 49),
                         SWUCOLOR(52, 170, 245),
                         SWUCOLOR(252, 144, 72),
                         SWUCOLOR(113, 156, 253),
                         SWUCOLOR(250, 192, 49),
                         SWUCOLOR(255, 186, 132),
                         SWUCOLOR(18, 224, 209),
                         SWUCOLOR(177, 180, 121),
                         SWUCOLOR(220, 159, 180),
                         SWUCOLOR(158, 122, 122),
                         SWUCOLOR(85, 66, 54),
                         SWUCOLOR(125, 83, 44),
                         SWUCOLOR(233, 139, 42),
                         SWUCOLOR(188, 159, 119),
                         SWUCOLOR(159, 53, 58),
                         SWUCOLOR(102, 186, 183)
                         ];
    self.backgroundColor = colors[weekitem.scrollerViewCount%colors.count];
    self.font = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width/6.0;
}


@end
