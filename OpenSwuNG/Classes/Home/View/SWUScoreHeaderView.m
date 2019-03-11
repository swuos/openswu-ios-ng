//
//  SWUScoreHeaderView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import "SWUScoreHeaderView.h"
#import "SWULabel.h"

@implementation SWUScoreHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI:frame];
    }
    return self;
}
-(void)setUpUI:(CGRect)frame {
//    分割成四部分
//    4 2 2 2
    self.backgroundColor = [UIColor lightGrayColor];
    CGFloat singleWidth = frame.size.width / 10.0;
    CGFloat headY = 5;
    
    SWULabel * subjectLabel = [[SWULabel alloc] initWithFrame:CGRectMake(0, headY, singleWidth*4, frame.size.height)];
    subjectLabel.font = [UIFont systemFontOfSize:14];
    subjectLabel.text = @"科目名称";
    [self addSubview:subjectLabel];
    
    SWULabel * gradeLabel = [[SWULabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(subjectLabel.frame), headY, singleWidth*2, frame.size.height)];
    gradeLabel.text = @"成绩";
    gradeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:gradeLabel];
    
    SWULabel * gradePointLabel = [[SWULabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gradeLabel.frame), headY, singleWidth*2, frame.size.height)];
    gradePointLabel.text = @"学分";
    gradePointLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:gradePointLabel];
    
    SWULabel * creditLabel = [[SWULabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gradePointLabel.frame), headY, singleWidth*2, frame.size.height)];
    creditLabel.text = @"绩点";
    creditLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:creditLabel];
    
}

@end
