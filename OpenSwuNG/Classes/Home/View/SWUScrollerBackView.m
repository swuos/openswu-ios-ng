//
//  SWUScrollerBackView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import "SWUScrollerBackView.h"
#import "Constants.h"
#import "SWUScoreModel.h"
#import "Masonry.h"

@interface SWUScrollerBackView ()
/** 成绩显示的滚动视图  */
@property (nonatomic,strong) UIScrollView * gradeScorllerView;
/** 存储成绩的数组  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUScrollerBackView

+(SWUScrollerBackView *)swuScrollerBackViewWithFrame:(CGRect)frame
                                           DataArray:(NSArray *)dataArray {
    SWUScrollerBackView * scrollerBackView = [[SWUScrollerBackView alloc] initWithFrame:frame];
    scrollerBackView.dataArray = dataArray;
    [scrollerBackView setUpUI:frame];
    return scrollerBackView;
}

-(void)setUpUI:(CGRect)frame {
    UIView * gradeMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WEEK_SCROLLERVIEW_HEIGHT, frame.size.height)];
    [self addSubview:gradeMessageView];
    
    self.gradeScorllerView = [[UIScrollView alloc] initWithFrame:CGRectMake(WEEK_SCROLLERVIEW_HEIGHT,5, frame.size.width-WEEK_SCROLLERVIEW_HEIGHT, frame.size.height)];
    self.gradeScorllerView.contentSize = CGSizeMake(10+self.dataArray.count*50, self.gradeScorllerView.frame.size.height);
    self.gradeScorllerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [self addSubview:_gradeScorllerView];
    
    CGFloat realizeHeight = frame.size.height-40;
//    添加5条成绩标准提示线
    for (int i = 0; i < 6; i++) {
        UIView * gradeMessageLine = [[UIView alloc] initWithFrame:CGRectMake(0,15+realizeHeight*0.2*i, _gradeScorllerView.contentSize.width, 1)];
        gradeMessageLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [_gradeScorllerView addSubview:gradeMessageLine];
//        添加成绩显示
        UILabel * gradeMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12+realizeHeight*0.2*i, gradeMessageView.frame.size.width, 15)];
        gradeMessageLabel.text = [NSString stringWithFormat:@"%d",100-20*i];
        gradeMessageLabel.textColor = [UIColor lightGrayColor];
        gradeMessageLabel.font = [UIFont systemFontOfSize:12];
        gradeMessageLabel.textAlignment = NSTextAlignmentCenter;
        [gradeMessageView addSubview:gradeMessageLabel];
    }
    
//    添加成绩的相关视图
    for (int i = 0; i < self.dataArray.count; i++) {
        SWUScoreModel * scoreModel = self.dataArray[i];
//        成绩柱状图
        UIView * scoreView = [[UIView alloc] initWithFrame:CGRectMake(15+i*50,15+(100-scoreModel.score.intValue)/100.0*realizeHeight , 15, scoreModel.score.intValue/100.0*realizeHeight)];
        scoreView.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGradeView:)];
        [scoreView addGestureRecognizer:tap];
        scoreView.userInteractionEnabled = YES;
        [self.gradeScorllerView addSubview:scoreView];
        
//        成绩柱状图上的分数显示
        UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(scoreView.frame), CGRectGetMinY(scoreView.frame)-17, 15, 15)];
        scoreLabel.text = [NSString stringWithFormat:@"%@",scoreModel.score];
        scoreLabel.textColor = [UIColor colorWithRed:38/255.0 green:121/255.0 blue:246/255.0 alpha:1.0];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.font = [UIFont systemFontOfSize:10];
        [self.gradeScorllerView addSubview:scoreLabel];
//        如果是小于60分，则显示为红色
        if (scoreModel.score.intValue < 60) {
            scoreView.backgroundColor = [UIColor colorWithRed:230/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
            scoreLabel.textColor = [UIColor colorWithRed:231/255.0 green:47/255.0 blue:47/255.0 alpha:1.0];
        }
//        成绩的课程名
        UILabel * subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 15)];
        subjectLabel.center = CGPointMake(scoreView.center.x, scoreView.center.y+scoreView.frame.size.height*0.5+10);
        subjectLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        subjectLabel.font = [UIFont systemFontOfSize:8];
        subjectLabel.text = scoreModel.lessonName;
        subjectLabel.textAlignment = NSTextAlignmentCenter;
        [self.gradeScorllerView addSubview:subjectLabel];
    }
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
}

-(void)selectGradeView:(UITapGestureRecognizer *)gesture {
    UIView * selectLabel = (UIView *)gesture.view;
    CGFloat offset = selectLabel.center.x - self.gradeScorllerView.frame.size.width*0.5;
    if (offset < 0){
        offset = 0;
    }
    //处理右边的区域
    CGFloat maxOffset = self.gradeScorllerView.contentSize.width - self.gradeScorllerView.frame.size.width;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.gradeScorllerView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

@end
