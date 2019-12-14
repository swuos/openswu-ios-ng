//
//  SWUNewsCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import "SWUNewsCell.h"
#import "SWUNewsModel.h"
#import "SWUFactory.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "Factory.h"

@interface SWUNewsCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *newsInfoLabel;
@property (nonatomic,strong) UIImageView *realImageView;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation SWUNewsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.newsInfoLabel];
    
    [self.contentView addSubview:self.lineView];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.realImageView.superview == self) {
//        存在图片
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@20);
            make.width.equalTo(@250);
        }];
        [self.newsInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@15);
        }];
        [self.realImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self.newsInfoLabel);
            make.width.equalTo(self.realImageView.mas_height).multipliedBy(1.5);
        }];
        return;
    }
//    不存在图片
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@20);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.newsInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-1.5);
        make.height.equalTo(@0.5);
    }];
}

-(void)setModel:(SWUNewsModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.newsInfoLabel.text = model.time;
    if (model.imgUrl.count > 0) {
        [self addSubview:self.realImageView];
//        self.realImageView.image = [UIImage imageNamed:@"load.jpg"];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:[NSURL URLWithString:model.imgUrl[0]] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                self.realImageView.image = image;
                [self layoutSubviews];
            }
        }];
        return ;
    }
    [self.realImageView removeFromSuperview];
    [self layoutSubviews];
}

#pragma mark ------ lazyLoad -------
//@property (nonatomic,strong) UILabel *titleLabel;
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        //    self.titleLabel.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}
//@property (nonatomic,strong) UILabel *newsInfoLabel;
-(UILabel *)newsInfoLabel {
    if (!_newsInfoLabel) {
        self.newsInfoLabel = [[UILabel alloc] initWithFrame:self.frame];
        //    self.newsInfoLabel.backgroundColor =[UIColor redColor];
        self.newsInfoLabel.font = [UIFont systemFontOfSize:12];
    }
    return _newsInfoLabel;
}
//@property (nonatomic,strong) UIImageView *realImageView;
-(UIImageView *)realImageView {
    if (!_realImageView) {
        self.realImageView  = [[UIImageView alloc] initWithFrame:self.frame];
        //    NSString *path = [[NSBundle mainBundle] pathForResource:@"load" ofType:@"gif"];
        
        //    http://img.zcool.cn/community/01ae565972f1eaa8012193a3f58f8a.gif
        //    NSURL *url = [NSURL URLWithString:@" http://img.zcool.cn/community/01ae565972f1eaa8012193a3f58f8a.gif"];
        //    [self.realImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
        
        //    NSData *data = [NSData dataWithContentsOfFile:@"load"];
        //    NSLog(@"%@",data);
        //    self.realImageView.image = [UIImage imageNamed:@"load"];
        self.realImageView.image = [Factory createImageWithColor:[UIColor lightGrayColor]];
    }
    return _realImageView;
}
//@property (nonatomic,strong) UIView *lineView;
-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0.5)];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.alpha = 0.5;
    }
    return _lineView;
}


@end
