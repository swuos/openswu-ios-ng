//
//  SWULibraryCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import "SWULibraryCell.h"
#import "Masonry.h"

@interface SWULibraryCell()
@property (nonatomic,strong) UILabel * authorLable;
@property (nonatomic,strong) UILabel * bookNameLabel;
@property (nonatomic,strong) UILabel * bookInfoLabel;

@end

@implementation SWULibraryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"books"]];
    CGFloat height = self.frame.size.height;
    imageView.frame = CGRectMake(0, 0, 1.343*height, height);
    [self addSubview:imageView];
    CGFloat standFont = 15;
    self.bookNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height, 20)];
    self.bookNameLabel.font = [UIFont systemFontOfSize:standFont];
    [self addSubview:_bookNameLabel];
    
    self.authorLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height, 20)];
    self.authorLable.font = [UIFont systemFontOfSize:standFont-2];
    [self addSubview:_authorLable];
    
    self.bookInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height, 20)];
    self.bookInfoLabel.numberOfLines = 0;
    self.bookInfoLabel.textColor = [UIColor lightGrayColor];
    self.bookInfoLabel.font = [UIFont systemFontOfSize:standFont-2];
    [self addSubview:_bookInfoLabel];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.height.equalTo(@100);
        make.width.equalTo(imageView.mas_height).multipliedBy(0.927);
    }];
    
    [self.bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_top).offset(3);
        make.left.equalTo(imageView.mas_right).offset(5);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@17);
    }];
    [self.authorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(self.bookNameLabel);
        make.top.equalTo(self.bookNameLabel.mas_bottom).equalTo(@2);
    }];
    
    [self.bookInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bookNameLabel);
        make.top.equalTo(self.authorLable.mas_bottom).equalTo(@7);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_left);
        make.right.equalTo(self.bookNameLabel.mas_right);
        make.bottom.equalTo(self).offset(-1.5);
        make.height.equalTo(@0.5);
    }];
    
    
}

-(void)setModel:(SWUPopularModel *)model {
    _model = model;
    self.authorLable.text = model.author;
    self.bookNameLabel.text = model.bookName;
    self.bookInfoLabel.text = [NSString stringWithFormat:@"出版信息：%@\n馆藏ID：%@\n已借次数：%@",model.publisher,model.bookId,model.borrowTime];
}

@end
