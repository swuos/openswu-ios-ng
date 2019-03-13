//
//  SWUScoreCell.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import "SWUScoreCell.h"
#import "Constants.h"
#import "SWUScoreModel.h"

@interface SWUScoreCell ()
/** 学科名字  */
@property (nonatomic,strong) UILabel * subjectLabel;
/** 成绩  */
@property (nonatomic,strong) UILabel * gradeLabel;
/** 学分  */
@property (nonatomic,strong) UILabel * gradePointLabel;
/** 绩点  */
@property (nonatomic,strong) UILabel * creditLabel;
@end

@implementation SWUScoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect frame = self.frame;
    CGFloat singleWidth = SCREEN_WIDTH / 10.0;
    CGFloat headY = 5;
    
    self.subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headY, singleWidth*4, frame.size.height)];
    _subjectLabel.font = [UIFont systemFontOfSize:14];
    _subjectLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _subjectLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subjectLabel];
    
    self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_subjectLabel.frame), headY, singleWidth*2, frame.size.height)];
    _gradeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gradeLabel];
    
    self.gradePointLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_gradeLabel.frame), headY, singleWidth*2, frame.size.height)];
    _gradePointLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gradePointLabel];
    
    self.creditLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_gradePointLabel.frame), headY, singleWidth*2, frame.size.height)];
    _creditLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_creditLabel];
}
-(void)setModel:(SWUScoreModel *)model {
    _model = model;
    _subjectLabel.text = _model.lessonName;
    _gradeLabel.text = _model.score;
    _gradePointLabel.text = _model.credit;
    _creditLabel.text = [NSString stringWithFormat:@"%@",_model.gradePoint];
}


@end
