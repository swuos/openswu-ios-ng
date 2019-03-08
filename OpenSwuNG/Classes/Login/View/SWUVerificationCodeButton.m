//
//  SWUVerificationCodeButton.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/7.
//

#import "SWUVerificationCodeButton.h"
#import "UIButton+Login.h"

@interface  SWUVerificationCodeButton()
/** 定时器  */
@property (nonatomic,strong) NSTimer * timer;
/** 定时多少秒  */
@property (nonatomic,assign) NSInteger  secondCount;
@end

@implementation SWUVerificationCodeButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 3.0;
        self.clipsToBounds = YES;
        [self setTitleColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.imageView removeFromSuperview];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

-(void)timeFailBeginFrom:(NSInteger)timeCount {
    self.secondCount = timeCount;
    self.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}
-(void)timeDown {
    if (self.secondCount != 1) {
        _secondCount -= 1;
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"%lds", _secondCount] forState:UIControlStateNormal];
        return;
    }
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.timer invalidate];
}




@end
