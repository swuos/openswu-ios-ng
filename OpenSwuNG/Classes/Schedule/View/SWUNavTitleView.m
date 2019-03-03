//
//  SWUNavTitleView.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUNavTitleView.h"
#import "Constants.h"
#import "SWULabel.h"
#import "Masonry.h"

@interface SWUNavTitleView ()
/** 标题图片是否下拉  */
@property (nonatomic,assign) BOOL  isOpen;
@end

@implementation SWUNavTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[SWULabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        self.weekDeirView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"schedule_down"]];
        _weekDeirView.userInteractionEnabled = YES;
        [self addSubview:_weekDeirView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(self->_titleLabel.mas_height).multipliedBy(2);
        make.center.mas_equalTo(self);
    }];
    
    [_weekDeirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.width.equalTo(@15);
        make.right.equalTo(self->_titleLabel).offset(3);
    }];
}





@end
