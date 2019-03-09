//
//  SWUWeekSelectView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUWeekSelectView.h"
#import "Constants.h"
#import "SWULabel.h"

@interface SWUWeekSelectView ()
/** 选中的button  */
@property (nonatomic,strong) SWULabel * selectBtn;
@end

@implementation SWUWeekSelectView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        self.showsHorizontalScrollIndicator = NO;
        [self addSelectWeekButton];
    }
    return self;
}

-(void)addSelectWeekButton {
    self.contentSize = CGSizeMake(WEEK_COUNTS*WEEK_SCROLLERVIEW_HEIGHT, WEEK_SCROLLERVIEW_HEIGHT);
    for (int i = 0; i < WEEK_COUNTS; i++) {
        SWULabel * weekBtn = [[SWULabel alloc] initWithFrame:CGRectMake(i*WEEK_SCROLLERVIEW_HEIGHT+WEEK_SCROLLERVIEW_HEIGHT*0.2, WEEK_SCROLLERVIEW_HEIGHT*0.1, WEEK_SCROLLERVIEW_HEIGHT*0.8, WEEK_SCROLLERVIEW_HEIGHT*0.8)];
        weekBtn.layer.cornerRadius =  weekBtn.frame.size.width*0.5;
        weekBtn.backgroundColor = UNSELECT_COLOR;
        weekBtn.tag = i+1;
        weekBtn.userInteractionEnabled = YES;
        weekBtn.text = [NSString stringWithFormat:@"%d",i+1];
        [self addSubview:weekBtn];
    }
}


@end
