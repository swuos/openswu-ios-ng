//
//  SWUAboutHeaderView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/20.
//

#import "SWUAboutHeaderView.h"
#import "Masonry.h"

@implementation SWUAboutHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI {
//    添加图片
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_logo"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
        make.bottom.equalTo(self).offset(-64);
        make.width.mas_equalTo(imageView.mas_height).multipliedBy(1.0);
        make.centerX.equalTo(self);
    }];
//    添加label
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"西大助手\nVersion. 2.0.0";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).offset(15+imageView.frame.size.height);
        make.centerX.equalTo(self);
    }];
}

@end
