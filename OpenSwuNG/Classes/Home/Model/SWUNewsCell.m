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

@interface SWUNewsCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *newsInfoLabel;
@property (nonatomic,strong) UIImageView *realImageView;
@end

@implementation SWUNewsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    self.titleLabel = [[UILabel alloc] initWithFrame:self.frame];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:self.titleLabel];
    self.newsInfoLabel = [[UILabel alloc] initWithFrame:self.frame];
//    self.newsInfoLabel.backgroundColor =[UIColor redColor];
    self.newsInfoLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.newsInfoLabel];
    self.realImageView  = [[UIImageView alloc] initWithFrame:self.frame];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"load" ofType:@"gif"];
    
//    http://img.zcool.cn/community/01ae565972f1eaa8012193a3f58f8a.gif
//    NSURL *url = [NSURL URLWithString:@" http://img.zcool.cn/community/01ae565972f1eaa8012193a3f58f8a.gif"];
//    [self.realImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    
//    NSData *data = [NSData dataWithContentsOfFile:@"load"];
//    NSLog(@"%@",data);
//    self.realImageView.image = [UIImage imageNamed:@"load"];
    self.realImageView.image = [UIImage imageNamed:@"load"];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-1.5);
        make.height.equalTo(@0.5);
    }];
}

-(void)layoutSubviews {
//    NSLog(@"%@  %@",self.realImageView.superview ,self);
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
}

-(void)setModel:(SWUNewsModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.newsInfoLabel.text = model.time;
    if (model.imgUrl.count > 0) {
        [self addSubview:self.realImageView];
        __block UIImage * image;
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        [manager.requestSerializer setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
        [manager GET:model.imgUrl[0] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            image = [UIImage imageWithData:responseObject];
            self.realImageView.image = image;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        [self layoutSubviews];
        return;
    }
    [self.realImageView removeFromSuperview];
    [self layoutSubviews];
    
}
@end
