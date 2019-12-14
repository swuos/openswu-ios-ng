//
//  SWUBookCaseHeaderView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import "SWUBookCaseHeaderView.h"
#import "Masonry.h"

@interface SWUBookCaseHeaderView()
@property (nonatomic,strong) UIView *scrollLineView;
@property (nonatomic,strong) UIButton *selectbtn;
@end

@implementation SWUBookCaseHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI:frame];
    }
    return self;
}

-(void)setUI:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    backView.backgroundColor = [UIColor lightGrayColor];
//    self.alpha = 0.5;
    [self addSubview:backView];
    
    CGFloat lineSperator = 1;
    CGFloat width = (self.frame.size.width - 4*lineSperator)/3.0;
    NSArray *nameArr = @[@"借阅历史",@"在借书籍",@"收藏书籍"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [self creatBtnName:nameArr[i] frame:CGRectMake(lineSperator + i * (width+lineSperator), 0, width, frame.size.height-2)];
        btn.tag = i+10;
        [backView addSubview:btn];
    }
    self.scrollLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 2, width - 20, 2)];
    CGFloat x = lineSperator + width/2.0;
    _scrollLineView.center = CGPointMake(x, _scrollLineView.center.y);
    _scrollLineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_scrollLineView];
    self.selectbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectbtn = [self viewWithTag:10];
    self.selectbtn.tintColor = [UIColor orangeColor];
}

-(UIButton *)creatBtnName:(NSString *)name frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.tintColor = [UIColor blackColor];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn.imageView removeFromSuperview];
    [btn addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)changeVc:(UIButton *)btn {
    [UIView animateWithDuration:0.4 animations:^{
        self->_scrollLineView.center = CGPointMake(btn.center.x, self->_scrollLineView.center.y);
        self->_selectbtn.tintColor = [UIColor blackColor];
        btn.tintColor = [UIColor orangeColor];
        self->_selectbtn = btn;
    }];
    
    self.changeVcBlock(btn.titleLabel.text);
}

@end
