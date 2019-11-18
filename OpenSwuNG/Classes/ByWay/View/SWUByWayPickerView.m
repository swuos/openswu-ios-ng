//
//  SWUByWayPickerView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/18.
//

#import "SWUByWayPickerView.h"
#import "UIButton+Login.h"

@interface SWUByWayPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSMutableArray * pickerDataArray;
@property (nonatomic,strong) NSDictionary * pickerDic;
/** picker  */
@property (nonatomic,strong) UIPickerView * picker;
@end
@implementation SWUByWayPickerView


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
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
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
    
    UIImage * blueImage = [SWUByWayPickerView createImageWithColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]];//蓝色
    UIImage * touchDownimage = [SWUByWayPickerView createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];//灰色
    UIImage *lightGrayImage = [SWUByWayPickerView createImageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
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
    //    if ([self.delegate respondsToSelector:@selector(SWUByWayPickerViewDidSelected:)]) {
    //        NSArray * station = _pickerDataArray[1];
    //        NSString *start = [station objectAtIndex:[self.picker selectedRowInComponent:1]];
    //        [self.delegate SWUByWayPickerViewDidSelected:start];
    //        [self removeFromSuperview];
    //    }
    NSArray * stationArray = _pickerDataArray[1];
    NSString *station = [stationArray objectAtIndex:[self.picker selectedRowInComponent:1]];
    if (self.block) {
        self.block(station);
        [self removeFromSuperview];
    }
    
}
-(void)CancelBtnClick{
    [self removeFromSuperview];
}

-(NSDictionary *)pickerDic {
    if (!_pickerDic) {
        _pickerDic = @{
                       @"环线":@[@"重庆图书馆",@"沙坪坝",@"沙正街",@"玉带山",@"体育公园",@"冉家坝",@"动步公园",@"洪湖东路",@"民安大道",@"重庆北站南广场",@"渝鲁",@"五里店",@"弹子石",@"涂山",@"上新街",@"海棠溪",@"罗家坝",@"四公里",@"南湖",@"海峡路"],
                       @"1号线":@[@"小什字",@"较场口",@"七星岗",@"两路口",@"鹅岭",@"大坪",@"石油路",@"歇台子",@"石桥铺",@"高庙村",@"马家岩",@"小龙坎",@"沙坪坝",@"杨公桥",@"烈士墓",@"磁器口",@"石井坡",@"双碑",@"赖家桥",@"微电园",@"陈家桥",@"大学城",@"尖顶坡"],
                       @"2号线":@[@"较场口",@"临江门",@"黄花园",@"大溪沟",@"曾家岩",@"牛角沱",@"李子坝",@"佛图关",@"大坪",@"袁家岗",@"谢家湾",@"杨家坪",@"动物园",@"大堰村",@"马王场",@"平安",@"大渡口",@"新山村",@"天堂堡",@"建桥",@"金家湾",@"刘家坝",@"白居寺",@"大江",@"鱼洞"],
                       @"3号线":@[@"鱼洞",@"金竹",@"鱼胡路",@"学堂湾",@"大山村",@"花溪",@"岔路口",@"九公里",@"麒龙",@"八公里",@"二塘",@"六公里",@"五公里",@"四公里",@"南坪",@"工贸",@"铜元局",@"两路口",@"牛角沱",@"华新街",@"观音桥",@"红旗河沟",@"嘉州路",@"郑家院子",@"唐家院子",@"狮子坪",@"重庆北站南广场",@"龙头寺",@"童家院子",@"金渝",@"金童路",@"鸳鸯",@"园博园",@"翠云",@"长福路",@"回兴",@"双龙",@"碧津",@"江北机场T2航站楼",@"双凤桥",@"空港广场",@"高堡湖",@"观月路",@"莲花",@"举人坝"],
                       @"4号线":@[@"民安大道",@"重庆北站北广场",@"头塘",@"保税港",@"寸滩",@"黑石子",@"太平冲",@"唐家沱"],
                       @"5号线":@[@"园博中心",@"丹鹤",@"湖霞街",@"重光",@"和睦路",@"人和",@"幸福广场",@"冉家坝",@"大龙山",@"大石坝"],
                       @"6号线":@[@"茶园",@"邱家湾",@"长生桥",@"刘家坪",@"上新街",@"小什字",@"大剧院",@"江北城",@"五里店",@"红土地",@"黄泥塝",@"红旗河沟",@"花卉园",@"大龙山",@"冉家坝",@"光电园",@"大竹林",@"康庄",@"九曲河",@"礼嘉",@"金山寺",@"曹家湾",@"蔡家",@"向家岗",@"龙凤溪",@"状元碑",@"天生",@"北碚"],
                       @"10号线":@[@"礼嘉",@"欢乐谷",@"黄茅坪",@"高义口",@"国博中心",@"悦来"],
                       @"国博线":@[@"鲤鱼池",@"红土地",@"龙头寺公园",@"重庆北站南广场",@"重庆北站北广场",@"民心佳园",@"三亚湾",@"上湾路",@"环山公园",@"长河",@"江北机场T3航站楼",@"江北机场T2航站楼",@"渝北广场",@"鹿山",@"中央公园东",@"中央公园",@"中央公园西",@"悦来",@"王家庄"]
                       };
        
        
    }
    return _pickerDic;
}
-(NSArray *)pickerDataArray {
    if (!_pickerDataArray) {
        _pickerDataArray = [NSMutableArray arrayWithObjects:@[@"环线",@"1号线",@"2号线",@"3号线",@"4号线",@"5号线",@"6号线",@"10号线",@"国博线"],self.pickerDic[@"环线"],nil];
        
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSArray * array = self.pickerDataArray[component];
        [self.pickerDataArray replaceObjectAtIndex:1 withObject:self.pickerDic[array[row]]];
        [self.picker reloadComponent:1];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc]init];
        //在这里设置字体相关属性
        label.font = [UIFont systemFontOfSize:22];
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
