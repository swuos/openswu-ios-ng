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
        self.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:21];
        label.text = @"同学,欢迎你 !";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(25, 15, 40, 100));
        }];
        
        UILabel * collegeLabel  = [[UILabel alloc] init];
        collegeLabel.text = @"含弘光大，继往开来";
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
    }
    return self;
}



@end
