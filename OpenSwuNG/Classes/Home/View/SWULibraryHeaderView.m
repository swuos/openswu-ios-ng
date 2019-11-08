//
//  SWULibraryHeaderView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import "SWULibraryHeaderView.h"
#import "Masonry.h"

@implementation SWULibraryHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        [self setUI:frame];
    }
    return self;
}
-(void)setUI:(CGRect)frame {
    
    UITextField * searchTextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, frame.size.width, 50)];
    
//    [self addSubview:searchTextfield];
    
    UILabel * bookcaseLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width, 50)];
    bookcaseLable.text = @"我的书架";
    bookcaseLable.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVc)];
    [bookcaseLable addGestureRecognizer:tap];
    [self addSubview:bookcaseLable];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundImage:[UIImage imageNamed:@"main_more"] forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn addTarget:self action:@selector(changeVc) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor blackColor];
    [self addSubview:btn];
    
    UILabel * popularLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
    popularLable.text = @"热门图书";
    [self addSubview:popularLable];
    [self addSubview:popularLable];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(bookcaseLable).offset(15);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bookcaseLable.mas_left);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(bookcaseLable.mas_bottom).offset(-5);
        make.height.equalTo(@0.5);
    }];
    
    [popularLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bookcaseLable.mas_bottom).offset(5);
        make.left.equalTo(bookcaseLable);
    }];
    
}

-(void)changeVc {
    self.changeVcBlock();
}


@end
