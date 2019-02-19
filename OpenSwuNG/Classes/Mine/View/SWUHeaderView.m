//
//  SWUHeaderView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/17.
//

#import "SWUHeaderView.h"
#import "Masonry.h"

@implementation SWUHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
//        label.backgroundColor = [UIColor purpleColor];
        label.font = [UIFont systemFontOfSize:21];
        label.text = @"欢迎你，余泰澄同学";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(25, 15, 40, 100));
        }];
        
        
        UILabel * collegeLabel  = [[UILabel alloc] init];
//        collegeLabel.backgroundColor = [UIColor greenColor];
        collegeLabel.text = @"软件学院";
        collegeLabel.font = [UIFont systemFontOfSize:12];
        collegeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:collegeLabel];
        [collegeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom);
            make.left.right.mas_equalTo(label);
            make.bottom.equalTo(self).offset(-10);
        }];
        
//        设置图片的自适应
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headview"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.bottom.right.equalTo(self).offset(-15);
            make.width.mas_equalTo(imageView.mas_height).multipliedBy(1);
        }];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.width/2.0;
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}



@end
