//
//  SWUTotalScoreView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import "SWUTotalScoreView.h"
#import "SWULabel.h"
#import "Masonry.h"
#import "SWUScoreModel.h"

@interface SWUTotalScoreView ()
/** 存放数据的数组  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUTotalScoreView


-(void)setUpUI:(CGRect)frame {
    self.clipsToBounds = YES;
    NSArray * titleArray = [NSArray arrayWithObjects:@"本学期总学分",@"必修课平均GPA",@"专业课学分", nil];
//    总学分
    double totalCount = 0;
    double avgMustSubjectCount = 0;
    int subjectCount = 0;
    double majorCount = 0;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        SWUScoreModel * model = _dataArray[i];
        totalCount += model.credit.doubleValue;
        if ([model.lessonType containsString:@"必修"]) {
            avgMustSubjectCount += model.gradePoint.doubleValue;
            subjectCount++;
        }
        if ([model.lessonType containsString:@"专业"]) {
            majorCount += model.credit.doubleValue;
        }
    }
    NSArray * countArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%0.2lf",totalCount],[NSString stringWithFormat:@"%0.2lf",avgMustSubjectCount/subjectCount],[NSString stringWithFormat:@"%0.2lf",majorCount],nil];
    
    for (int i = 0; i < titleArray.count; i++) {
        SWULabel * titleLabel  = [[SWULabel alloc] initWithFrame:CGRectMake(i*frame.size.width/titleArray.count, 8, frame.size.width/titleArray.count, frame.size.height*0.3)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:titleLabel];
        SWULabel * countLabel = [[SWULabel alloc] initWithFrame:CGRectMake(i*frame.size.width/titleArray.count, CGRectGetMaxY(titleLabel.frame), frame.size.width/titleArray.count,frame.size.height*0.65)];
        countLabel.textColor = [UIColor blackColor];
        countLabel.font = [UIFont systemFontOfSize:19];
        countLabel.text = countArray[i];
        [self addSubview:countLabel];
    }
}
+(SWUTotalScoreView *)swuTotalScoreViewWithFrame:(CGRect)frame
                                         DataArray:(NSArray *)dataArray {
    SWUTotalScoreView * totalScoreView = [[SWUTotalScoreView alloc] initWithFrame:frame];
    totalScoreView.dataArray = dataArray;
    [totalScoreView setUpUI:frame];
    return totalScoreView;
}

@end
