//
//  SWUPointView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import "SWUPointView.h"
#import "SWULabel.h"
#import "Masonry.h"
#import "SWUScoreModel.h"
#import "SWUPickerView.h"

@interface SWUPointView ()
/** 模型数据  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUPointView

-(void)setUpSomeLabel:(NSMutableDictionary *)paraDic {
    double avgCount = 0;
    for (SWUScoreModel * model in self.dataArray) {
        avgCount += model.gradePoint.doubleValue;
    }
    SWULabel * pointLabel = [[SWULabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5)];
    pointLabel.font = [UIFont systemFontOfSize:27];
    pointLabel.textColor = [UIColor blackColor];
    pointLabel.text = [NSString stringWithFormat:@"%0.2lf",(avgCount / _dataArray.count)];
    [self addSubview:pointLabel];
//    平均绩点
    SWULabel * averageLabel = [[SWULabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pointLabel.frame), self.frame.size.width, self.frame.size.height*0.2)];
    averageLabel.textColor = [UIColor blackColor];
    averageLabel.text = @"平均绩点";
    averageLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:averageLabel];
    
//    学期
    SWULabel * timeLabel = [[SWULabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.8, self.frame.size.height*0.3)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.text = [NSString stringWithFormat:@"%@学年 第%@学期",paraDic[@"academicYear"],paraDic[@"term"]];
    timeLabel.layer.borderWidth = 0.5;
    timeLabel.layer.cornerRadius = 4;
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(averageLabel).offset(averageLabel.frame.size.height+5);
        make.width.equalTo(self.mas_width).multipliedBy(0.3);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
}

+(SWUPointView *)swuPointViewWithFrame:(CGRect)frame
                             DataArray:(NSArray *)dataArray
                               ParaDic:(NSMutableDictionary *)dic {
    SWUPointView * pointView = [[SWUPointView alloc] initWithFrame:frame];
    pointView.dataArray = dataArray;
    [pointView setUpSomeLabel:dic];
    
    return pointView;
}

@end
