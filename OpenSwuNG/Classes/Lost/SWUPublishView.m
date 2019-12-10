//
//  SWUPublishView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import "SWUPublishView.h"
#import "Masonry.h"

@interface SWUPublishView()<UITextViewDelegate>

@end

@implementation SWUPublishView
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    CGFloat standFontSize = 20;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    titleLabel.text = @"请输入要发布的信息";
    titleLabel.font = [UIFont systemFontOfSize:standFontSize];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    noteLabel.font = [UIFont systemFontOfSize:standFontSize-4];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.numberOfLines = 0;
    noteLabel.text = @"使用须知：\n    为了给大家提供方便，请不要发布虚假无效信息，谢谢配合！我们也将有权利删除用户发布的信息，多次发布类似信息者账号将被封停。";
    [noteLabel sizeToFit];
    [self addSubview:noteLabel];
    
    UITextView *inputInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    inputInfoTextView.font = [UIFont systemFontOfSize:standFontSize -3];
    inputInfoTextView.backgroundColor = [UIColor lightGrayColor];
    inputInfoTextView.alpha = 0.5;
    self.inputInfoTextView = inputInfoTextView;
    self.inputInfoTextView.delegate = self;
    [self addSubview:_inputInfoTextView];
    
    self.stringLenghLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    [self addSubview:self.stringLenghLabel];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.layer.cornerRadius = 4.0;
    [publishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [publishBtn setBackgroundColor:[UIColor colorWithRed:40/255.0 green:122/255.0 blue:246/255.0 alpha:1.0]];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:publishBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@30);
    }];
    
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(noteLabel.mas_height);
    }];
    
    [self.inputInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteLabel.mas_bottom).offset(10);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(@200);
    }];
    [self.stringLenghLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputInfoTextView).offset(-5);
        make.bottom.equalTo(self.inputInfoTextView).offset(-5);
        make.width.equalTo(self.stringLenghLabel.mas_width);
        make.height.equalTo(self.stringLenghLabel.mas_height);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputInfoTextView.mas_bottom).offset(10);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(@40);
    }];
}

#pragma mark ------ lazyLoad -------
#pragma mark ------ delegate -------
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = @"";
    self.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)textView.text.length];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    self.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)textView.text.length];
    if (textView.text.length >= 600) {
        textView.text = [textView.text substringToIndex:100];
        self.stringLenghLabel.text = @"600/600";
    }
}

-(void)publishBtnDidClicked {
    if (self.publishBlock) {
        self.publishBlock();
    }
}
@end
