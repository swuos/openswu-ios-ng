//
//  SWUBookCaseCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import "SWUBookCaseCell.h"
#import "SWULibraryBorrowingModel.h"
#import "SWULibraryHistoryModel.h"
#import "SWULibraryCollectModel.h"
#import "Masonry.h"

@interface SWUBookCaseCell()
@property (nonatomic,strong) UILabel * authorLable;
@property (nonatomic,strong) UILabel * bookNameLabel;
@property (nonatomic,strong) UILabel * bookInfoLabel;
@end

@implementation SWUBookCaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return  self;
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

- (void)setModel:(id)model {
    _model = model;
    if ([model isKindOfClass:[SWULibraryHistoryModel class]]) {
        SWULibraryHistoryModel * model1 = (SWULibraryHistoryModel *)model;
        self.bookNameLabel.text = model1.bookName;
        self.bookInfoLabel.text = [NSString stringWithFormat:@"\n\n%@",model1.returnTime];
    }
    if ([model isKindOfClass:[SWULibraryBorrowingModel class]]) {
        /*
         @property (nonatomic,copy) NSString* bookName;
         @property (nonatomic,copy) NSString* author;
         @property (nonatomic,copy) NSString* fromTime;
         @property (nonatomic,copy) NSString* toTime;
         @property (nonatomic,copy) NSString* renewInfo;*/
        SWULibraryBorrowingModel * model1 = (SWULibraryBorrowingModel *)model;
        self.bookNameLabel.text = model1.bookName;
        self.authorLable.text = model1.author;
        self.bookInfoLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",model1.fromTime,model1.toTime,model1.renewInfo];
    }
    if ([model isKindOfClass:[SWULibraryCollectModel class]]) {
        /*
         @property (nonatomic,copy) NSString * bookName;
         @property (nonatomic,copy) NSString * isbn;
         @property (nonatomic,copy) NSString * author;
         @property (nonatomic,copy) NSString * collectTime;*/
        SWULibraryCollectModel * model1 = (SWULibraryCollectModel *)model;
        self.bookNameLabel.text = model1.bookName;
        self.authorLable.text = model1.author;
        self.bookInfoLabel.text = [NSString stringWithFormat:@"馆藏ID：%@\n%@",model1.isbn,model1.collectTime];
        
        
    }
    
    
    
}

@end
