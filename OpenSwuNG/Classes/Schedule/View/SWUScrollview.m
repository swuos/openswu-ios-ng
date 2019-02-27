//
//  SWUScrollview.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/26.
//

#import "SWUScrollview.h"
#import "Constants.h"



@interface SWUScrollview ()
/** 日期数组  */
@property (nonatomic,strong) NSArray * dateArray;
/** 数据数组  */
@property (nonatomic,strong) NSArray * dataArray;
/** 显示详细信息  */
@property (nonatomic,strong) SWUAlertViewController * alert;
/** 传递数据  */
@property (nonatomic,strong) Weekitem * weekitem;
@end

@implementation SWUScrollview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentSize = CGSizeMake(frame.size.width, cellHW*14);
    }
    return self;
}
-(NSArray *)dataArray {
    if (!_dataArray) {
        [Data mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"weekitem":[Weekitem class]};
        }];
        _dataArray = [Data mj_objectArrayWithFilename:@"course.plist"];
    }
    return _dataArray;
}

-(NSArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    }
    return _dateArray;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //    删除之前的视图
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    //    添加星期几
    for (int i = 0; i < 7; i++) {
        SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(timeHW+i*cellHW, 0, cellHW, timeHW)];
        label.text = self.dateArray[i];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
    }
    //    添加时间课程
    for (int i = 0; i < 14; i++) {
        SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(0, timeHW+i*cellHW, timeHW, cellHW)];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [self addSubview:label];
    }
    
    
    //        读取数据，然后布局
    for (Data * data in self.dataArray) {
        for (int i = 0;i < data.weekitem.count;i++) {
          self.weekitem = data.weekitem[i];
            NSInteger count = _weekitem.endTime.integerValue-_weekitem.startTime.integerValue+1;;
            SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(timeHW+(_weekitem.day.integerValue-1)*cellHW, (_weekitem.startTime.integerValue-1)*cellHW+timeHW, cellHW,cellHW*count)];
            _weekitem.scrollerViewCount = i;
            label.weekitem = _weekitem;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetailInfo:)];
            [label addGestureRecognizer:tapGesture];
            label.userInteractionEnabled = YES;
            [self addSubview:label];
        }
    }
}
-(void)showDetailInfo:(UITapGestureRecognizer *)sender {
    self.alert = [SWUAlertViewController alertControllerWithSWULabel:(SWULabel*)sender.view];
    //    添加Windows手势   点击空白处消失
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture:)];
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_alert animated:_alert completion:nil];
}
//点击空白消失
-(void)handletapPressGesture:(UITapGestureRecognizer*)sender {
    CGPoint location = [sender locationInView:self];
    if (!CGRectContainsPoint(_alert.view.frame, location)) {
        [_alert dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
