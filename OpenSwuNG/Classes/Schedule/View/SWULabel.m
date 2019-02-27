//
//  SWULabel.m
//  课程表scrollerview
//
//  Created by 张俊 on 2019/2/26.
//  Copyright © 2019年 zhangjun. All rights reserved.
//

#import "SWULabel.h"
#import "Weekitem.h"

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
    self.text = [NSString stringWithFormat:@"%@\n%@ \n@%@",weekitem.lessonName,weekitem.teacher,weekitem.classRoom];
    NSArray * colors = @[
                         [UIColor colorWithRed:250/255.0 green:192/255.0 blue:49/255.0 alpha:1.0],
                         [UIColor colorWithRed:52/255.0 green:170/255.0 blue:245/255.0 alpha:1.0],
                         [UIColor colorWithRed:252/255.0 green:144/255.0 blue:72/255.0 alpha:1.0],
                         [UIColor colorWithRed:113/255.0 green:156/255.0 blue:253/255.0 alpha:1.0],
                         [UIColor colorWithRed:250/255.0 green:192/255.0 blue:49/255.0 alpha:1.0],
                         [UIColor colorWithRed:18/255.0 green:224/255.0 blue:209/255.0 alpha:1.0]
                         ];
    self.backgroundColor = colors[weekitem.scrollerViewCount%colors.count];
    self.font = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width/6.0;
}


@end
