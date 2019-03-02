//
//  SWUTextField.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/28.
//

#import "SWUTextField.h"

@interface SWUTextField ()
/** 底部的线条  */
@property (nonatomic,strong) UIView * lineView;
@end

@implementation SWUTextField

+(SWUTextField *)SWUTextFieldWithFrame:(CGRect)frame
                              LeftView:(UIView *)leftView
                                  Text:(NSString *)text
                          KeyBoardType:(UIKeyboardType)type{
    SWUTextField * textField = [[SWUTextField alloc]initWithFrame:frame];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = text;
    textField.keyboardType = type;
    textField.keyboardAppearance = UIKeyboardAppearanceLight;
    return textField;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width-self.leftView.frame.size.width, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
    }
    return self;
}

//设置左视图
-(CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect  = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}
//编辑时候文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 20;
    editingRect.origin.y += 2;
    return editingRect;
}
//占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 1;
    return placeholderRect;
}
//文字显示的位置
-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 20;
    textRect.origin.y += 2;
    return textRect;
}

//设置底部线条的尺寸
-(void)setLineViewLength:(CGRect)frame {
    self.lineView.frame = frame;
}


@end
