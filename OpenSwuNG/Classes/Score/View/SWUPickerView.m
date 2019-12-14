//
//  SWUPickerView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import "SWUPickerView.h"
#import "NSDate+PickerView.h"
#import "UIButton+Login.h"
#import "Factory.h"

@interface SWUPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
/** picker的数据  */
@property (nonatomic,strong) NSArray * pickerDataArray;
/** picker  */
@property (nonatomic,strong) UIPickerView * picker;
@end
@implementation SWUPickerView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI:frame];
    }
    return self;
}
-(void)setUpUI:(CGRect)frame {
    //    定制日期选择
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*0.2)];
    messageLabel.text = @"切换当前学年和学期";
    messageLabel.layer.cornerRadius = 10;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:messageLabel];
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(messageLabel.frame),frame.size.width, 0.5)];
    lineView1.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView1];
    
    //    添加选择日期的
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView1.frame), frame.size.width, frame.size.height*0.6)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self addSubview:self.picker];
    
    UIImage * blueImage = [Factory createImageWithColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]];//蓝色
    UIImage * touchDownimage = [Factory createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];//灰色
    UIImage *lightGrayImage = [Factory createImageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    UIButton * okBtn = [UIButton ButtonWithTitle:@"确定" Frame:CGRectMake(0, CGRectGetMaxY(_picker.frame), frame.size.width*0.5, frame.size.height*0.2) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor blackColor]];
    [okBtn addTarget:self action:@selector(OkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setBackgroundImage:touchDownimage forState:UIControlStateHighlighted];
    [okBtn setBackgroundImage:blueImage forState:UIControlStateNormal];
    okBtn.layer.cornerRadius = 10;
    [self addSubview:okBtn];
    
    UIButton * cancelBtn = [UIButton ButtonWithTitle:@"取消" Frame:CGRectMake(CGRectGetMaxX(okBtn.frame), CGRectGetMaxY(_picker.frame), frame.size.width*0.5, frame.size.height*0.2) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor blackColor]];
    [cancelBtn addTarget:self action:@selector(CancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:touchDownimage forState:UIControlStateHighlighted];
    [cancelBtn setBackgroundImage:lightGrayImage forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 10;
    [self addSubview:cancelBtn];
    
}
-(void)OkBtnClick{
    if ([self.delegate respondsToSelector:@selector(SWUPickerViewDidSelected:)]) {
        NSArray * firstArr = _pickerDataArray[0];
        NSString * academicYear = [[firstArr objectAtIndex:[_picker selectedRowInComponent:0]] substringToIndex:4];
        NSString * term = [NSString stringWithFormat:@"%ld",[_picker selectedRowInComponent:1]+1] ;
        NSMutableDictionary * paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:academicYear forKey:@"year"];
        [paraDic setObject:term forKey:@"term"];
        [self.delegate SWUPickerViewDidSelected:paraDic];
        [self removeFromSuperview];
    }
}
-(void)CancelBtnClick{
    [self removeFromSuperview];
}


-(NSArray *)pickerDataArray {
    if (!_pickerDataArray) {
        _pickerDataArray = [NSDate getPickerViewDataArray];
    }
    return _pickerDataArray;
}

#pragma mark ------ UIPickerViewDataSource ------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerDataArray.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray * array = self.pickerDataArray[component];
    return array.count;
}

#pragma mark ------ UIPickerViewDelegate ------
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray * array = self.pickerDataArray[component];
    ((UILabel *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor lightGrayColor];//显示分隔线
    ((UILabel *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor lightGrayColor];
    return array[row];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc]init];
        //在这里设置字体相关属性
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    //重新加载label的文字内容
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    UILabel *selectLabel = (UILabel *)[pickerView viewForRow:row forComponent:component];
    if (selectLabel) {
        selectLabel.textColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    }
    return label;
}



@end
