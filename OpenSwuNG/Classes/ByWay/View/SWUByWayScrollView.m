//
//  SWUByWayScrollView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/18.
//

#import "SWUByWayScrollView.h"
#import "SWUByWayPlanCell.h"
#import "SWUByWayModel.h"


@implementation SWUByWayScrollView

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray{
    if (self = [super initWithFrame:frame]) {
        [self setUI:dataArray];
    }
    return self;
}

-(void)setUI:(NSArray *)dataArray{
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat lastY = 0;
    for (int i = 0; i < dataArray.count; i++) {
        SWUByWayModel *model = dataArray[i];
        model.count = [NSString stringWithFormat:@"%d",i+1];
        SWUByWayPlanCell *cell = [[SWUByWayPlanCell alloc] initWithFrame:CGRectMake(20, lastY + 10, self.frame.size.width-20, 200) model:model];
        cell.frame =CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, [cell getSize]);
        lastY = CGRectGetMaxY(cell.frame)+10;
        cell.tag = 10+i;
        [self addSubview:cell];
        if (i < dataArray.count - 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, lastY+4, cell.frame.size.width-30, 1)];
            lineView.alpha = 0.8;
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    
    SWUByWayPlanCell *cell = [self viewWithTag:10+dataArray.count-1];
//    NSLog(@"----%lf",CGRectGetMaxY(cell.frame));
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(cell.frame));
}
-(void)layoutIfNeeded{

}

//-(void)layoutSubviews {
//
//}




@end
