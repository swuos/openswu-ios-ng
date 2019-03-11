//
//  SWUPickerView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import "SWUPickerView.h"
#import "NSDate+PickerView.h"
#import "UIButton+Login.h"

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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
    messageLabel.text = @"切换当前学年和学期";
    messageLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:messageLabel];
    
    //    添加选择日期的
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(messageLabel.frame), frame.size.width, frame.size.height-94)];
    self.picker.backgroundColor = [UIColor greenColor];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self addSubview:_picker];
    
    UIImage * touchDownimage = [SWUPickerView createImageWithColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]];
    UIImage * touchUpimage = [SWUPickerView createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    UIButton * okBtn = [UIButton ButtonWithTitle:@"确定" Frame:CGRectMake(0, CGRectGetMaxY(_picker.frame), frame.size.width*0.5, 44) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor blackColor]];
    [okBtn addTarget:self action:@selector(OkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setBackgroundImage:touchDownimage forState:UIControlStateHighlighted];
    [okBtn setBackgroundImage:touchUpimage forState:UIControlStateNormal];
    [self addSubview:okBtn];
    UIButton * cancelBtn = [UIButton ButtonWithTitle:@"取消" Frame:CGRectMake(CGRectGetMaxX(okBtn.frame), CGRectGetMaxY(_picker.frame), frame.size.width*0.5, 44) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor blackColor]];
    [cancelBtn addTarget:self action:@selector(CancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:touchDownimage forState:UIControlStateHighlighted];
    [cancelBtn setBackgroundImage:touchUpimage forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    
}
-(void)OkBtnClick{
    if ([self.delegate respondsToSelector:@selector(SWUPickerViewDidSelected:)]) {

        NSArray * firstArr = _pickerDataArray[0];
        NSString * academicYear = [[firstArr objectAtIndex:[_picker selectedRowInComponent:0]] substringToIndex:4];
        NSString * term = [NSString stringWithFormat:@"%ld",[_picker selectedRowInComponent:1]+1] ;
        NSMutableDictionary * paraDic = [[NSMutableDictionary alloc] init];
        [paraDic setObject:academicYear forKey:@"academicYear"];
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
    return array[row];
}
+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
