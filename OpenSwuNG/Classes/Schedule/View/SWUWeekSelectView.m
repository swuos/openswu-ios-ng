//
//  SWUWeekSelectView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUWeekSelectView.h"
#import "Constants.h"

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
    self.contentSize = CGSizeMake(WeekCounts*weekScrollerViewH, weekScrollerViewH);
    for (int i = 0; i < WeekCounts; i++) {
        SWULabel * weekBtn = [[SWULabel alloc] initWithFrame:CGRectMake(i*weekScrollerViewH, 0, weekScrollerViewH, weekScrollerViewH)];
        weekBtn.layer.cornerRadius =  weekScrollerViewH*0.5;
        weekBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        weekBtn.tag = i+1;
        weekBtn.userInteractionEnabled = YES;
        weekBtn.text = [NSString stringWithFormat:@"%d",i+1];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnBackGroundSelected:)];
//        [weekBtn addGestureRecognizer:tap];
        [self addSubview:weekBtn];
    }
}
//-(void)btnBackGroundSelected:(UITapGestureRecognizer *)sender {
//    if (_selectBtn) {
//        _selectBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//    }
//    self.selectBtn = (SWULabel *)sender.view;
//    sender.view.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
//
////    改变collectionview的cell
//    for (UIView * view in sender.view.superview.superview.subviews) {
//        if ([view isKindOfClass:[UICollectionView class]]) {
//            UICollectionView * collectionView = (UICollectionView *)view;
//            collectionView.contentOffset = CGPointMake(sender.view.tag*SCREEN_WIDTH, 0);
//            [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathWithIndex:sender.view.tag] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
////            NSLog(@"%@",view);
//        }
//    }
//}



@end
