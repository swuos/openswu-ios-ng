//
//  SWUScrollview.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/26.
//

#import "SWUScrollview.h"
#import "Weekitem.h"
#import "SWUAlertViewController.h"
#import "Data.h"
#import "MJExtension.h"
#import "SWULabel.h"
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
/** 点击手势  */
@property (nonatomic,strong) UITapGestureRecognizer * tap;
/** data  */
@property (nonatomic,strong) Data * data;
@end

@implementation SWUScrollview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentSize = CGSizeMake(frame.size.width, CELL_HW*14);
    }
    return self;
}


-(NSArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    }
    return _dateArray;
}

-(void)layoutSubviews {
//    删除之前存在的视图，保证数据的更新
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [super layoutSubviews];
    //    删除之前的视图
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    //    添加星期几
    for (int i = 0; i < 7; i++) {
        SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(TIME_HW+i*CELL_HW, 0, CELL_HW, TIME_HW)];
        label.text = self.dateArray[i];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
    }
    //    添加时间课程
    for (int i = 0; i < 14; i++) {
        SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(0, TIME_HW+i*CELL_HW, TIME_HW, CELL_HW)];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        [self addSubview:label];
    }
    //        读取数据，然后布局
    for (int i = 0;i < self.data.weekitem.count;i++) {
        self.weekitem = _data.weekitem[i];
        NSInteger count = _weekitem.endTime.integerValue-_weekitem.startTime.integerValue+1;;
        SWULabel * label = [[SWULabel alloc] initWithFrame:CGRectMake(TIME_HW+(_weekitem.day.integerValue-1)*CELL_HW, (_weekitem.startTime.integerValue-1)*CELL_HW+TIME_HW, CELL_HW,CELL_HW*count)];
        _weekitem.scrollerViewCount = i;
        label.weekitem = _weekitem;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetailInfo:)];
        [label addGestureRecognizer:tapGesture];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
    }
}
-(void)showDetailInfo:(UITapGestureRecognizer *)sender {
    self.alert = [SWUAlertViewController alertControllerWithSWULabel:(SWULabel*)sender.view];
    //    添加Windows手势   点击空白处消失
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture:)];
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_tap];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_alert animated:_alert completion:nil];
}
//点击空白消失
-(void)handletapPressGesture:(UITapGestureRecognizer*)sender {
    CGPoint location = [sender locationInView:self];
    if (!CGRectContainsPoint(_alert.view.frame, location)) {
        [_alert dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:_tap];
    }
}
-(void)setData:(Data * )data {
    _data = data;
//    去除重叠时候发生的数据不能够更新的问题
    [self layoutSubviews];
}

@end
